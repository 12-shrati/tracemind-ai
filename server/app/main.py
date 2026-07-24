from fastapi import FastAPI

from app.api.routes.users import router as users_router
from app.api.routes.orders import router as orders_router
from app.api.routes.incidents import router as incidents_router

app = FastAPI(
    title="TraceMind AI",
    description="AI-powered Incident Copilot using SigNoz & OpenTelemetry",
    version="1.0.0"
)

app.include_router(users_router)
app.include_router(orders_router)
app.include_router(incidents_router)

@app.get("/")
def root():
    return {
        "project": "TraceMind AI",
        "status": "running"
    }

@app.get("/health")
def health():
    return {
        "status": "healthy"
    }