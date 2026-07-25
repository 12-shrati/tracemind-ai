from collections import deque
from datetime import datetime


class HistoryService:

    def __init__(self):
        self.history = deque(maxlen=20)

    def save(self, metrics, incident):

        snapshot = {
            "timestamp": datetime.utcnow().isoformat(),
            "metrics": metrics,
            "incident": incident
        }

        self.history.append(snapshot)

    def get_history(self):
        return list(self.history)