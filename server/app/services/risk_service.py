class RiskService:

    def evaluate(self, metrics):

        error_rate = metrics["overview"]["error_rate"]
        p95 = metrics["performance"]["p95_latency_ms"]

        if error_rate > 20:
            return {
                "risk_level": "High",
                "probability": "95%",
                "reason": "Critical error rate detected",
                "business_impact": "Customer requests may fail"
            }

        if error_rate > 5 or p95 > 1000:
            return {
                "risk_level": "Medium",
                "probability": "70%",
                "reason": "Performance degradation",
                "business_impact": "Slower user experience"
            }

        return {
            "risk_level": "Low",
            "probability": "10%",
            "reason": "Healthy service",
            "business_impact": "Minimal"
        }