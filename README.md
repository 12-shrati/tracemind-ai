
# 🚀 TraceMind AI

## AI-Powered Incident Copilot using Flutter, FastAPI, OpenTelemetry, SigNoz & Gemini AI

# 📖 Introduction
Modern applications generate thousands of requests every minute. When an application becomes slow or starts failing, engineers usually open multiple monitoring tools to investigate:
- Which API failed?
- Why is latency increasing?
- Which endpoint is causing issues?
- Is the system meeting SLA?
- What is the business impact?
- What should engineers fix first?
Although observability platforms like SigNoz provide traces and metrics, engineers still spend significant time manually analyzing telemetry data.

**TraceMind AI** solves this problem by combining **Observability + Artificial Intelligence**.

Instead of only showing dashboards, TraceMind AI understands telemetry, detects incidents, analyzes system health, evaluates SLA compliance, predicts risks, and provides AI-powered recommendations in natural language.

# 🎯 Problem Statement
Observability tools answer:
> "What happened?"
But engineers still need to answer:
- Why did it happen?
- What is affected?
- How serious is it?
- What should we do next?
- Is the SLA impacted?
- Should we scale the infrastructure?

TraceMind AI automates these decisions.

---

# 💡 Solution
TraceMind AI continuously collects telemetry from applications using **OpenTelemetry**.
The telemetry is stored in **SigNoz**.
The backend analyzes the telemetry and generates:
- Performance Metrics
- Incident Analysis
- SRE Health
- SLA Compliance
- Capacity Analysis
- Risk Assessment

Finally, **Google Gemini AI** converts technical telemetry into understandable insights and recommendations.

---

# 🏗 Overall Architecture

```
                ┌──────────────────────────┐
                │      Flutter Mobile App  │
                └─────────────┬────────────┘
                              │
                              │ REST API
                              │
                              ▼
                ┌──────────────────────────┐
                │      FastAPI Backend     │
                └─────────────┬────────────┘
                              │
               OpenTelemetry Instrumentation
                              │
                              ▼
                ┌──────────────────────────┐
                │        SigNoz            │
                │ Traces + Metrics Storage │
                └─────────────┬────────────┘
                              │
                    Telemetry Processing
                              │
                              ▼
     ┌─────────────┬──────────────┬──────────────┐
     │             │              │              │
 Metrics     Incident Engine   SRE Engine   SLA Engine
     │             │              │              │
     └─────────────┴──────────────┴──────────────┘
                              │
                    Capacity & Risk Engine
                              │
                              ▼
                     Google Gemini AI
                              │
                              ▼
                 AI Summary & Recommendations
                              │
                              ▼
                     Flutter Dashboard
```

---

# 📱 Frontend Workflow
The Flutter application acts as the user interface for engineers.
The application contains four major dashboards.

```
Dashboard

├── Overview
│      ├── Total Requests
│      ├── Successful Requests
│      ├── Failed Requests
│      └── Error Rate
│
├── Performance
│      ├── Average Latency
│      ├── P95
│      ├── P99
│      ├── Slow Endpoints
│      └── Charts
│
├── AI Dashboard
│      ├── Incident Summary
│      ├── Root Cause
│      ├── Business Impact
│      ├── Immediate Actions
│      └── Long-term Recommendations
│
└── AI Chat
       └── Ask questions about system health
```

The Flutter app periodically calls the backend and refreshes the dashboard in real time.

---

# ⚙ Backend Workflow
The backend is developed using **FastAPI**.
It acts as the intelligence layer between SigNoz and the mobile application.
The backend performs the following operations:

```
Flutter Request
       │
       ▼
FastAPI Endpoint
       │
       ▼
Read Telemetry from SigNoz
       │
       ▼
Extract Traces
       │
       ▼
Calculate Metrics
       │
       ▼
Detect Incident
       │
       ▼
Perform SRE Analysis
       │
       ▼
Perform SLA Analysis
       │
       ▼
Capacity Analysis
       │
       ▼
Risk Analysis
       │
       ▼
Gemini AI Analysis
       │
       ▼
Return Dashboard JSON
```

---

# 🔍 Complete Data Flow
## Step 1
Applications are instrumented using **OpenTelemetry**.
Every HTTP request automatically generates:
- Trace ID
- Span ID
- Request Duration
- Endpoint
- HTTP Method
- Status Code
- Timestamp

Example:

```
GET /orders

Duration : 245 ms

Status : 200
```

---

## Step 2
OpenTelemetry exports telemetry to SigNoz.
SigNoz stores:
- Distributed Traces
- Request Metrics
- Performance Statistics

---

## Step 3
FastAPI requests telemetry from SigNoz.
The backend fetches recent traces using the SigNoz API.
Example:

```
GET /analysis/latest
```

---

## Step 4
The backend processes telemetry.
From raw traces it calculates:
- Total Requests
- Successful Requests
- Failed Requests
- Error Rate
- Average Latency
- P95
- P99
- Slowest APIs

---

## Step 5
Incident Detection Engine
The backend determines whether an incident exists.
Example conditions:
- Error Rate > Threshold
- High Latency
- Too many failed requests
- Slow endpoints

---

## Step 6
SRE Analysis
The backend evaluates system reliability.
It calculates:
- Reliability Score
- Health Score
- Performance Score
- Recommendations

Purpose:
Help Site Reliability Engineers understand overall system health.

---

## Step 7
SLA Analysis
The backend checks whether the application satisfies business commitments.
Example:

```
Availabilit - 99.95%
Required - 99.90%
Status - PASS
```

The backend also checks:
- Response Time
- Error Rate
- SLA Violations

---

## Step 8
Capacity Analysis
The backend predicts:
- Infrastructure utilization
- Scaling requirements
- Traffic growth
- Capacity risk

---

## Step 9
Risk Analysis
The backend evaluates:
- High Error Rate
- High Latency
- Availability Risk
- Performance Risk

---

## Step 10
Gemini AI Analysis
All calculated analytics are provided to Gemini AI.
Gemini generates:
- Executive Summary
- Root Cause
- Business Impact
- Immediate Actions
- Long-term Improvements

Instead of reading raw metrics, engineers receive understandable recommendations.

---

## Step 11
Backend Response
The backend returns one consolidated response.

```
{
    "metrics": {},
    "incident": {},
    "sre_analysis": {},
    "sla_analysis": {},
    "capacity_analysis": {},
    "risk_analysis": {},
    "ai_analysis": {}
}
```

---

## Step 12
Flutter Dashboard
Flutter visualizes the response using:
- Summary Cards
- Charts
- Gauges
- Incident Cards
- AI Cards
- Chat Interface

---

# 💬 AI Chat Flow
The application also provides an AI assistant.

```
User

↓

"What caused today's incident?"

↓

Flutter

↓

POST /chat

↓

FastAPI

↓

Gemini AI

↓

AI Response

↓

Flutter Chat Screen
```

Users can ask:
- Why is latency increasing?
- Which endpoint is slow?
- Explain today's incident.
- Is SLA healthy?
- What should I fix first?
- Summarize system health.

---

# 🧠 Use Case
Imagine an e-commerce application.
A sudden increase in traffic causes the **Order API** to become slow.
OpenTelemetry records the request traces.
SigNoz stores the telemetry.

TraceMind AI analyzes the traces and determines:
- Error rate increased to 18%
- Average latency increased to 3.5 seconds
- `/orders` is the slowest endpoint
- SLA response time is violated
- Capacity utilization is high
- Risk level is Critical

Gemini AI generates a summary:
> "The Order service is experiencing high latency, likely due to increased traffic. SLA response time is being violated. Immediate action should focus on scaling the service and investigating database performance."

The engineer sees this insight instantly without manually analyzing thousands of traces.

---

# 🚀 Benefits
- Reduces incident investigation time
- Converts telemetry into business insights
- Improves system reliability
- Helps SRE teams prioritize issues
- Detects SLA violations early
- Provides AI-powered recommendations
- Simplifies observability for developers
- Enables faster incident response


