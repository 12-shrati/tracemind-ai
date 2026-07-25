class TraceParser:

    @staticmethod
    def parse(rows):

        total_traces = len(rows)

        errors = [
            row for row in rows
            if row["data"].get("response_status_code", "").startswith(("4", "5"))
        ]

        slowest = max(
            rows,
            key=lambda x: x["data"].get("duration_nano", 0)
        )

        return {
            "total_traces": total_traces,
            "error_count": len(errors),
            "slowest_endpoint": slowest["data"]["name"],
            "slowest_duration_ms":
                round(
                    slowest["data"]["duration_nano"] / 1_000_000,
                    2
                ),
            "errors": [
                {
                    "endpoint": e["data"]["name"],
                    "status": e["data"]["response_status_code"]
                }
                for e in errors
            ]
        }