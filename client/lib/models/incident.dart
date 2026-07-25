class Incident {
  final String health;
  final String severity;
  final String incident;
  final int confidence;
  final List<String> alerts;

  Incident({
    required this.health,
    required this.severity,
    required this.incident,
    required this.confidence,
    required this.alerts,
  });

  factory Incident.fromJson(Map<String, dynamic> json) {
    return Incident(
      health: json["health"],
      severity: json["severity"],
      incident: json["incident"],
      confidence: json["confidence"],
      alerts: List<String>.from(json["alerts"] ?? []),
    );
  }
}
