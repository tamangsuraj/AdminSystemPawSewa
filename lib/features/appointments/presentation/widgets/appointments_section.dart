import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/appointments_provider.dart';
import 'appointments_table.dart';
import 'appointments_filter_bar.dart';

class AppointmentsSection extends ConsumerStatefulWidget {
  final String subSection;

  const AppointmentsSection({
    super.key,
    required this.subSection,
  });

  @override
  ConsumerState<AppointmentsSection> createState() => _AppointmentsSectionState();
}

class _AppointmentsSectionState extends ConsumerState<AppointmentsSection> {
  String _searchQuery = '';
  String _statusFilter = 'All';
  DateTimeRange? _dateRange;

  @override
  Widget build(BuildContext context) {
    final appointments = ref.watch(appointmentsProvider(widget.subSection));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Appointments - ${widget.subSection.toUpperCase()}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.subSection == 'live')
              ElevatedButton.icon(
                onPressed: () => _showCreateAppointmentDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('New Appointment'),
              ),
          ],
        ),
        const SizedBox(height: 24),

        // Filter Bar
        AppointmentsFilterBar(
          subSection: widget.subSection,
          searchQuery: _searchQuery,
          statusFilter: _statusFilter,
          dateRange: _dateRange,
          onSearchChanged: (query) => setState(() => _searchQuery = query),
          onStatusChanged: (status) => setState(() => _statusFilter = status),
          onDateRangeChanged: (range) => setState(() => _dateRange = range),
        ),
        const SizedBox(height: 16),

        // Table
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: appointments.when(
                data: (appointmentsList) {
                  final filteredAppointments = _filterAppointments(appointmentsList);
                  return AppointmentsTable(
                    appointments: filteredAppointments,
                    subSection: widget.subSection,
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
                        'Error loading appointments',
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
                        onPressed: () => ref.refresh(appointmentsProvider(widget.subSection)),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<dynamic> _filterAppointments(List<dynamic> appointments) {
    return appointments.where((appointment) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesSearch = appointment.email.toLowerCase().contains(query) ||
            appointment.phone.contains(query) ||
            appointment.customer.toLowerCase().contains(query);
        if (!matchesSearch) return false;
      }

      // Status filter
      if (_statusFilter != 'All' && appointment.status != _statusFilter) {
        return false;
      }

      // Date range filter (for past appointments)
      if (_dateRange != null && widget.subSection == 'past') {
        final appointmentDate = appointment.createdAt;
        if (appointmentDate.isBefore(_dateRange!.start) ||
            appointmentDate.isAfter(_dateRange!.end)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  void _showCreateAppointmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Appointment'),
        content: const Text('Appointment creation form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}