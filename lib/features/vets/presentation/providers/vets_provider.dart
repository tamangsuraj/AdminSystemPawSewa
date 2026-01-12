import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/vet.dart';

// Mock data for demonstration
final _mockVets = [
  Vet(
    id: 'vet_001',
    name: 'Dr. Sarah Smith',
    phone: '+977-9841111111',
    email: 'sarah.smith@pawsewa.com',
    zone: 'Kathmandu Central',
    status: 'Available',
    specialization: 'General Practice',
    todayAppointments: 3,
    totalCompleted: 245,
    earnings: const VetEarnings(salary: 75000, commission: 12500),
    enabled: true,
    joinDate: DateTime(2023, 6, 15),
  ),
  Vet(
    id: 'vet_002',
    name: 'Dr. John Johnson',
    phone: '+977-9842222222',
    email: 'john.johnson@pawsewa.com',
    zone: 'Lalitpur',
    status: 'On Duty',
    specialization: 'Surgery',
    todayAppointments: 2,
    totalCompleted: 189,
    earnings: const VetEarnings(salary: 85000, commission: 15200),
    enabled: true,
    joinDate: DateTime(2023, 8, 20),
  ),
  Vet(
    id: 'vet_003',
    name: 'Dr. Emily Brown',
    phone: '+977-9843333333',
    email: 'emily.brown@pawsewa.com',
    zone: 'Bhaktapur',
    status: 'Available',
    specialization: 'Dermatology',
    todayAppointments: 1,
    totalCompleted: 156,
    earnings: const VetEarnings(salary: 70000, commission: 8900),
    enabled: true,
    joinDate: DateTime(2023, 10, 5),
  ),
  Vet(
    id: 'vet_004',
    name: 'Dr. Michael Wilson',
    phone: '+977-9844444444',
    email: 'michael.wilson@pawsewa.com',
    zone: 'Pokhara',
    status: 'Offline',
    specialization: 'Emergency Care',
    todayAppointments: 0,
    totalCompleted: 98,
    earnings: const VetEarnings(salary: 65000, commission: 5600),
    enabled: false,
    joinDate: DateTime(2024, 1, 12),
  ),
  Vet(
    id: 'vet_005',
    name: 'Dr. Lisa Anderson',
    phone: '+977-9845555555',
    email: 'lisa.anderson@pawsewa.com',
    zone: 'Chitwan',
    status: 'Available',
    specialization: 'Cardiology',
    todayAppointments: 4,
    totalCompleted: 312,
    earnings: const VetEarnings(salary: 90000, commission: 18700),
    enabled: true,
    joinDate: DateTime(2022, 11, 8),
  ),
];

final vetsProvider = FutureProvider<List<Vet>>((ref) async {
  // Simulate API call delay
  await Future.delayed(const Duration(milliseconds: 600));
  return _mockVets;
});

final vetsNotifierProvider = StateNotifierProvider<VetsNotifier, AsyncValue<void>>((ref) {
  return VetsNotifier(ref);
});

class VetsNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  VetsNotifier(this._ref) : super(const AsyncValue.data(null));

  Future<void> addVet(Vet vet) async {
    state = const AsyncValue.loading();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // In real implementation, create via Supabase
      // final supabase = _ref.read(supabaseProvider);
      // await supabase.from('vets').insert(vet.toJson());
      
      // Refresh the vets list
      _ref.invalidate(vetsProvider);
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateVet(Vet vet) async {
    state = const AsyncValue.loading();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));
      
      // In real implementation, update via Supabase
      // final supabase = _ref.read(supabaseProvider);
      // await supabase.from('vets').update(vet.toJson()).eq('id', vet.id);
      
      // Refresh the vets list
      _ref.invalidate(vetsProvider);
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteVet(String vetId) async {
    state = const AsyncValue.loading();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      // In real implementation, delete via Supabase
      // final supabase = _ref.read(supabaseProvider);
      // await supabase.from('vets').delete().eq('id', vetId);
      
      // Refresh the vets list
      _ref.invalidate(vetsProvider);
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> toggleVetStatus(String vetId, bool enabled) async {
    state = const AsyncValue.loading();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 300));
      
      // In real implementation, update via Supabase
      // final supabase = _ref.read(supabaseProvider);
      // await supabase.from('vets').update({'enabled': enabled}).eq('id', vetId);
      
      // Refresh the vets list
      _ref.invalidate(vetsProvider);
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateVetZone(String vetId, String zone) async {
    state = const AsyncValue.loading();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 400));
      
      // In real implementation, update via Supabase
      // final supabase = _ref.read(supabaseProvider);
      // await supabase.from('vets').update({'zone': zone}).eq('id', vetId);
      
      // Refresh the vets list
      _ref.invalidate(vetsProvider);
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}