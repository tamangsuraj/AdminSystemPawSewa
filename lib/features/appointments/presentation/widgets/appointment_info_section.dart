import 'package:flutter/material.dart';
import '../../../../shared/models/appointment.dart';

class AppointmentInfoSection extends StatelessWidget {
  final Appointment appointment;

  const AppointmentInfoSection({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Customer Information
        _buildInfoCard(
          context,
          'Customer Information',
          Icons.person,
          [
            _buildInfoRow('Name', appointment.customer),
            _buildInfoRow('Phone', appointment.phone),
            _buildInfoRow('Email', appointment.email),
            _buildInfoRow('Address', appointment.address),
          ],
        ),
        const SizedBox(height: 16),

        // Pet Information
        _buildInfoCard(
          context,
          'Pet Information',
          Icons.pets,
          [
            _buildInfoRow('Pet Name', appointment.pet),
            _buildInfoRow('Breed', appointment.breed),
            _buildInfoRow('Age', appointment.age),
            _buildInfoRow('Weight', appointment.weight),
            _buildInfoRow('Previous Visits', appointment.previousVisits.toString()),
          ],
        ),
        const SizedBox(height: 16),

        // Appointment Details
        _buildInfoCard(
          context,
          'Appointment Details',
          Icons.calendar_today,
          [
            _buildInfoRow('Service', appointment.service),
            _buildInfoRow('Date', appointment.scheduledDate),
            _buildInfoRow('Time', appointment.scheduledTime),
            _buildInfoRow('Duration', appointment.estimatedDuration),
            _buildInfoRow('Type', appointment.orderType),
            _buildInfoRow('Payment Method', appointment.paymentMethod),
          ],
        ),
        const SizedBox(height: 16),

        // Veterinarian Information
        if (appointment.vet.isNotEmpty)
          _buildInfoCard(
            context,
            'Assigned Veterinarian',
            Icons.medical_services,
            [
              _buildInfoRow('Vet Name', appointment.vet),
              _buildInfoRow('Vet Phone', appointment.vetPhone),
            ],
          ),
        const SizedBox(height: 16),

        // Notes
        if (appointment.notes.isNotEmpty)
          _buildInfoCard(
            context,
            'Notes & Remarks',
            Icons.note,
            [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  appointment.notes,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
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
}