# tracemind

A new Flutter project.

# 🚀 TraceMind AI
### AI-Powered Incident Copilot using OpenTelemetry, SigNoz, Gemini AI & Flutter

TraceMind AI is an intelligent observability platform that combines **OpenTelemetry**, **SigNoz**, **FastAPI**, **Flutter**, and **Google Gemini AI** to provide real-time monitoring, incident analysis, SRE insights, SLA evaluation, capacity planning, risk assessment, and AI-powered recommendations.

Instead of only displaying metrics, TraceMind AI analyzes telemetry data and explains system health in natural language, helping developers and SRE teams identify issues faster.

---

# 📌 Problem Statement

Modern distributed applications generate massive amounts of telemetry data including traces, metrics, and logs. While observability tools visualize this data, engineers still spend significant time:

- Identifying incidents
- Finding root causes
- Measuring system reliability
- Monitoring SLA compliance
- Understanding business impact
- Planning infrastructure capacity

TraceMind AI automates this analysis using AI.

---

# 🎯 Features

## 📊 Real-Time Observability

- OpenTelemetry Instrumentation
- Distributed Tracing
- HTTP Request Monitoring
- Latency Analysis
- Error Rate Monitoring
- Endpoint Performance Analysis

---

## 🤖 AI Incident Copilot

Gemini AI automatically analyzes:

- Current system health
- Active incidents
- Root causes
- Business impact
- Immediate actions
- Long-term recommendations

---

## 📈 Dashboard Analytics

### Overview

- Total Requests
- Successful Requests
- Failed Requests
- Error Rate

### Performance

- Average Latency
- Median Latency
- P95 Latency
- P99 Latency
- Maximum Latency

### Status Codes

- HTTP Status Distribution
- Success vs Failure Ratio

### Slowest Endpoints

- Endpoint Ranking
- Average Response Time
- Maximum Response Time

---

## ⚙ SRE Analysis

TraceMind AI evaluates:

- Overall Reliability Score
- System Health
- Error Trends
- Performance Bottlenecks
- Reliability Recommendations

---

## 📄 SLA Analysis

Automatically checks:

- Availability
- Error Rate Compliance
- Latency Compliance
- SLA Status
- Violation Detection

---

## 📦 Capacity Analysis

Predicts:

- Infrastructure Utilization
- Capacity Risk
- Scaling Recommendation
- Traffic Growth

---

## ⚠ Risk Analysis

Detects:

- High Error Rates
- Slow Endpoints
- Availability Risks
- Performance Risks

---

## 💬 AI Chat Assistant

Ask questions like:

- Explain today's incidents.
- Why is latency high?
- Which endpoint is slow?
- What should I fix first?
- Summarize system health.
- Is the SLA healthy?

---

# 🏗 Architecture

```
                   +----------------------+
                   |     Flutter App      |
                   +----------+-----------+
                              |
                              |
                    REST API Calls
                              |
                              v
                   +----------------------+
                   |      FastAPI         |
                   +----------+-----------+
                              |
          +-------------------+-------------------+
          |                   |                   |
          |                   |                   |
          v                   v                   v
 OpenTelemetry         Incident Engine      AI Analysis
          |                   |                   |
          +-------------------+-------------------+
                              |
                              v
                         SigNoz Platform
                              |
                              |
                        Trace & Metrics
                              |
                              v
                      Google Gemini AI
                              |
                              |
                       AI Recommendations
```

---

# 🛠 Technology Stack

## Frontend

- Flutter
- Provider
- Dio
- FL Chart
- Material Design

---

## Backend

- FastAPI
- Python
- Pydantic

---

## Observability

- OpenTelemetry
- SigNoz

---

## AI

- Google Gemini API

---

## Communication

- REST APIs
- JSON

---

# 📂 Project Structure

```
TraceMind_AI
│
├── flutter_app
│   ├── screens
│   ├── widgets
│   ├── providers
│   ├── services
│   └── models
│
├── server
│   ├── app
│   │
│   ├── api
│   │
│   ├── services
│   │     ├── ai_service.py
│   │     ├── metrics_service.py
│   │     ├── incident_service.py
│   │     ├── sla_service.py
│   │     ├── sre_service.py
│   │     ├── capacity_service.py
│   │     └── risk_service.py
│   │
│   ├── core
│   │     └── gemini_client.py
│   │
│   └── telemetry.py
│
└── README.md
```

---

# 🔄 Workflow

```
Flutter App
      │
      ▼
FastAPI Backend
      │
      ▼
OpenTelemetry
      │
      ▼
SigNoz
      │
      ▼
Telemetry Data
      │
      ▼
Metrics Analysis
      │
      ▼
Incident Detection
      │
      ▼
SRE Analysis
      │
      ▼
SLA Analysis
      │
      ▼
Capacity Analysis
      │
      ▼
Risk Analysis
      │
      ▼
Gemini AI
      │
      ▼
AI Dashboard + Chat
```

---

# 📊 Dashboard Modules

## Overview Dashboard

Displays:

- Total Requests
- Successful Requests
- Failed Requests
- Error Rate

---

## Performance Dashboard

Displays:

- Average Latency
- Median Latency
- P95
- P99
- Slowest Endpoints

---

## AI Dashboard

Displays:

- Incident Summary
- Root Cause
- Business Impact
- Immediate Actions
- Long-Term Fixes

---

## Chat Dashboard

Interactive AI assistant for observability questions.

---

# 📈 SRE

Site Reliability Engineering focuses on improving system reliability.

TraceMind AI evaluates:

- Error Rate
- Latency
- Availability
- Reliability Score
- Overall Health

---

# 📄 SLA

Service Level Agreement measures whether system performance satisfies business commitments.

Checks include:

- Availability
- Response Time
- Error Threshold
- SLA Compliance

---

# ⚠ Risk Analysis

The platform identifies:

- High Latency
- High Error Rate
- Slow APIs
- Potential Service Failure

---

# 📦 Capacity Analysis

Predicts:

- Infrastructure Load
- Scaling Requirement
- Capacity Risk

---

# 🤖 AI Capabilities

Gemini AI generates:

- Incident Summary
- Root Cause
- Business Impact
- Recommended Actions
- Long-Term Improvements

---

# 💬 Sample AI Questions

- What caused today's incident?
- Which API is slow?
- Explain the error rate.
- Is SLA healthy?
- Which service needs attention?
- Summarize system health.
- What should the SRE team fix first?

---

# 🚀 Getting Started

## Clone Repository

```bash
git clone <repository-url>
```

---

## Backend

```bash
cd server

python -m venv windows_venv

windows_venv\Scripts\activate

pip install -r requirements.txt

uvicorn app.main:app --reload
```

---

## Flutter

```bash
cd flutter_app

flutter pub get

flutter run
```

---

# 📸 Screenshots

Add screenshots for:

- Dashboard
- AI Analysis
- Performance Metrics
- Chat Assistant
- SigNoz Traces
- SigNoz Dashboard

---

# 🎥 Demo Flow

1. Generate sample API traffic.
2. Observe traces in SigNoz.
3. Open TraceMind AI dashboard.
4. Review metrics and incident analysis.
5. Ask questions using AI Chat.
6. Receive AI-powered recommendations.

---

# 🔮 Future Enhancements

- Kubernetes Monitoring
- Log Analysis
- Multi-Service Support
- Predictive Incident Detection
- Automated Alerting
- Slack/MS Teams Integration
- Email Notifications
- Root Cause Timeline
- AI-Powered Auto Remediation

---

# 👥 Team

Developed as part of an AI & Observability Hackathon using Flutter, FastAPI, OpenTelemetry, SigNoz, and Google Gemini AI.

---

# 📄 License

This project is intended for educational, research, and hackathon purposes.
