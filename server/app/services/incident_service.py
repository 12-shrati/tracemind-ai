import random
import time

from opentelemetry import trace

tracer = trace.get_tracer(__name__)


class IncidentService:

    def simulate(self, incident_type: str):

        with tracer.start_as_current_span("Validate Incident"):
            time.sleep(0.2)

        if incident_type == "slow_database":
            return self.slow_database()

        elif incident_type == "payment_timeout":
            return self.payment_timeout()

        elif incident_type == "external_api_failure":
            return self.external_api_failure()

        else:
            return {
                "status": "unknown incident"
            }

    def slow_database(self):

        with tracer.start_as_current_span("Database Query"):
            time.sleep(3)

        return {
            "incident": "slow_database",
            "status": "completed"
        }

    def payment_timeout(self):

        with tracer.start_as_current_span("Payment Gateway"):

            time.sleep(5)

        return {
            "incident": "payment_timeout",
            "status": "timeout simulated"
        }

    def external_api_failure(self):

        with tracer.start_as_current_span("External Weather API"):

            time.sleep(1)

            raise Exception("External API unavailable")