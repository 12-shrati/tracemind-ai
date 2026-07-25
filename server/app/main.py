from fastapi import FastAPI
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor

from app.telemetry import setup_telemetry

from app.api.routes.users import router as users_router
from app.api.routes.orders import router as orders_router
from app.api.routes.incidents import router as incidents_router
from app.api.routes.analysis import router as analysis_router
from pydantic import BaseModel
from app.services.ai_service import AIService

# Initialize OpenTelemetry
setup_telemetry()

app = FastAPI(
    title="TraceMind AI",
    description="AI-powered Incident Copilot using SigNoz & OpenTelemetry",
    version="1.0.0"
)

# Automatically trace all FastAPI requests
FastAPIInstrumentor.instrument_app(app)

# Register Routes
app.include_router(users_router)
app.include_router(orders_router)
app.include_router(incidents_router)
app.include_router(analysis_router)

ai_service = AIService()

class ChatRequest(BaseModel):
    question: str
    dashboard: dict

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


# Temporary endpoint to generate traces
@app.get("/test")
def test():
    return {
        "message": "Telemetry is working!"
    }

# Temporary endpoint for AI chat
@app.post("/chat")
async def chat(request: ChatRequest):

    prompt = f"""
You are TraceMind AI, an AI-powered SRE assistant.

Current Dashboard:
{request.dashboard}

User Question:
{request.question}

Answer using only the dashboard information.
Be concise and actionable.
"""

    answer = ai_service.chat(prompt)

    return {
        "answer": answer
    }