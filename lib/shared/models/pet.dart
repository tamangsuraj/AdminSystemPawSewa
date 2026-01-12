class Vaccination {
  final String name;
  final DateTime date;
  final DateTime nextDue;
  final String status;

  const Vaccination({
    required this.name,
    required this.date,
    required this.nextDue,
    required this.status,
  });

  factory Vaccination.fromJson(Map<String, dynamic> json) {
    return Vaccination(
      name: json['name'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      nextDue: DateTime.parse(json['next_due'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toIso8601String(),
      'next_due': nextDue.toIso8601String(),
      'status': status,
    };
  }
}

class MedicalRecord {
  final DateTime date;
  final String type;
  final String description;
  final String vet;

  const MedicalRecord({
    required this.date,
    required this.type,
    required this.description,
    required this.vet,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      vet: json['vet'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'type': type,
      'description': description,
      'vet': vet,
    };
  }
}

class Pet {
  final String id;
  final String name;
  final String breed;
  final String age;
  final String weight;
  final String color;
  final String owner;
  final String ownerPhone;
  final String ownerAddress;
  final List<Vaccination> vaccinations;
  final List<MedicalRecord> medicalHistory;

  const Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.weight,
    required this.color,
    required this.owner,
    required this.ownerPhone,
    required this.ownerAddress,
    required this.vaccinations,
    required this.medicalHistory,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      breed: json['breed'] ?? '',
      age: json['age'] ?? '',
      weight: json['weight'] ?? '',
      color: json['color'] ?? '',
      owner: json['owner'] ?? '',
      ownerPhone: json['owner_phone'] ?? '',
      ownerAddress: json['owner_address'] ?? '',
      vaccinations: (json['vaccinations'] as List<dynamic>?)
          ?.map((v) => Vaccination.fromJson(v))
          .toList() ?? [],
      medicalHistory: (json['medical_history'] as List<dynamic>?)
          ?.map((m) => MedicalRecord.fromJson(m))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'age': age,
      'weight': weight,
      'color': color,
      'owner': owner,
      'owner_phone': ownerPhone,
      'owner_address': ownerAddress,
      'vaccinations': vaccinations.map((v) => v.toJson()).toList(),
      'medical_history': medicalHistory.map((m) => m.toJson()).toList(),
    };
  }

  Pet copyWith({
    String? id,
    String? name,
    String? breed,
    String? age,
    String? weight,
    String? color,
    String? owner,
    String? ownerPhone,
    String? ownerAddress,
    List<Vaccination>? vaccinations,
    List<MedicalRecord>? medicalHistory,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      color: color ?? this.color,
      owner: owner ?? this.owner,
      ownerPhone: ownerPhone ?? this.ownerPhone,
      ownerAddress: ownerAddress ?? this.ownerAddress,
      vaccinations: vaccinations ?? this.vaccinations,
      medicalHistory: medicalHistory ?? this.medicalHistory,
    );
  }
}