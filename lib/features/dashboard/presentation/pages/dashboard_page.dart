import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/main_layout.dart';
import '../widgets/dashboard_content.dart';
import '../../../appointments/presentation/widgets/appointments_section.dart';
import '../../../supplies/presentation/widgets/supplies_section.dart';
import '../../../vets/presentation/widgets/vets_management_section.dart';
import '../../../riders/presentation/widgets/riders_management_section.dart';
import '../../../maps/presentation/widgets/combined_map_section.dart';
import '../../../products/presentation/widgets/product_management_section.dart';
import '../../../orders/presentation/widgets/create_order_section.dart';
import '../../../premium/presentation/widgets/premium_members_section.dart';
import '../../../pets/presentation/widgets/pet_details_section.dart';
import '../../../tracking/presentation/widgets/track_vets_section.dart';
import '../../../tracking/presentation/widgets/track_riders_section.dart';
import '../../../users/presentation/widgets/add_user_section.dart';
import '../../../audit/presentation/widgets/audit_logs_section.dart';
import '../../../settings/presentation/widgets/settings_section.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSection = ref.watch(activeSectionProvider);

    return MainLayout(
      child: _buildContent(activeSection),
    );
  }

  Widget _buildContent(String activeSection) {
    switch (activeSection) {
      case 'dashboard':
        return const DashboardContent();
      case 'appointments-live':
        return const AppointmentsSection(subSection: 'live');
      case 'appointments-cancelled':
        return const AppointmentsSection(subSection: 'cancelled');
      case 'appointments-past':
        return const AppointmentsSection(subSection: 'past');
      case 'supplies-live':
        return const SuppliesSection(subSection: 'live');
      case 'supplies-cancelled':
        return const SuppliesSection(subSection: 'cancelled');
      case 'supplies-past':
        return const SuppliesSection(subSection: 'past');
      case 'vets-management':
        return const VetsManagementSection();
      case 'riders-management':
        return const RidersManagementSection();
      case 'map-view':
        return const CombinedMapSection();
      case 'products':
        return const ProductManagementSection();
      case 'create-order':
        return const CreateOrderSection();
      case 'premium-members':
        return const PremiumMembersSection();
      case 'pet-details':
        return const PetDetailsSection();
      case 'track-vets':
        return const TrackVetsSection();
      case 'track-riders':
        return const TrackRidersSection();
      case 'add-user':
        return const AddUserSection();
      case 'audit-logs':
        return const AuditLogsSection();
      case 'settings':
        return const SettingsSection();
      default:
        return const DashboardContent();
    }
  }
}