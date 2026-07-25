from app.core.gemini_client import GeminiClient


class AIService:

    def __init__(self):
        self.client = GeminiClient()

    def analyze(self, analysis_data):

        return self.client.analyze_incident(analysis_data)