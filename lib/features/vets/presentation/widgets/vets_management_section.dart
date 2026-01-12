import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/vets_provider.dart';
import 'vet_card.dart';
import 'add_vet_dialog.dart';
import 'vet_details_dialog.dart';

class VetsManagementSection extends ConsumerStatefulWidget {
  const VetsManagementSection({super.key});

  @override
  ConsumerState<VetsManagementSection> createState() => _VetsManagementSectionState();
}

class _VetsManagementSectionState extends ConsumerState<VetsManagementSection> {
  String _searchQuery = '';
  String _statusFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final vets = ref.watch(vetsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Vets Management',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _showAddVetDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Vet'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Filter Bar
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search vets',
                      hintText: 'Search by name, phone, or email',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _statusFilter,
                    decoration: const InputDecoration(
                      labelText: 'Status Filter',
                      border: OutlineInputBorder(),
                    ),
                    items: ['All', 'Available', 'On Duty', 'Offline']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _statusFilter = value ?? 'All'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Vets Grid
        Expanded(
          child: vets.when(
            data: (vetsList) {
              final filteredVets = _filterVets(vetsList);
              
              if (filteredVets.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.medical_services_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No vets found',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add vets to manage your veterinary team.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: filteredVets.length,
                itemBuilder: (context, index) {
                  final vet = filteredVets[index];
                  return VetCard(
                    vet: vet,
                    onView: () => _showVetDetails(context, vet),
                    onEdit: () => _showEditVetDialog(context, vet),
                    onTogglePower: () => _toggleVetPower(vet.id, !vet.enabled),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading vets',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.refresh(vetsProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<dynamic> _filterVets(List<dynamic> vets) {
    return vets.where((vet) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesSearch = vet.name.toLowerCase().contains(query) ||
            vet.phone.contains(query) ||
            vet.email.toLowerCase().contains(query);
        if (!matchesSearch) return false;
      }

      // Status filter
      if (_statusFilter != 'All' && vet.status != _statusFilter) {
        return false;
      }

      return true;
    }).toList();
  }

  void _showAddVetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddVetDialog(),
    );
  }

  void _showEditVetDialog(BuildContext context, dynamic vet) {
    showDialog(
      context: context,
      builder: (context) => AddVetDialog(vet: vet),
    );
  }

  void _showVetDetails(BuildContext context, dynamic vet) {
    showDialog(
      context: context,
      builder: (context) => VetDetailsDialog(vet: vet),
    );
  }

  void _toggleVetPower(String vetId, bool enabled) {
    ref.read(vetsNotifierProvider.notifier).toggleVetStatus(vetId, enabled);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(enabled ? 'Vet enabled' : 'Vet disabled'),
      ),
    );
  }
}