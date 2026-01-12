import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/vet.dart';
import '../providers/vets_provider.dart';

class VetDetailsDialog extends ConsumerStatefulWidget {
  final Vet vet;

  const VetDetailsDialog({super.key, required this.vet});

  @override
  ConsumerState<VetDetailsDialog> createState() => _VetDetailsDialogState();
}

class _VetDetailsDialogState extends ConsumerState<VetDetailsDialog> {
  String _selectedZone = '';

  final List<String> _zones = [
    'Kathmandu Central',
    'Kathmandu North',
    'Kathmandu South',
    'Lalitpur',
    'Bhaktapur',
    'Pokhara',
    'Chitwan',
    'Butwal',
    'Biratnagar',
    'Dharan',
  ];

  @override
  void initState() {
    super.initState();
    _selectedZone = widget.vet.zone;
  }

  @override
  Widget build(BuildContext context) {
    final isUpdating = ref.watch(vetsNotifierProvider).isLoading;

    return AlertDialog(
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              widget.vet.name.split(' ').map((n) => n[0]).take(2).join(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.vet.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.vet.specialization,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          _buildStatusChip(context),
        ],
      ),
      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Information
              _buildSection(
                context,
                'Contact Information',
                Icons.contact_phone,
                [
                  _buildInfoRow('Phone', widget.vet.phone),
                  _buildInfoRow('Email', widget.vet.email),
                  _buildInfoRow('Join Date', _formatDate(widget.vet.joinDate)),
                ],
              ),
              const SizedBox(height: 16),

              // Performance Stats
              _buildSection(
                context,
                'Performance Statistics',
                Icons.analytics,
                [
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Today\'s Appointments',
                          widget.vet.todayAppointments.toString(),
                          Icons.today,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Total Completed',
                          widget.vet.totalCompleted.toString(),
                          Icons.check_circle,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Earnings Summary
              _buildSection(
                context,
                'Earnings Summary',
                Icons.account_balance_wallet,
                [
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Monthly Salary',
                          'NPR ${widget.vet.earnings.salary.toStringAsFixed(0)}',
                          Icons.payments,
                          Colors.purple,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Commission',
                          'NPR ${widget.vet.earnings.commission.toStringAsFixed(0)}',
                          Icons.trending_up,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Zone Assignment
              _buildSection(
                context,
                'Zone Assignment',
                Icons.location_on,
                [
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedZone,
                          decoration: const InputDecoration(
                            labelText: 'Assigned Zone',
                            border: OutlineInputBorder(),
                          ),
                          items: _zones.map((zone) {
                            return DropdownMenuItem(
                              value: zone,
                              child: Text(zone),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedZone = value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: isUpdating ? null : _updateZone,
                        child: isUpdating
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Update Zone'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
        OutlinedButton.icon(
          onPressed: _callVet,
          icon: const Icon(Icons.phone),
          label: const Text('Call'),
        ),
        OutlinedButton.icon(
          onPressed: _emailVet,
          icon: const Icon(Icons.email),
          label: const Text('Email'),
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color chipColor;
    switch (widget.vet.status) {
      case 'Available':
        chipColor = Colors.green;
        break;
      case 'On Duty':
        chipColor = Colors.blue;
        break;
      case 'Offline':
        chipColor = Colors.grey;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Chip(
      label: Text(
        widget.vet.status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: chipColor,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _updateZone() {
    if (_selectedZone != widget.vet.zone) {
      ref.read(vetsNotifierProvider.notifier).updateVetZone(widget.vet.id, _selectedZone);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Zone updated to $_selectedZone')),
      );
    }
  }

  void _callVet() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling ${widget.vet.phone}')),
    );
  }

  void _emailVet() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening email to ${widget.vet.email}')),
    );
  }
}