#ifndef AIRCRAFTPOSITION_H
#define AIRCRAFTPOSITION_H

#include <QObject>
#include <QQmlEngine>
#include <QString>
#include "models/flexiblemodel.h"


class AircraftPosition : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int roll READ roll WRITE setRoll NOTIFY rollChanged)
    Q_PROPERTY(int pitch READ pitch WRITE setPitch NOTIFY pitchChanged)
    Q_PROPERTY(int yaw READ yaw WRITE setYaw NOTIFY yawChanged)
    Q_PROPERTY(KFlexibleModel* pointsModel READ pointsModel WRITE setPointsModel NOTIFY pointsModelChanged)
    int m_roll = 0;

    int m_pitch = 0;

    int m_yaw = 0;

    KFlexibleModel* m_pointsModel = new KFlexibleModel({"xCoord", "yCoord"}, this);

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

    KFlexibleModel* pointsModel() const
    {
        return m_pointsModel;
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

    void setPointsModel(KFlexibleModel* pointsModel)
    {
        if (m_pointsModel == pointsModel)
            return;

        m_pointsModel = pointsModel;
        emit pointsModelChanged(m_pointsModel);
    }

signals:

    void rollChanged(int roll);
    void pitchChanged(int pitch);
    void yawChanged(int yaw);
    void pointsModelChanged(KFlexibleModel* pointsModel);
};

#endif // AIRCRAFTPOSITION_H
