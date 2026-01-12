import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSection = ref.watch(activeSectionProvider);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo Section
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.pets,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'PawSewa Ops',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Navigation Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildNavItem(
                  context,
                  ref,
                  'dashboard',
                  'Dashboard',
                  Icons.dashboard_outlined,
                  activeSection,
                ),
                const SizedBox(height: 8),
                
                // Appointments Section
                _buildSectionHeader(context, 'Appointments'),
                _buildNavItem(context, ref, 'appointments-live', 'Live', Icons.schedule, activeSection),
                _buildNavItem(context, ref, 'appointments-cancelled', 'Cancelled', Icons.cancel_outlined, activeSection),
                _buildNavItem(context, ref, 'appointments-past', 'Past', Icons.history, activeSection),
                const SizedBox(height: 16),
                
                // Supplies Section
                _buildSectionHeader(context, 'Pet Supplies'),
                _buildNavItem(context, ref, 'supplies-live', 'Live Orders', Icons.inventory_2_outlined, activeSection),
                _buildNavItem(context, ref, 'supplies-cancelled', 'Cancelled', Icons.cancel_outlined, activeSection),
                _buildNavItem(context, ref, 'supplies-past', 'Past Orders', Icons.history, activeSection),
                const SizedBox(height: 16),
                
                // Management Section
                _buildSectionHeader(context, 'Management'),
                _buildNavItem(context, ref, 'vets-management', 'Vets', Icons.medical_services_outlined, activeSection),
                _buildNavItem(context, ref, 'riders-management', 'Riders', Icons.delivery_dining_outlined, activeSection),
                _buildNavItem(context, ref, 'products', 'Products', Icons.category_outlined, activeSection),
                _buildNavItem(context, ref, 'premium-members', 'Premium Members', Icons.star_outline, activeSection),
                const SizedBox(height: 16),
                
                // Operations Section
                _buildSectionHeader(context, 'Operations'),
                _buildNavItem(context, ref, 'map-view', 'Map View', Icons.map_outlined, activeSection),
                _buildNavItem(context, ref, 'track-vets', 'Track Vets', Icons.location_on_outlined, activeSection),
                _buildNavItem(context, ref, 'track-riders', 'Track Riders', Icons.two_wheeler_outlined, activeSection),
                _buildNavItem(context, ref, 'create-order', 'Create Order', Icons.add_shopping_cart_outlined, activeSection),
                const SizedBox(height: 16),
                
                // Other Section
                _buildSectionHeader(context, 'Other'),
                _buildNavItem(context, ref, 'pet-details', 'Pet Details', Icons.pets_outlined, activeSection),
                _buildNavItem(context, ref, 'add-user', 'Add User', Icons.person_add_outlined, activeSection),
                _buildNavItem(context, ref, 'audit-logs', 'Audit Logs', Icons.list_alt_outlined, activeSection),
                _buildNavItem(context, ref, 'settings', 'Settings', Icons.settings_outlined, activeSection),
              ],
            ),
          ),
          
          // Logout Button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    WidgetRef ref,
    String section,
    String title,
    IconData icon,
    String activeSection,
  ) {
    final isActive = activeSection == section;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: Icon(
          icon,
          size: 20,
          color: isActive 
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive 
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        selected: isActive,
        selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: () => ref.read(activeSectionProvider.notifier).state = section,
      ),
    );
  }
}