class SREService:

    def evaluate(self, metrics, incident):

        overview = metrics["overview"]
        performance = metrics["performance"]

        score = 100
        recommendations = []

        if overview["error_rate"] > 5:
            score -= 30
            recommendations.append(
                "Error rate exceeds SRE threshold (5%)."
            )

        if performance["p95_latency_ms"] > 1000:
            score -= 20
            recommendations.append(
                "P95 latency exceeds 1 second."
            )

        if performance["average_latency_ms"] > 500:
            score -= 10
            recommendations.append(
                "Average latency is above healthy limits."
            )

        score = max(score, 0)

        if score >= 90:
            health = "Excellent"
        elif score >= 75:
            health = "Good"
        elif score >= 50:
            health = "Needs Attention"
        else:
            health = "Critical"

        return {
            "sre_score": score,
            "service_health": health,
            "recommendations": recommendations
        }