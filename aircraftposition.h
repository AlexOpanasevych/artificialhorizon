#ifndef AIRCRAFTPOSITION_H
#define AIRCRAFTPOSITION_H

#include <QObject>
#include <QQmlEngine>
#include <QString>


class AircraftPosition : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int roll READ roll WRITE setRoll NOTIFY rollChanged)
    Q_PROPERTY(int pitch READ pitch WRITE setPitch NOTIFY pitchChanged)
    Q_PROPERTY(int yaw READ yaw WRITE setYaw NOTIFY yawChanged)
    int m_roll = 0;

    int m_pitch = 0;

    int m_yaw = 0;

public:
    explicit AircraftPosition(QObject *parent = nullptr);

    int roll() const
    {
        return m_roll;
    }

    int pitch() const
    {
        return m_pitch;
    }

    int yaw() const
    {
        return m_yaw;
    }

public slots:
    void setRoll(int roll)
    {
        if (m_roll == roll)
            return;

        m_roll = roll;
        emit rollChanged(m_roll);
    }

    void setPitch(int pitch)
    {
        if (m_pitch == pitch)
            return;

        m_pitch = pitch;
        emit pitchChanged(m_pitch);
    }

    void setYaw(int yaw)
    {
        if (m_yaw == yaw)
            return;

        m_yaw = yaw;
        emit yawChanged(m_yaw);
    }

signals:

    void rollChanged(int roll);
    void pitchChanged(int pitch);
    void yawChanged(int yaw);
};

#endif // AIRCRAFTPOSITION_H
