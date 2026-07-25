class IncidentService:

    def evaluate(self, metrics):

        overview = metrics.get("overview", {})
        performance = metrics.get("performance", {})

        error_rate = overview.get("error_rate", 0)
        p95 = performance.get("p95_latency_ms", 0)
        avg = performance.get("average_latency_ms", 0)

        incident = {
            "health": "Healthy",
            "severity": "INFO",
            "incident": "System operating normally",
            "confidence": 100,
            "alerts": []
        }

        if error_rate >= 20:
            incident.update({
            "health": "Critical",
            "severity": "SEV-1",
            "status": "Active",
            "incident": "High error rate detected",
            "confidence": 98,
            "affected_service": "tracemind-ai-backend",
            "detected_at": "2026-07-25T06:41:17Z",
            "alerts": [
                "Error rate above 20%"
            ]
            })

        elif p95 >= 5000:
            incident.update({
                "health": "Degraded",
                "severity": "SEV-2",
                "incident": "High latency detected",
                "confidence": 95,
                "alerts": [
                    "P95 latency above 5 seconds"
                ]
            })

        elif avg >= 1000:
            incident.update({
                "health": "Warning",
                "severity": "SEV-3",
                "incident": "Average latency is high",
                "confidence": 90,
                "alerts": [
                    "Average latency above 1 second"
                ]
            })

        return incident