from fastapi import APIRouter
from pydantic import BaseModel

from app.services.incident_service import IncidentService

router = APIRouter(prefix="/incidents", tags=["Incidents"])

service = IncidentService()


class IncidentRequest(BaseModel):
    type: str


@router.post("/simulate")
def simulate(request: IncidentRequest):

    return service.simulate(request.type)