import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/models/appointment.dart';
import '../providers/appointments_provider.dart';

class AppointmentsTable extends ConsumerWidget {
  final List<Appointment> appointments;
  final String subSection;

  const AppointmentsTable({
    super.key,
    required this.appointments,
    required this.subSection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No appointments found',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Appointments will appear here when they are created.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 100,
        ),
        child: DataTable(
          columnSpacing: 16,
          horizontalMargin: 16,
          columns: _buildColumns(),
          rows: appointments.map((appointment) => _buildRow(context, ref, appointment)).toList(),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      const DataColumn(label: Text('Email')),
      const DataColumn(label: Text('Phone')),
      const DataColumn(label: Text('Order #')),
      const DataColumn(label: Text('Customer')),
      const DataColumn(label: Text('Pet')),
      const DataColumn(label: Text('Service')),
      const DataColumn(label: Text('Date')),
      const DataColumn(label: Text('Time')),
      const DataColumn(label: Text('Status')),
      if (subSection == 'live') ...[
        const DataColumn(label: Text('Vet')),
        const DataColumn(label: Text('Staff')),
      ],
      const DataColumn(label: Text('Actions')),
    ];
  }

  DataRow _buildRow(BuildContext context, WidgetRef ref, Appointment appointment) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            appointment.email,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        DataCell(Text(appointment.phone)),
        DataCell(
          Text(
            appointment.id.substring(0, 8),
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        ),
        DataCell(Text(appointment.customer)),
        DataCell(Text(appointment.pet)),
        DataCell(Text(appointment.service)),
        DataCell(Text(appointment.scheduledDate)),
        DataCell(Text(appointment.scheduledTime)),
        DataCell(_buildStatusChip(context, ref, appointment)),
        if (subSection == 'live') ...[
          DataCell(_buildVetDropdown(context, ref, appointment)),
          DataCell(_buildStaffDropdown(context, ref, appointment)),
        ],
        DataCell(_buildActions(context, appointment)),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context, WidgetRef ref, Appointment appointment) {
    Color chipColor;
    switch (appointment.status.toLowerCase()) {
      case 'pending':
        chipColor = Colors.orange;
        break;
      case 'confirmed':
        chipColor = Colors.blue;
        break;
      case 'in progress':
        chipColor = Colors.purple;
        break;
      case 'completed':
        chipColor = Colors.green;
        break;
      case 'cancelled':
        chipColor = Colors.red;
        break;
      default:
        chipColor = Colors.grey;
    }

    if (subSection == 'live') {
      return DropdownButton<String>(
        value: appointment.status,
        underline: Container(),
        items: ['Pending', 'Confirmed', 'In Progress', 'Completed', 'Cancelled']
            .map((status) => DropdownMenuItem(
                  value: status,
                  child: Chip(
                    label: Text(
                      status,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    backgroundColor: _getStatusColor(status),
                  ),
                ))
            .toList(),
        onChanged: (newStatus) {
          if (newStatus != null) {
            ref.read(appointmentsNotifierProvider.notifier)
                .updateAppointmentStatus(appointment.id, newStatus);
          }
        },
      );
    }

    return Chip(
      label: Text(
        appointment.status,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      backgroundColor: chipColor,
    );
  }

  Widget _buildVetDropdown(BuildContext context, WidgetRef ref, Appointment appointment) {
    return DropdownButton<String>(
      value: appointment.vet.isEmpty ? null : appointment.vet,
      hint: const Text('Assign Vet'),
      underline: Container(),
      items: ['Dr. Smith', 'Dr. Johnson', 'Dr. Brown', 'Dr. Wilson']
          .map((vet) => DropdownMenuItem(
                value: vet,
                child: Text(vet, style: const TextStyle(fontSize: 12)),
              ))
          .toList(),
      onChanged: (newVet) {
        if (newVet != null) {
          ref.read(appointmentsNotifierProvider.notifier)
              .assignVet(appointment.id, newVet);
        }
      },
    );
  }

  Widget _buildStaffDropdown(BuildContext context, WidgetRef ref, Appointment appointment) {
    return DropdownButton<String>(
      value: null,
      hint: const Text('Assign Staff'),
      underline: Container(),
      items: ['Staff A', 'Staff B', 'Staff C']
          .map((staff) => DropdownMenuItem(
                value: staff,
                child: Text(staff, style: const TextStyle(fontSize: 12)),
              ))
          .toList(),
      onChanged: (newStaff) {
        // Handle staff assignment
      },
    );
  }

  Widget _buildActions(BuildContext context, Appointment appointment) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.visibility, size: 18),
          onPressed: () => context.go('/appointments/${appointment.id}'),
          tooltip: 'View Details',
        ),
        if (subSection == 'live')
          IconButton(
            icon: const Icon(Icons.edit, size: 18),
            onPressed: () => _showEditDialog(context, appointment),
            tooltip: 'Edit',
          ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'in progress':
        return Colors.purple;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showEditDialog(BuildContext context, Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Appointment - ${appointment.id.substring(0, 8)}'),
        content: const Text('Edit appointment form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}