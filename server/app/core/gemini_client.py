import json
import os

from dotenv import load_dotenv
from google import genai

load_dotenv()


class GeminiClient:

    def __init__(self):
        self.client = genai.Client(
            api_key=os.getenv("GEMINI_API_KEY")
        )

    def analyze_incident(self, analysis_data):

        prompt = f"""
You are an expert Site Reliability Engineer.

Metrics:
{json.dumps(analysis_data["metrics"], indent=2)}

Incident:
{json.dumps(analysis_data["incident"], indent=2)}

SRE Analysis:
{json.dumps(analysis_data["sre"], indent=2)}

SLA Analysis:
{json.dumps(analysis_data["sla"], indent=2)}

Capacity Analysis:
{json.dumps(analysis_data["capacity"], indent=2)}

Risk Analysis:
{json.dumps(analysis_data["risk"], indent=2)}

Return ONLY valid JSON.

{{
    "summary": "",
    "root_cause": "",
    "business_impact": "",
    "immediate_actions": [],
    "long_term_fixes": []
}}
"""

        response = self.client.models.generate_content(
            model="gemini-3.5-flash-lite", 
            contents=prompt
        )

        text = response.text.strip()

        if text.startswith("```json"):
            text = text.replace("```json", "").replace("```", "").strip()
        elif text.startswith("```"):
            text = text.replace("```", "").strip()

        try:
            return json.loads(text)
        except json.JSONDecodeError:
            return {
                "parse_error": True,
                "raw_response": response.text
            }

    def chat(self, prompt: str) -> str:
        response = self.client.models.generate_content(
            model="gemini-3.5-flash-lite", 
            contents=prompt
        )

        return response.text