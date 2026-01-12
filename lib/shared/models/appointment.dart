class Appointment {
  final String id;
  final String pet;
  final String breed;
  final String age;
  final String weight;
  final String service;
  final String customer;
  final String phone;
  final String email;
  final String address;
  final Map<String, double> location;
  final String status;
  final String vet;
  final String vetPhone;
  final String scheduledTime;
  final String scheduledDate;
  final DateTime createdAt;
  final String notes;
  final int previousVisits;
  final String estimatedDuration;
  final String orderType;
  final String paymentMethod;

  const Appointment({
    required this.id,
    required this.pet,
    required this.breed,
    required this.age,
    required this.weight,
    required this.service,
    required this.customer,
    required this.phone,
    required this.email,
    required this.address,
    required this.location,
    required this.status,
    required this.vet,
    required this.vetPhone,
    required this.scheduledTime,
    required this.scheduledDate,
    required this.createdAt,
    required this.notes,
    required this.previousVisits,
    required this.estimatedDuration,
    required this.orderType,
    required this.paymentMethod,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? '',
      pet: json['pet'] ?? '',
      breed: json['breed'] ?? '',
      age: json['age'] ?? '',
      weight: json['weight'] ?? '',
      service: json['service'] ?? '',
      customer: json['customer'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      location: Map<String, double>.from(json['location'] ?? {'lat': 0.0, 'lng': 0.0}),
      status: json['status'] ?? '',
      vet: json['vet'] ?? '',
      vetPhone: json['vet_phone'] ?? '',
      scheduledTime: json['scheduled_time'] ?? '',
      scheduledDate: json['scheduled_date'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      notes: json['notes'] ?? '',
      previousVisits: json['previous_visits'] ?? 0,
      estimatedDuration: json['estimated_duration'] ?? '',
      orderType: json['order_type'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet': pet,
      'breed': breed,
      'age': age,
      'weight': weight,
      'service': service,
      'customer': customer,
      'phone': phone,
      'email': email,
      'address': address,
      'location': location,
      'status': status,
      'vet': vet,
      'vet_phone': vetPhone,
      'scheduled_time': scheduledTime,
      'scheduled_date': scheduledDate,
      'created_at': createdAt.toIso8601String(),
      'notes': notes,
      'previous_visits': previousVisits,
      'estimated_duration': estimatedDuration,
      'order_type': orderType,
      'payment_method': paymentMethod,
    };
  }

  Appointment copyWith({
    String? id,
    String? pet,
    String? breed,
    String? age,
    String? weight,
    String? service,
    String? customer,
    String? phone,
    String? email,
    String? address,
    Map<String, double>? location,
    String? status,
    String? vet,
    String? vetPhone,
    String? scheduledTime,
    String? scheduledDate,
    DateTime? createdAt,
    String? notes,
    int? previousVisits,
    String? estimatedDuration,
    String? orderType,
    String? paymentMethod,
  }) {
    return Appointment(
      id: id ?? this.id,
      pet: pet ?? this.pet,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      service: service ?? this.service,
      customer: customer ?? this.customer,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      location: location ?? this.location,
      status: status ?? this.status,
      vet: vet ?? this.vet,
      vetPhone: vetPhone ?? this.vetPhone,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
      previousVisits: previousVisits ?? this.previousVisits,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      orderType: orderType ?? this.orderType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}