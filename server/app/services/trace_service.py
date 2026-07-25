import json

from app.core.signoz_client import SignozClient
from app.services.metrics_service import MetricsService
from app.services.incident_service import IncidentService
from app.services.sre_service import SREService
from app.services.sla_service import SLAService
from app.services.capacity_service import CapacityService
from app.services.risk_service import RiskService
from app.services.ai_service import AIService


class TraceService:

    def __init__(self):
        self.signoz_client = SignozClient()
        self.metrics_service = MetricsService()
        self.incident_service = IncidentService()
        self.sre_service = SREService()
        self.sla_service = SLAService()
        self.capacity_service = CapacityService()
        self.risk_service = RiskService()
        self.ai_service = AIService()

    def get_latest_analysis(self):

        result = self.signoz_client.get_recent_traces()

        # Check API response
        if result.get("status_code") != 200:
            return {
                "status": "error",
                "message": "Failed to fetch traces from SigNoz.",
                "response": result
            }

        print("\n========== RAW SIGNOZ RESPONSE ==========")
        print(json.dumps(result, indent=2))
        print("=========================================\n")

        try:
            rows = (
                result.get("response", {})
                .get("data", {})
                .get("data", {})
                .get("results", [{}])[0]
                .get("rows")
            )
        except Exception as e:
            return {
                "status": "error",
                "message": f"Unable to parse SigNoz response: {str(e)}",
                "response": result
            }

        if rows is None:
            return {
                "status": "error",
                "message": "SigNoz returned rows = None",
                "response": result
            }

        print(f"Rows received from SigNoz: {len(rows)}")

        if len(rows) > 0:
            print("\n========== FIRST ROW ==========")
            print(json.dumps(rows[0], indent=2))
            print("===============================\n")

        metrics = self.metrics_service.calculate(rows)

        print("\n========== METRICS ==========")
        print(json.dumps(metrics, indent=2))
        print("=============================\n")

        if not metrics:
            return {
                "status": "error",
                "message": "MetricsService returned empty metrics.",
                "rows_received": len(rows)
            }

        try:
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

        except Exception as e:
            return {
                "status": "error",
                "message": str(e),
                "metrics": metrics
            }

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