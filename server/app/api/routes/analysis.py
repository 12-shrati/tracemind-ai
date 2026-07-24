from fastapi import APIRouter
from app.services.trace_service import TraceService

router = APIRouter(
    prefix="/analysis",
    tags=["Analysis"]
)

service = TraceService()

@router.get("/latest")
def latest_analysis():
    return service.get_latest_analysis()