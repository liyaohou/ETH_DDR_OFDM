#include "widgetconfig.h"
#include "ui_widgetconfig.h"

WidgetConfig::WidgetConfig(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::WidgetConfig)
{
    ui->setupUi(this);
}

WidgetConfig::~WidgetConfig()
{
    delete ui;
}

//函数读取三个combox的值并上传到上层。以char型上传三个
char* WidgetConfig::ReadComBox()
{
    char *data = new char(3);
    int snedLength = ui->comboBoxPSDU->currentText().toInt();
    int snedRate = ui->comboBoxRate->currentText().toInt();
    int snedPower = ui->comboBoxPower->currentText().toInt();
    //调用config拼接函数，进行数据拼接，并输出。
    combineData(snedLength,snedRate,snedPower,data);
    return data;
}


// 函数用于将12位的PDU帧长、6位的发送速率和3位的发射功率分解合并
void WidgetConfig::combineData(int psduLength, int transmitRate, int powerLevel ,char* data)
{
    /*
        0   0   0   Len Len Len Len Len
        Len Len Len Len Len Len Len Rat
        Rat Rat Rat Rat Rat Pwr Pwr Pwr
    */

    // 确保每个参数只保留有效位
    psduLength &= 0xFFF;    // 保留低12位
    transmitRate &= 0x3F;   // 保留低6位
    powerLevel &= 0x07;     // 保留低3位

    // 第三个字节：
    data[2] = static_cast<char>( (psduLength >> 7) & 0x1F  );
    // 第二个字节：
    data[1] = static_cast<char>( ((psduLength   << 1)&0xFE) | ((transmitRate >> 5)&0x01));
    // 第一个字节：
    data[0] = static_cast<char>( ((transmitRate << 3)&0xF8) | (powerLevel&0x07));
}
