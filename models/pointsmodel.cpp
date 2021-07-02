#include "pointsmodel.h"

PointsModel::PointsModel(QObject *parent) : QAbstractListModel(parent)
{

}

int PointsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_data.size();
}

QVariant PointsModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid()) {
        auto row = index.row();

        if(row < 0 || row >= m_data.count()) return QVariant();
        if(role == Coordinate) {
            return QVariant::fromValue(m_data.at(row));
        }

    }
    return QVariant();
}

int PointsModel::size() const
{
    return m_size;
}

bool PointsModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Q_UNUSED(role)
    if (index.isValid()) {
        auto newValue = value.value<QGeoCoordinate>();
        if (m_data[index.row()] != newValue) {
            m_data[index.row()] = newValue;
            emit dataChanged(index, index);
            return true;
        }
    }
    return false;
}

void PointsModel::setSize(int size)
{
    if (m_size == size)
        return;

    m_size = size;
    emit sizeChanged(m_size);
}

void PointsModel::appendPoint(const QGeoCoordinate &point)
{
    int pos = m_data.size();
    beginInsertRows(QModelIndex(), pos, pos);
    m_data.push_back(point);
    setSize(m_data.size());
    endInsertRows();
}

void PointsModel::removePoint(int i)
{
    beginRemoveRows(QModelIndex(), i, i);
    m_data.remove(i);
    setSize(m_data.size());
    endRemoveRows();
}

void PointsModel::insertPoint(int i, const QGeoCoordinate &point)
{
    beginInsertRows(QModelIndex(), i, i);
    m_data.insert(i, point);
    setSize(m_data.size());
    endInsertRows();
}

QGeoCoordinate PointsModel::insertPointAfter(int i)
{
    auto pointBefore = m_data.at(i + 1);
    auto currentPoint = m_data.at(i);
    auto newPoint = QGeoCoordinate((pointBefore.latitude() + currentPoint.latitude()) / 2, (pointBefore.longitude() + currentPoint.longitude()) / 2);
    insertPoint(i + 1, newPoint);
    return newPoint;
}

QGeoCoordinate PointsModel::insertPointBefore(int i)
{
    auto pointBefore = m_data.at(i - 1);
    auto currentPoint = m_data.at(i);
    auto newPoint = QGeoCoordinate((pointBefore.latitude() + currentPoint.latitude()) / 2, (pointBefore.longitude() + currentPoint.longitude()) / 2);
    insertPoint(i, newPoint);
    return newPoint;
}

QHash<int, QByteArray> PointsModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[Coordinate] = "coordinate";
    return names;
}
