#include "widget.h"
#include "ui_widget.h"

#include <QBuffer>
#include <QFile>
#include <QFileDialog>




#define MAX_REC_SIZE 512
#define MAX_SEND_SIZE 512


Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget)
{
    ui->setupUi(this);
    udpSocket = new QUdpSocket(this);


    //设置为UDP并获得本地主机所有ipv4的IP地址
    ui->comboBoxNet->setCurrentIndex(0);
    QList<QHostAddress> listHostAddress = QNetworkInterface::allAddresses();
    for(QHostAddress hostAddress : listHostAddress){
        if(hostAddress.protocol()==QAbstractSocket::IPv4Protocol)
            ui->comboBoxHostIp->addItem(hostAddress.toString());
    }
    ui->labelState->setText("receiving data (not file).");
    //信号与槽的绑定
    //btn*2//建立连接//断开连接
    connect(ui->btnConnect,&QPushButton::clicked,this,&Widget::slot_btnConnectClicked);
    connect(ui->btnDisConnect,SIGNAL(clicked()),this,SLOT(slot_btnDisConnectClicked()));
    //udp/接收数据
    connect(udpSocket, &QUdpSocket::readyRead, this, &Widget::slot_udpSocketReadReady);
    //btn*2//udp发送数据//清空接收
    connect(ui->btnSend, &QPushButton::clicked, this, &Widget::slot_btnSendClicked);
    connect(ui->btnRecordClear, &QPushButton::clicked, this, &Widget::slot_btnRecordClearClicked);
    //btn*4//发送文件//接收文件//接收文件开始//结束接收文件
    connect(ui->btnSendFile, &QPushButton::clicked, this, &Widget::slot_btnSendFileClicked);
    connect(ui->btnRecFileBegin, &QPushButton::clicked, this, &Widget::slot_btnRecFileBeginClicked);
    connect(ui->btnRecFileEnd, &QPushButton::clicked, this, &Widget::slot_btnRecFileEndClicked);
    connect(this, &Widget::signal_recFileDown, this, &Widget::slot_recFileDown);
    //combox*1//是否发送配置信息
    connect(ui->checkBoxConfig,&QCheckBox::checkStateChanged,this ,&Widget::slot_checkBoxConfigChanged);
}

Widget::~Widget()
{
    delete ui;
}


//1、按键---建立连接
void Widget::slot_btnConnectClicked()
{
    //获取设置的本地地址、端口并绑定
    const QHostAddress dstAddress(ui->comboBoxHostIp->currentText() );
    if(!udpSocket->bind(dstAddress,ui->textHostPort->text().toInt())){
        qDebug() << "UDP bind Error!!!";
        return;
    }else{
        if(udpSocket->state() == QAbstractSocket::BoundState){
            //已绑定到特定ipv4地址和端口
            qDebug()<<QAbstractSocket::BoundState;
            ui->btnConnect->setEnabled(false);
            ui->btnDisConnect->setEnabled(true);
            netConnectSetState(false);
        }
    }
}

//2、按键---断开连接
void Widget::slot_btnDisConnectClicked()
{
    udpSocket->abort();
    if(udpSocket->state() == QAbstractSocket::UnconnectedState){
        //已接触绑定断开连接
        qDebug()<<QAbstractSocket::UnconnectedState;
        ui->btnConnect->setEnabled(true);
        ui->btnDisConnect->setEnabled(false);
        netConnectSetState(true);

        //按键与状态使能切换
        ui->btnRecFileBegin->setEnabled(true);
        ui->btnRecFileEnd->setEnabled(false);
        isUdpReceivingFile = false;
    }
}

//3、UDP---读取到数据
void Widget::slot_udpSocketReadReady()
{
    //判断数据报是否有数据
    if(udpSocket->hasPendingDatagrams()){
        //判断收发双方的ipv4地址和port
        QNetworkDatagram recDatagram = udpSocket->receiveDatagram(MAX_REC_SIZE);
        if(recDatagram.destinationAddress()==QHostAddress(ui->comboBoxHostIp->currentText())
            &&recDatagram.destinationPort()==ui->textHostPort->text().toInt()
            &&recDatagram.senderAddress()==QHostAddress(ui->textDstIp->text())
            &&recDatagram.senderPort()==ui->textDstPort->text().toInt()
            ){
            //接收：原始数据？文件
            if(!isUdpReceivingFile){
                //1\接收原始数据
                //判断是否自动换行并追加显示
                if(ui->checkBoxRecTurnLine->checkState()==Qt::Checked)
                    ui->textRecord->append("remote: "+recDatagram.data()+'\n');
                else
                    ui->textRecord->append("remote: "+recDatagram.data());
            }else{
                //2\接收文件
                static int silceNum=0;
                ui->textRecord->append("Num "+QString::number(silceNum++)+" silce in\n");
                mapRecStr += recDatagram.data();
                mapRecStrSize += recDatagram.data().size();
                qDebug() << mapRecStrSize <<   "   "  << mapRecStr[mapRecStr.size()-1] <<  "   "  << mapRecStr[mapRecStr.size()-2];

                if(mapRecStrSize%64==0&&
                    mapRecStr[mapRecStr.size()-1]==QChar(0x00d9)&&
                    (mapRecStr[mapRecStr.size()-2]==QChar(0x00d9)||mapRecStr[mapRecStr.size()-2]==QChar(0x00ff))){
                    silceNum = 0;
                    emit signal_recFileDown();
                }
            }
        }
    }
}


//4、按键---发送数据
void Widget::slot_btnSendClicked()
{
    //在本地bind正常时
    if(udpSocket->state() == QAbstractSocket::BoundState){
        //检测是否发送新行
        QString udpDataToSend;
        if(ui->checkBoxSendTurnLine->checkState()==Qt::Checked)
            udpDataToSend = ui->textSend->toPlainText()+'\n';
        else
            udpDataToSend = ui->textSend->toPlainText();
        //进行发送
        udpSocket->writeDatagram(udpDataToSend.toStdString().c_str(),sizeof(ui->textSend->toPlainText()),
                                         QHostAddress(ui->textDstIp->text()),ui->textDstPort->text().toInt());
        //追加显示
        ui->textRecord->append("local : "+udpDataToSend);

        sendConfigDat(isSendConfigEn);
    }
}
//5、按键---清空数据日志
void Widget::slot_btnRecordClearClicked()
{
    ui->textRecord->clear();
}
//6、发送文件(文件->数据->UDP)
void Widget::slot_btnSendFileClicked()
{
    //打开文件选择对话框获取文件名
    QString fileName = QFileDialog::getOpenFileName(this, tr("Open --- Select a .jpg file and open it!"),
                                                    "../../Files",
                                                    tr("Any files (*);;Images (*.jpg)"));
    if(!fileName.isNull()){
        ui->textRecord->append("Send a .jpg file from:\n"+fileName+'\n');
        //打开文件并读取文件内容
        QPixmap mapToSend(fileName);
        QBuffer mapBuff;
        mapToSend.save(&mapBuff,"JPG");
        QString mapStrToSend = mapBuff.data().toBase64();

        //切片发送并关闭文件
        QStringList slicesToSend = silceQstring(mapStrToSend,512,64);
        for(QString sliceToSend : slicesToSend){
            udpSocket->writeDatagram(sliceToSend.toStdString().c_str(),sliceToSend.size(),
                                     QHostAddress(ui->textDstIp->text()),ui->textDstPort->text().toInt());
            sleepMs(100);
        }
        sendConfigDat(isSendConfigEn);
    }
}
//7、开始接收文件
void Widget::slot_btnRecFileBeginClicked()
{
    // 清空接受内存
    mapRecStrSize = 0;
    mapRecStr.clear();
    if(udpSocket->state() == QAbstractSocket::BoundState){
        ui->labelState->setText("receiving file (not data).");
        ui->textRecord->append("Receive a file. Waiting!!!\n");
        ui->btnRecFileBegin->setEnabled(false);
        ui->btnRecFileEnd->setEnabled(true);
        isUdpReceivingFile = true;
    }
}

//8、通过该按键---提前触发接收完成的槽函数
void Widget::slot_btnRecFileEndClicked()
{
    if(udpSocket->state() == QAbstractSocket::BoundState&&isUdpReceivingFile){
        emit signal_recFileDown();
    }
}


//9、完成接收(数据到文件)
void Widget::slot_recFileDown()
{
    // 删除接收数据报的桢尾
    clearStrEnds(mapRecStr);
    // 保存文件名
    QString fileName = QFileDialog::getSaveFileName(this, tr("Save --- Select a .jpg file and save it!"),
                                                    "../../Files",
                                                    tr("Any files (*);;Images (*.jpg)"));
    // 数据载入图片
    QPixmap mapRec;
    mapRec.loadFromData(    QByteArray::fromBase64(mapRecStr.toUtf8())    );
    mapRec.save(fileName,"JPG");
    // 清空接受内存
    mapRecStrSize = 0;
    mapRecStr.clear();
    // 按键与状态使能切换
    ui->btnRecFileBegin->setEnabled(true);
    ui->btnRecFileEnd->setEnabled(false);
    isUdpReceivingFile = false;
}

void Widget::slot_checkBoxConfigChanged(Qt::CheckState state)
{
    qDebug() << "slot_checkBoxConfigChanged In";
    isSendConfigEn = state;
}






/**************************************************************************/
/**************************************************************************/

//发送配置信息
void Widget::sendConfigDat(bool state)
{

    if(state != true)return ;
    char *configDat = ui->configWidget->ReadComBox();//获取data值；
    //进行发送
    qDebug() << "sendConfigDat In";
    udpSocket->writeDatagram(configDat,3,
                             QHostAddress(ui->textDstIp->text()),ui->textDstPort->text().toInt());
}


//连接设置出批量按键状态切换函数
void Widget::netConnectSetState(bool state)
{
    ui->textDstIp->setEnabled(state);
    ui->comboBoxHostIp->setEnabled(state);
    ui->textDstPort->setEnabled(state);
    ui->textHostPort->setEnabled(state);
    ui->comboBoxNet->setEnabled(state);
}


//数据报切片函数
QStringList Widget::silceQstring(QString &input, int sliceSize,int slice_min)
{
    QStringList slices;
    int totalSize = input.size();
    int numSlices = (totalSize + sliceSize - 1) / sliceSize;
    for (int i = 0; i < numSlices; ++i) {
        // 初步计算每一片的start、end,并从中进行切片
        int start = i * sliceSize;
        int end   = std::min(start + sliceSize, totalSize);
        QString slice = input.mid(start, end - start);

        // 如果是最后一片，并且长度不是slice_min的倍数，0xD9
        if (i == numSlices - 1 && (end - start) % slice_min != 0) {
            int paddingSize = slice_min - (end - start) % slice_min;
            slice.append(QString(paddingSize, QChar(0xD9)));
        }
        //  将切片并补零后的QString添加到List
        slices.append(slice);
    }
    return slices;
}

//数据报去尾函数
void Widget::clearStrEnds(QString &strIn)
{
    QChar lastChar = strIn[strIn.length() - 1];
    int posStr = strIn.length() - 1;
    // 从字符串末尾开始向前遍历，直到不再有连续重复的字符
    while (posStr > 0 && strIn[posStr - 1] == lastChar) {
        posStr--;
    }
    // 如果找到了连续重复的字符，就截断字符串
    if (posStr < strIn.length() - 1) {
        strIn.chop(strIn.length() - posStr);
    }
}

void Widget::sleepMs(int ms)
{
    QTime _Timer = QTime::currentTime();
    QTime _NowTimer;
    do{
        _NowTimer = QTime::currentTime();
    }while (_Timer.msecsTo(_NowTimer)<= ms);
}



