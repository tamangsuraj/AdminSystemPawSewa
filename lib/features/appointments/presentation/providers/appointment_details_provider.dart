import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/appointment.dart';

final appointmentDetailsProvider = FutureProvider.family<Appointment, String>((ref, appointmentId) async {
  // Simulate API call delay
  await Future.delayed(const Duration(milliseconds: 800));
  
  // Mock appointment data - in real implementation, fetch from Supabase
  return Appointment(
    id: appointmentId,
    pet: 'Buddy',
    breed: 'Golden Retriever',
    age: '3 years',
    weight: '25kg',
    service: 'Vaccination & Health Checkup',
    customer: 'John Doe',
    phone: '+977-9841234567',
    email: 'john.doe@email.com',
    address: 'Kathmandu Metropolitan City, Ward No. 15, Thamel, Nepal',
    location: {'lat': 27.7172, 'lng': 85.3240},
    status: 'Confirmed',
    vet: 'Dr. Sarah Smith',
    vetPhone: '+977-9841111111',
    scheduledTime: '10:00 AM',
    scheduledDate: '2026-01-15',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    notes: 'Regular vaccination checkup. Pet is healthy and active. Owner mentioned some concerns about diet.',
    previousVisits: 3,
    estimatedDuration: '45 minutes',
    orderType: 'Home Visit',
    paymentMethod: 'Digital Payment',
  );
});