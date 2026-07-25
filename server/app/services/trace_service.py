from app.core.signoz_client import SignozClient
from app.services.metrics_service import MetricsService
from app.services.incident_service import IncidentService
from app.services.ai_service import AIService
from app.services.sre_service import SREService
from app.services.sla_service import SLAService
from app.services.capacity_service import CapacityService
from app.services.risk_service import RiskService

import json


class TraceService:

    def __init__(self):
        self.signoz_client = SignozClient()

        self.metrics_service = MetricsService()
        self.incident_service = IncidentService()
        self.ai_service = AIService()

        self.sre_service = SREService()
        self.sla_service = SLAService()
        self.capacity_service = CapacityService()
        self.risk_service = RiskService()

    def get_latest_analysis(self):

        result = self.signoz_client.get_recent_traces()

        if result["status_code"] != 200:
            return {
                "status": "error",
                "message": "Failed to fetch traces."
            }

        rows = result["response"]["data"]["data"]["results"][0]["rows"]

        metrics = self.metrics_service.calculate(rows)

        incident = self.incident_service.evaluate(metrics)

        sre = self.sre_service.evaluate(metrics, incident)

        sla = self.sla_service.evaluate(metrics)

        capacity = self.capacity_service.evaluate(metrics)

        risk = self.risk_service.evaluate(metrics)

        ai_analysis = self.ai_service.analyze({
            "metrics": metrics,
            "incident": incident,
            "sre": sre,
            "sla": sla,
            "capacity": capacity,
            "risk": risk
        })

        return {
            "status": "success",
            "metrics": metrics,
            "incident": incident,
            "sre_analysis": sre,
            "sla_analysis": sla,
            "capacity_analysis": capacity,
            "risk_analysis": risk,
            "ai_analysis": ai_analysis
        }