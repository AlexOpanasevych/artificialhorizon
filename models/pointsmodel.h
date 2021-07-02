#ifndef POINTSMODEL_H
#define POINTSMODEL_H

#include <QAbstractListModel>
#include <QQmlEngine>
#include <QGeoCoordinate>

class PointsModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int size READ size WRITE setSize NOTIFY sizeChanged)
    int m_size = 0;

    enum Roles {Coordinate = Qt::UserRole + 1};

public:
    PointsModel(QObject * parent = nullptr);

    // QAbstractItemModel interface
public:
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;


    int size() const;
public slots:
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    void setSize(int size);

    void appendPoint(const QGeoCoordinate & point);
    void removePoint(int i);
    void insertPoint(int i, const QGeoCoordinate & point);
    QGeoCoordinate insertPointAfter(int i);
    QGeoCoordinate insertPointBefore(int i);

signals:
    void sizeChanged(int size);


    // QAbstractItemModel interface
public:
    QHash<int, QByteArray> roleNames() const override;
private:
    QVector<QGeoCoordinate> m_data;
};

#endif // POINTSMODEL_H
