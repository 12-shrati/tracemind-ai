class SLAService:

    def evaluate(self, metrics):

        p95 = metrics["performance"]["p95_latency_ms"]
        error_rate = metrics["overview"]["error_rate"]

        latency_target = 500

        return {
            "latency_sla_met": p95 <= latency_target,
            "availability_sla": "99.9%",
            "latency_target_ms": latency_target,
            "current_p95_ms": p95,
            "current_error_rate": error_rate,
            "error_budget_remaining": max(0, 100 - error_rate)
        }