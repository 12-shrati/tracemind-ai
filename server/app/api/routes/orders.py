from fastapi import APIRouter
import time
from opentelemetry import trace

router = APIRouter(prefix="/orders", tags=["Orders"])

tracer = trace.get_tracer(__name__)

@router.get("/")
def get_orders():

    with tracer.start_as_current_span("Validate User"):
        time.sleep(0.2)

    with tracer.start_as_current_span("Fetch Orders from Database"):
        time.sleep(0.8)

    with tracer.start_as_current_span("Calculate Total"):
        time.sleep(0.3)

    return {
        "orders": [
            {
                "id": 101,
                "customer": "Alice",
                "amount": 499
            },
            {
                "id": 102,
                "customer": "Bob",
                "amount": 899
            }
        ]
    }