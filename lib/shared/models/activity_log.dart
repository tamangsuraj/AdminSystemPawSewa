class ActivityLog {
  final String id;
  final String action;
  final String entity; // "Order", "Appointment", "Vet", "Rider", "Premium"
  final String entityId;
  final String details;
  final String performedBy;
  final DateTime timestamp;

  const ActivityLog({
    required this.id,
    required this.action,
    required this.entity,
    required this.entityId,
    required this.details,
    required this.performedBy,
    required this.timestamp,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      id: json['id'] ?? '',
      action: json['action'] ?? '',
      entity: json['entity'] ?? '',
      entityId: json['entity_id'] ?? '',
      details: json['details'] ?? '',
      performedBy: json['performed_by'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'action': action,
      'entity': entity,
      'entity_id': entityId,
      'details': details,
      'performed_by': performedBy,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}