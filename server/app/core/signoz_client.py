import os
import time
import requests
from dotenv import load_dotenv

load_dotenv()


class SignozClient:

    def __init__(self):
        self.base_url = os.getenv("SIGNOZ_URL")
        self.api_key = os.getenv("SIGNOZ_API_KEY")

    def test_connection(self):
        url = f"{self.base_url}/api/v1/service_accounts/me"

        headers = {
            "SIGNOZ-API-KEY": self.api_key
        }

        response = requests.get(url, headers=headers)

        return {
            "status_code": response.status_code,
            "response": response.json() if response.content else {}
        }

    def get_recent_traces(self):

        end = int(time.time() * 1000)
        start = end - (30 * 60 * 1000)

        url = f"{self.base_url}/api/v5/query_range"

        headers = {
            "SIGNOZ-API-KEY": self.api_key,
            "Content-Type": "application/json"
        }

        payload = {
            "schemaVersion": "v1",
            "start": start,
            "end": end,
            "requestType": "raw",
            "compositeQuery": {
                "queries": [
                    {
                        "type": "builder_query",
                        "spec": {
                            "name": "A",
                            "signal": "traces",
                            "stepInterval": None,
                            "disabled": False,
                            "filter": {
                                "expression": ""
                            },
                            "limit": 10,
                            "offset": 0,
                            "order": [
                                {
                                    "key": {
                                        "name": "timestamp"
                                    },
                                    "direction": "desc"
                                }
                            ],
                            "having": {
                                "expression": ""
                            },
                            "selectFields": [
                                {
                                    "name": "service.name",
                                    "fieldDataType": "string",
                                    "signal": "traces",
                                    "fieldContext": "resource"
                                },
                                {
                                    "name": "name",
                                    "fieldDataType": "string",
                                    "signal": "traces"
                                },
                                {
                                    "name": "duration_nano",
                                    "signal": "traces",
                                    "fieldContext": "span"
                                },
                                {
                                    "name": "http_method",
                                    "signal": "traces",
                                    "fieldContext": "span"
                                },
                                {
                                    "name": "response_status_code",
                                    "signal": "traces",
                                    "fieldContext": "span"
                                }
                            ]
                        }
                    }
                ]
            },
            "formatOptions": {
                "formatTableResultForUI": False,
                "fillGaps": False
            },
            "variables": {}
        }

        response = requests.post(
            url,
            headers=headers,
            json=payload
        )

        return {
            "status_code": response.status_code,
            "response": response.json()
        }