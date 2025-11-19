from pydantic import BaseModel
from typing import Optional
from datetime import datetime, time


class Computer(BaseModel):
    name: str
    start_time: Optional[str] = "00:00.00"
    current_time: Optional[str] = "00:00"
    duration: str = "0 hrs"
    availability: str = "Available"
    status: str = "available"  # "available" or "busy"
    timer_active: bool = False
    timer_expired: bool = False
    time_remaining: str = ""
    timer_minutes: int = 0
    
    def to_qml_dict(self) -> dict:
        """Convert to dictionary format expected by QML ListModel"""
        return {
            "name": self.name,
            "startTime": self.start_time,
            "currentTime": self.current_time,
            "duration": self.duration,
            "availability": self.availability,
            "status": self.status,
            "timerActive": self.timer_active,
            "timerExpired": self.timer_expired,
            "timeRemaining": self.time_remaining,
            "timerMinutes": self.timer_minutes
        }