class DeliveryRecord {
  final String orderId;
  final String product;
  final String customer;
  final String time;
  final String status;

  const DeliveryRecord({
    required this.orderId,
    required this.product,
    required this.customer,
    required this.time,
    required this.status,
  });

  factory DeliveryRecord.fromJson(Map<String, dynamic> json) {
    return DeliveryRecord(
      orderId: json['order_id'] ?? '',
      product: json['product'] ?? '',
      customer: json['customer'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'product': product,
      'customer': customer,
      'time': time,
      'status': status,
    };
  }
}

class Rider {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String status; // "Available", "Delivering", "Offline"
  final int activeDeliveries;
  final int totalDelivered;
  final bool enabled;
  final DateTime joinDate;
  final String vehicleType;
  final String vehicleNumber;
  final List<DeliveryRecord> history;

  const Rider({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.status,
    required this.activeDeliveries,
    required this.totalDelivered,
    required this.enabled,
    required this.joinDate,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.history,
  });

  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      status: json['status'] ?? 'Available',
      activeDeliveries: json['active_deliveries'] ?? 0,
      totalDelivered: json['total_delivered'] ?? 0,
      enabled: json['enabled'] ?? true,
      joinDate: DateTime.parse(json['join_date'] ?? DateTime.now().toIso8601String()),
      vehicleType: json['vehicle_type'] ?? '',
      vehicleNumber: json['vehicle_number'] ?? '',
      history: (json['history'] as List<dynamic>?)
          ?.map((h) => DeliveryRecord.fromJson(h))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'status': status,
      'active_deliveries': activeDeliveries,
      'total_delivered': totalDelivered,
      'enabled': enabled,
      'join_date': joinDate.toIso8601String(),
      'vehicle_type': vehicleType,
      'vehicle_number': vehicleNumber,
      'history': history.map((h) => h.toJson()).toList(),
    };
  }

  Rider copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? status,
    int? activeDeliveries,
    int? totalDelivered,
    bool? enabled,
    DateTime? joinDate,
    String? vehicleType,
    String? vehicleNumber,
    List<DeliveryRecord>? history,
  }) {
    return Rider(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      status: status ?? this.status,
      activeDeliveries: activeDeliveries ?? this.activeDeliveries,
      totalDelivered: totalDelivered ?? this.totalDelivered,
      enabled: enabled ?? this.enabled,
      joinDate: joinDate ?? this.joinDate,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      history: history ?? this.history,
    );
  }
}