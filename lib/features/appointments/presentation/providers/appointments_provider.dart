import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/appointment.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

// Mock data for demonstration
final _mockAppointments = [
  Appointment(
    id: 'apt_001',
    pet: 'Buddy',
    breed: 'Golden Retriever',
    age: '3 years',
    weight: '25kg',
    service: 'Vaccination',
    customer: 'John Doe',
    phone: '+977-9841234567',
    email: 'john.doe@email.com',
    address: 'Kathmandu, Nepal',
    location: {'lat': 27.7172, 'lng': 85.3240},
    status: 'Pending',
    vet: 'Dr. Smith',
    vetPhone: '+977-9841111111',
    scheduledTime: '10:00 AM',
    scheduledDate: '2026-01-15',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    notes: 'Regular vaccination checkup',
    previousVisits: 3,
    estimatedDuration: '30 minutes',
    orderType: 'Home Visit',
    paymentMethod: 'Cash',
  ),
  Appointment(
    id: 'apt_002',
    pet: 'Whiskers',
    breed: 'Persian Cat',
    age: '2 years',
    weight: '4kg',
    service: 'Health Checkup',
    customer: 'Jane Smith',
    phone: '+977-9842345678',
    email: 'jane.smith@email.com',
    address: 'Lalitpur, Nepal',
    location: {'lat': 27.6588, 'lng': 85.3247},
    status: 'Confirmed',
    vet: 'Dr. Johnson',
    vetPhone: '+977-9842222222',
    scheduledTime: '2:00 PM',
    scheduledDate: '2026-01-15',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    notes: 'First time visit',
    previousVisits: 0,
    estimatedDuration: '45 minutes',
    orderType: 'Clinic Visit',
    paymentMethod: 'Digital',
  ),
  Appointment(
    id: 'apt_003',
    pet: 'Max',
    breed: 'German Shepherd',
    age: '5 years',
    weight: '30kg',
    service: 'Surgery Consultation',
    customer: 'Mike Johnson',
    phone: '+977-9843456789',
    email: 'mike.johnson@email.com',
    address: 'Bhaktapur, Nepal',
    location: {'lat': 27.6710, 'lng': 85.4298},
    status: 'In Progress',
    vet: 'Dr. Brown',
    vetPhone: '+977-9843333333',
    scheduledTime: '11:30 AM',
    scheduledDate: '2026-01-15',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    notes: 'Pre-surgery consultation',
    previousVisits: 8,
    estimatedDuration: '60 minutes',
    orderType: 'Clinic Visit',
    paymentMethod: 'Insurance',
  ),
  // Cancelled appointment
  Appointment(
    id: 'apt_004',
    pet: 'Luna',
    breed: 'Labrador',
    age: '1 year',
    weight: '15kg',
    service: 'Vaccination',
    customer: 'Sarah Wilson',
    phone: '+977-9844567890',
    email: 'sarah.wilson@email.com',
    address: 'Pokhara, Nepal',
    location: {'lat': 28.2096, 'lng': 83.9856},
    status: 'Cancelled',
    vet: '',
    vetPhone: '',
    scheduledTime: '9:00 AM',
    scheduledDate: '2026-01-14',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    notes: 'Cancelled due to pet illness',
    previousVisits: 1,
    estimatedDuration: '30 minutes',
    orderType: 'Home Visit',
    paymentMethod: 'Cash',
  ),
  // Past appointments
  Appointment(
    id: 'apt_005',
    pet: 'Charlie',
    breed: 'Beagle',
    age: '4 years',
    weight: '12kg',
    service: 'Grooming',
    customer: 'David Brown',
    phone: '+977-9845678901',
    email: 'david.brown@email.com',
    address: 'Chitwan, Nepal',
    location: {'lat': 27.5291, 'lng': 84.3542},
    status: 'Completed',
    vet: 'Dr. Wilson',
    vetPhone: '+977-9844444444',
    scheduledTime: '3:00 PM',
    scheduledDate: '2026-01-10',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    notes: 'Full grooming service completed',
    previousVisits: 12,
    estimatedDuration: '90 minutes',
    orderType: 'Clinic Visit',
    paymentMethod: 'Digital',
  ),
];

final appointmentsProvider = FutureProvider.family<List<Appointment>, String>((ref, subSection) async {
  // Simulate API call delay
  await Future.delayed(const Duration(milliseconds: 500));
  
  switch (subSection) {
    case 'live':
      return _mockAppointments.where((apt) => 
        ['Pending', 'Confirmed', 'In Progress'].contains(apt.status)
      ).toList();
    case 'cancelled':
      return _mockAppointments.where((apt) => apt.status == 'Cancelled').toList();
    case 'past':
      return _mockAppointments.where((apt) => apt.status == 'Completed').toList();
    default:
      return _mockAppointments;
  }
});

final appointmentsNotifierProvider = StateNotifierProvider<AppointmentsNotifier, AsyncValue<void>>((ref) {
  return AppointmentsNotifier(ref);
});

class AppointmentsNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  AppointmentsNotifier(this._ref) : super(const AsyncValue.data(null));

  Future<void> updateAppointmentStatus(String appointmentId, String newStatus) async {
    state = const AsyncValue.loading();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      // In real implementation, update via Supabase
      // final supabase = _ref.read(supabaseProvider);
      // await supabase.from('appointments').update({'status': newStatus}).eq('id', appointmentId);
      
      // Refresh the appointments list
      _ref.invalidate(appointmentsProvider);
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> assignVet(String appointmentId, String vetName) async {
    state = const AsyncValue.loading();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      // In real implementation, update via Supabase
      // final supabase = _ref.read(supabaseProvider);
      // await supabase.from('appointments').update({'vet': vetName}).eq('id', appointmentId);
      
      // Refresh the appointments list
      _ref.invalidate(appointmentsProvider);
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createAppointment(Appointment appointment) async {
    state = const AsyncValue.loading();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // In real implementation, create via Supabase
      // final supabase = _ref.read(supabaseProvider);
      // await supabase.from('appointments').insert(appointment.toJson());
      
      // Refresh the appointments list
      _ref.invalidate(appointmentsProvider);
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    state = const AsyncValue.loading();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      // In real implementation, delete via Supabase
      // final supabase = _ref.read(supabaseProvider);
      // await supabase.from('appointments').delete().eq('id', appointmentId);
      
      // Refresh the appointments list
      _ref.invalidate(appointmentsProvider);
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}