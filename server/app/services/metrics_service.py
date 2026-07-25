from collections import defaultdict
from statistics import mean, median

class MetricsService:

    def calculate(self, rows):

        if not rows:
            return {}

        latencies = []
        endpoint_stats = defaultdict(list)
        status_counts = defaultdict(int)

        success = 0
        failed = 0

        for row in rows:

            data = row.get("data", {})

            latency = data.get("duration_nano", 0) / 1_000_000
            endpoint = data.get("name", "Unknown")

            # Ignore internal OpenTelemetry spans
            if endpoint.endswith("http send"):
                continue

            # Ignore Swagger endpoints
            if endpoint in ["GET /docs", "GET /openapi.json", "GET /redoc"]:
                continue

            # Get HTTP status code
            status = str(data.get("response_status_code", "")).strip()

             # Ignore spans without a valid HTTP status
            if not status:
                continue

            latencies.append(latency)
            endpoint_stats[endpoint].append(latency)
            status_counts[status] += 1

            if str(status).startswith("2"):
                success += 1
            else:
                failed += 1

        latencies.sort()

        total = len(latencies)

        def percentile(values, p):
            if not values:
                return 0
            index = int(len(values) * p / 100)
            index = min(index, len(values) - 1)
            return round(values[index], 2)

        slowest = []

        for endpoint, values in endpoint_stats.items():

            slowest.append({
                "endpoint": endpoint,
                "avg_latency_ms": round(mean(values), 2),
                "max_latency_ms": round(max(values), 2),
                "requests": len(values)
            })

        slowest.sort(
            key=lambda x: x["avg_latency_ms"],
            reverse=True
        )

        return {

            "overview": {

                "total_requests": total,
                "successful_requests": success,
                "failed_requests": failed,
                "error_rate": round((failed / total) * 100, 2)

            },

            "performance": {

                "average_latency_ms": round(mean(latencies), 2),
                "median_latency_ms": round(median(latencies), 2),
                "p95_latency_ms": percentile(latencies, 95),
                "p99_latency_ms": percentile(latencies, 99),
                "max_latency_ms": round(max(latencies), 2)

            },

            "status_codes": dict(status_counts),

            "top_slowest_endpoints": slowest[:5]

        }