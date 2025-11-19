from PySide6.QtCore import QAbstractListModel, QModelIndex, Qt, Signal, Slot
from PySide6.QtQml import QmlElement
from typing import List, Any
from .computer import Computer

QML_IMPORT_NAME = "CyberMaster"
QML_IMPORT_MAJOR_VERSION = 1


@QmlElement
class ComputerListModel(QAbstractListModel):
    
    # Define roles for QML access
    NameRole = Qt.UserRole + 1
    StartTimeRole = Qt.UserRole + 2
    CurrentTimeRole = Qt.UserRole + 3
    DurationRole = Qt.UserRole + 4
    AvailabilityRole = Qt.UserRole + 5
    StatusRole = Qt.UserRole + 6
    TimerActiveRole = Qt.UserRole + 7
    TimerExpiredRole = Qt.UserRole + 8
    TimeRemainingRole = Qt.UserRole + 9
    TimerMinutesRole = Qt.UserRole + 10
    
    def __init__(self, parent=None):
        super().__init__(parent)
        self._computers: List[Computer] = []
        self._initialize_sample_data()
    
    def _initialize_sample_data(self):
        """Initialize with sample computer data"""
        print("Initializing sample computer data...")
        sample_computers = [
            Computer(name="Comp1"),
            Computer(name="Comp2"),
            Computer(
                name="Comp3",
                start_time="10:15.00",
                current_time="12:30",
                duration="2 hrs 15 min",
                availability="Busy",
                status="busy"
            ),
            Computer(
                name="Comp4",
                start_time="11:00.00",
                current_time="12:30",
                duration="1 hr 30 min",
                availability="Busy",
                status="busy",
                timer_active=True,
                time_remaining="15:30",
                timer_minutes=45
            ),
            Computer(
                name="Comp5",
                start_time="09:30.00",
                current_time="12:30",
                duration="3 hrs",
                availability="Busy",
                status="busy",
                timer_active=True,
                timer_expired=True,
                time_remaining="0:00",
                timer_minutes=120
            ),
            Computer(name="Comp6")
        ]
        
        self.beginInsertRows(QModelIndex(), 0, len(sample_computers) - 1)
        self._computers = sample_computers
        self.endInsertRows()
        print(f"Initialized {len(self._computers)} computers")
    
    def roleNames(self):
        return {
            self.NameRole: b"name",
            self.StartTimeRole: b"startTime",
            self.CurrentTimeRole: b"currentTime",
            self.DurationRole: b"duration",
            self.AvailabilityRole: b"availability",
            self.StatusRole: b"status",
            self.TimerActiveRole: b"timerActive",
            self.TimerExpiredRole: b"timerExpired",
            self.TimeRemainingRole: b"timeRemaining",
            self.TimerMinutesRole: b"timerMinutes"
        }
    
    def rowCount(self, parent=QModelIndex()):
        count = len(self._computers)
        print(f"rowCount called: {count}")
        return count
    
    def data(self, index: QModelIndex, role: int = Qt.DisplayRole):
        print(f"data called: index={index.row()}, role={role}")
        if not index.isValid() or index.row() >= len(self._computers):
            return None
        
        computer = self._computers[index.row()]
        
        if role == self.NameRole:
            return computer.name
        elif role == self.StartTimeRole:
            return computer.start_time
        elif role == self.CurrentTimeRole:
            return computer.current_time
        elif role == self.DurationRole:
            return computer.duration
        elif role == self.AvailabilityRole:
            return computer.availability
        elif role == self.StatusRole:
            return computer.status
        elif role == self.TimerActiveRole:
            return computer.timer_active
        elif role == self.TimerExpiredRole:
            return computer.timer_expired
        elif role == self.TimeRemainingRole:
            return computer.time_remaining
        elif role == self.TimerMinutesRole:
            return computer.timer_minutes
        
        return None
    
    def setData(self, index: QModelIndex, value: Any, role: int = Qt.EditRole) -> bool:
        if not index.isValid() or index.row() >= len(self._computers):
            return False
        
        computer = self._computers[index.row()]
        
        if role == self.StatusRole:
            computer.status = value
        elif role == self.AvailabilityRole:
            computer.availability = value
        elif role == self.TimerActiveRole:
            computer.timer_active = value
        elif role == self.TimerExpiredRole:
            computer.timer_expired = value
        elif role == self.TimeRemainingRole:
            computer.time_remaining = value
        elif role == self.TimerMinutesRole:
            computer.timer_minutes = value
        else:
            return False
        
        self.dataChanged.emit(index, index, [role])
        return True
    
    @Slot(int, str, "QVariant")
    def setProperty(self, index: int, property_name: str, value):
        """Set property by name (for QML compatibility)"""
        if index < 0 or index >= len(self._computers):
            return
        
        role_map = {
            "status": self.StatusRole,
            "availability": self.AvailabilityRole,
            "timerActive": self.TimerActiveRole,
            "timerExpired": self.TimerExpiredRole,
            "timeRemaining": self.TimeRemainingRole,
            "timerMinutes": self.TimerMinutesRole
        }
        
        if property_name in role_map:
            model_index = self.createIndex(index, 0)
            self.setData(model_index, value, role_map[property_name])
    
    @Slot(int, result="QVariant")
    def get(self, index: int):
        """Get item as dictionary (for QML compatibility)"""
        if index < 0 or index >= len(self._computers):
            return {}
        
        computer = self._computers[index]
        return {
            "name": computer.name,
            "startTime": computer.start_time,
            "currentTime": computer.current_time,
            "duration": computer.duration,
            "availability": computer.availability,
            "status": computer.status,
            "timerActive": computer.timer_active,
            "timerExpired": computer.timer_expired,
            "timeRemaining": computer.time_remaining,
            "timerMinutes": computer.timer_minutes
        }