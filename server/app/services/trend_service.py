class TrendService:

    def analyze(self, history):

        if len(history) < 2:
            return {
                "trend": "Not enough data"
            }

        latest = history[-1]
        previous = history[-2]

        latest_p95 = latest["metrics"]["performance"]["p95_latency_ms"]
        previous_p95 = previous["metrics"]["performance"]["p95_latency_ms"]

        change = latest_p95 - previous_p95

        return {
            "latency_change_ms": round(change, 2),
            "improving": change < 0
        }