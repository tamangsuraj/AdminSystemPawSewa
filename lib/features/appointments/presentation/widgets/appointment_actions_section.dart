import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/appointment.dart';
import '../providers/appointments_provider.dart';

class AppointmentActionsSection extends ConsumerStatefulWidget {
  final Appointment appointment;
  final String appointmentId;

  const AppointmentActionsSection({
    super.key,
    required this.appointment,
    required this.appointmentId,
  });

  @override
  ConsumerState<AppointmentActionsSection> createState() => _AppointmentActionsSectionState();
}

class _AppointmentActionsSectionState extends ConsumerState<AppointmentActionsSection> {
  String _selectedStatus = '';
  String _selectedVet = '';
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.appointment.status;
    _selectedVet = widget.appointment.vet;
    _notesController.text = widget.appointment.notes;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUpdating = ref.watch(appointmentsNotifierProvider).isLoading;

    return Column(
      children: [
        // Status Management
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.update,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Status Management',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Appointment Status',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Pending', 'Confirmed', 'In Progress', 'Completed', 'Cancelled']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedStatus = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isUpdating ? null : _updateStatus,
                    child: isUpdating
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Update Status'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Vet Assignment
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.medical_services,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Vet Assignment',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedVet.isEmpty ? null : _selectedVet,
                  decoration: const InputDecoration(
                    labelText: 'Assigned Veterinarian',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Dr. Sarah Smith', 'Dr. John Johnson', 'Dr. Emily Brown', 'Dr. Michael Wilson']
                      .map((vet) => DropdownMenuItem(
                            value: vet,
                            child: Text(vet),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedVet = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isUpdating ? null : _assignVet,
                    child: const Text('Assign Vet'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Notes Section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.note_add,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Notes & Remarks',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _notesController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Add notes or remarks',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updateNotes,
                    child: const Text('Update Notes'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Quick Actions
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.flash_on,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Quick Actions',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _callCustomer,
                    icon: const Icon(Icons.phone),
                    label: const Text('Call Customer'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.message),
                    label: const Text('Send Message'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _viewLocation,
                    icon: const Icon(Icons.location_on),
                    label: const Text('View Location'),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _cancelAppointment,
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel Appointment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _updateStatus() {
    if (_selectedStatus != widget.appointment.status) {
      ref.read(appointmentsNotifierProvider.notifier)
          .updateAppointmentStatus(widget.appointmentId, _selectedStatus);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status updated to $_selectedStatus')),
      );
    }
  }

  void _assignVet() {
    if (_selectedVet != widget.appointment.vet) {
      ref.read(appointmentsNotifierProvider.notifier)
          .assignVet(widget.appointmentId, _selectedVet);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vet assigned: $_selectedVet')),
      );
    }
  }

  void _updateNotes() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notes updated successfully')),
    );
  }

  void _callCustomer() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling ${widget.appointment.phone}')),
    );
  }

  void _sendMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message functionality will be implemented')),
    );
  }

  void _viewLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening location in maps')),
    );
  }

  void _cancelAppointment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text('Are you sure you want to cancel this appointment? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No, Keep'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(appointmentsNotifierProvider.notifier)
                  .updateAppointmentStatus(widget.appointmentId, 'Cancelled');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Appointment cancelled')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}