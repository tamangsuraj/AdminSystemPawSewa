class UsageTracker {
  final int vaccinationsUsed;
  final int vaccinationsTotal;
  final int checkupsUsed;
  final int checkupsTotal;
  final bool birthdayTreatSent;

  const UsageTracker({
    required this.vaccinationsUsed,
    required this.vaccinationsTotal,
    required this.checkupsUsed,
    required this.checkupsTotal,
    required this.birthdayTreatSent,
  });

  factory UsageTracker.fromJson(Map<String, dynamic> json) {
    return UsageTracker(
      vaccinationsUsed: json['vaccinations_used'] ?? 0,
      vaccinationsTotal: json['vaccinations_total'] ?? 0,
      checkupsUsed: json['checkups_used'] ?? 0,
      checkupsTotal: json['checkups_total'] ?? 0,
      birthdayTreatSent: json['birthday_treat_sent'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vaccinations_used': vaccinationsUsed,
      'vaccinations_total': vaccinationsTotal,
      'checkups_used': checkupsUsed,
      'checkups_total': checkupsTotal,
      'birthday_treat_sent': birthdayTreatSent,
    };
  }
}

class PremiumMember {
  final String id;
  final String petName;
  final String ownerName;
  final String phone;
  final String status; // "Active", "Expired", "Cancelled"
  final DateTime startDate;
  final DateTime renewalDate;
  final List<String> benefits;
  final int benefitsUsed;
  final String paymentStatus; // "Paid", "Pending"
  final UsageTracker usageTracker;

  const PremiumMember({
    required this.id,
    required this.petName,
    required this.ownerName,
    required this.phone,
    required this.status,
    required this.startDate,
    required this.renewalDate,
    required this.benefits,
    required this.benefitsUsed,
    required this.paymentStatus,
    required this.usageTracker,
  });

  factory PremiumMember.fromJson(Map<String, dynamic> json) {
    return PremiumMember(
      id: json['id'] ?? '',
      petName: json['pet_name'] ?? '',
      ownerName: json['owner_name'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? 'Active',
      startDate: DateTime.parse(json['start_date'] ?? DateTime.now().toIso8601String()),
      renewalDate: DateTime.parse(json['renewal_date'] ?? DateTime.now().toIso8601String()),
      benefits: List<String>.from(json['benefits'] ?? []),
      benefitsUsed: json['benefits_used'] ?? 0,
      paymentStatus: json['payment_status'] ?? 'Paid',
      usageTracker: UsageTracker.fromJson(json['usage_tracker'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet_name': petName,
      'owner_name': ownerName,
      'phone': phone,
      'status': status,
      'start_date': startDate.toIso8601String(),
      'renewal_date': renewalDate.toIso8601String(),
      'benefits': benefits,
      'benefits_used': benefitsUsed,
      'payment_status': paymentStatus,
      'usage_tracker': usageTracker.toJson(),
    };
  }

  PremiumMember copyWith({
    String? id,
    String? petName,
    String? ownerName,
    String? phone,
    String? status,
    DateTime? startDate,
    DateTime? renewalDate,
    List<String>? benefits,
    int? benefitsUsed,
    String? paymentStatus,
    UsageTracker? usageTracker,
  }) {
    return PremiumMember(
      id: id ?? this.id,
      petName: petName ?? this.petName,
      ownerName: ownerName ?? this.ownerName,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      renewalDate: renewalDate ?? this.renewalDate,
      benefits: benefits ?? this.benefits,
      benefitsUsed: benefitsUsed ?? this.benefitsUsed,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      usageTracker: usageTracker ?? this.usageTracker,
    );
  }
}