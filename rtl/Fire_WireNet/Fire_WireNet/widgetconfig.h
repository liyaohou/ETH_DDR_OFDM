#ifndef WIDGETCONFIG_H
#define WIDGETCONFIG_H

#include <QWidget>
#include <QDebug>
namespace Ui {
class WidgetConfig;
}

class WidgetConfig : public QWidget
{
    Q_OBJECT

public:
    explicit WidgetConfig(QWidget *parent = nullptr);
    ~WidgetConfig();

    char* ReadComBox(void);


private:
    Ui::WidgetConfig *ui;
    void combineData(int psduLength, int transmitRate, int powerLevel ,char* data);
};



#endif // WIDGETCONFIG_H
