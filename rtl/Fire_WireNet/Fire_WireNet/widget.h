#ifndef WIDGET_H
#define WIDGET_H


#include <QWidget>
#include <QDebug>
#include <QUdpSocket>
#include <QNetworkInterface>
#include <QNetworkDatagram>

QT_BEGIN_NAMESPACE
namespace Ui {
class Widget;
}
QT_END_NAMESPACE

class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();




private
slots:
    void slot_btnConnectClicked(void);
    void slot_btnDisConnectClicked(void);
    void slot_udpSocketReadReady(void);
    void slot_btnSendClicked(void);
    void slot_btnRecordClearClicked(void);
    void slot_btnSendFileClicked(void);
    void slot_btnRecFileBeginClicked(void);
    void slot_btnRecFileEndClicked(void);
    void slot_recFileDown(void);
    void slot_checkBoxConfigChanged(Qt::CheckState state);

signals:
    void signal_recFileDown(void);


private:
    Ui::Widget *ui;
    QUdpSocket *udpSocket;
    bool        isUdpReceivingFile = false;
    bool        isSendConfigEn ;
    QString     mapRecStr;
    int         mapRecStrSize;

    void sendConfigDat(bool state);
    void netConnectSetState(bool state);
    QStringList silceQstring(QString& input, int sliceSize,int slice_min);
    void clearStrEnds(QString& strIn);
    void sleepMs(int ms);
};
#endif // WIDGET_H
