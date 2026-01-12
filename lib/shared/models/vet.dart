class VetEarnings {
  final double salary;
  final double commission;

  const VetEarnings({
    required this.salary,
    required this.commission,
  });

  factory VetEarnings.fromJson(Map<String, dynamic> json) {
    return VetEarnings(
      salary: (json['salary'] ?? 0).toDouble(),
      commission: (json['commission'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'salary': salary,
      'commission': commission,
    };
  }
}

class Vet {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String zone;
  final String status; // "Available", "On Duty", "Offline"
  final String specialization;
  final int todayAppointments;
  final int totalCompleted;
  final VetEarnings earnings;
  final bool enabled;
  final DateTime joinDate;

  const Vet({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.zone,
    required this.status,
    required this.specialization,
    required this.todayAppointments,
    required this.totalCompleted,
    required this.earnings,
    required this.enabled,
    required this.joinDate,
  });

  factory Vet.fromJson(Map<String, dynamic> json) {
    return Vet(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      zone: json['zone'] ?? '',
      status: json['status'] ?? 'Available',
      specialization: json['specialization'] ?? '',
      todayAppointments: json['today_appointments'] ?? 0,
      totalCompleted: json['total_completed'] ?? 0,
      earnings: VetEarnings.fromJson(json['earnings'] ?? {}),
      enabled: json['enabled'] ?? true,
      joinDate: DateTime.parse(json['join_date'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'zone': zone,
      'status': status,
      'specialization': specialization,
      'today_appointments': todayAppointments,
      'total_completed': totalCompleted,
      'earnings': earnings.toJson(),
      'enabled': enabled,
      'join_date': joinDate.toIso8601String(),
    };
  }

  Vet copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? zone,
    String? status,
    String? specialization,
    int? todayAppointments,
    int? totalCompleted,
    VetEarnings? earnings,
    bool? enabled,
    DateTime? joinDate,
  }) {
    return Vet(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      zone: zone ?? this.zone,
      status: status ?? this.status,
      specialization: specialization ?? this.specialization,
      todayAppointments: todayAppointments ?? this.todayAppointments,
      totalCompleted: totalCompleted ?? this.totalCompleted,
      earnings: earnings ?? this.earnings,
      enabled: enabled ?? this.enabled,
      joinDate: joinDate ?? this.joinDate,
    );
  }
}