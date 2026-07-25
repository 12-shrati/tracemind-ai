class CapacityService:

    def evaluate(self, metrics):

        requests = metrics["overview"]["total_requests"]

        if requests < 100:
            utilization = 10
            traffic = "Low"
            recommendation = "No scaling required"

        elif requests < 1000:
            utilization = 55
            traffic = "Medium"
            recommendation = "Monitor traffic"

        else:
            utilization = 90
            traffic = "High"
            recommendation = "Scale horizontally"

        return {
            "traffic_level": traffic,
            "requests": requests,
            "capacity_utilization": f"{utilization}%",
            "recommended_action": recommendation
        }