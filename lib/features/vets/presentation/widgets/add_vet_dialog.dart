import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/vet.dart';
import '../providers/vets_provider.dart';

class AddVetDialog extends ConsumerStatefulWidget {
  final Vet? vet; // null for add, non-null for edit

  const AddVetDialog({super.key, this.vet});

  @override
  ConsumerState<AddVetDialog> createState() => _AddVetDialogState();
}

class _AddVetDialogState extends ConsumerState<AddVetDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _specializationController = TextEditingController();
  String _selectedZone = 'Kathmandu Central';
  String _selectedStatus = 'Available';
  bool _enabled = true;

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

  final List<String> _statuses = [
    'Available',
    'On Duty',
    'Offline',
  ];

  final List<String> _specializations = [
    'General Practice',
    'Surgery',
    'Dermatology',
    'Cardiology',
    'Emergency Care',
    'Orthopedics',
    'Oncology',
    'Neurology',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.vet != null) {
      _nameController.text = widget.vet!.name;
      _phoneController.text = widget.vet!.phone;
      _emailController.text = widget.vet!.email;
      _specializationController.text = widget.vet!.specialization;
      _selectedZone = widget.vet!.zone;
      _selectedStatus = widget.vet!.status;
      _enabled = widget.vet!.enabled;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(vetsNotifierProvider).isLoading;
    final isEditing = widget.vet != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Vet' : 'Add New Vet'),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name *',
                    hintText: 'Dr. John Doe',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter vet name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Phone
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number *',
                    hintText: '+977-9841234567',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address *',
                    hintText: 'john.doe@pawsewa.com',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter email address';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Specialization
                DropdownButtonFormField<String>(
                  value: _specializationController.text.isEmpty 
                      ? _specializations.first 
                      : _specializationController.text,
                  decoration: const InputDecoration(
                    labelText: 'Specialization *',
                    border: OutlineInputBorder(),
                  ),
                  items: _specializations.map((spec) {
                    return DropdownMenuItem(
                      value: spec,
                      child: Text(spec),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _specializationController.text = value;
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Zone
                DropdownButtonFormField<String>(
                  value: _selectedZone,
                  decoration: const InputDecoration(
                    labelText: 'Assigned Zone *',
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
                const SizedBox(height: 16),

                // Status
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: _statuses.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedStatus = value);
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Enabled toggle
                SwitchListTile(
                  title: const Text('Active Status'),
                  subtitle: Text(_enabled ? 'Vet is active' : 'Vet is disabled'),
                  value: _enabled,
                  onChanged: (value) => setState(() => _enabled = value),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : _saveVet,
          child: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(isEditing ? 'Update' : 'Add Vet'),
        ),
      ],
    );
  }

  Future<void> _saveVet() async {
    if (!_formKey.currentState!.validate()) return;

    final vet = Vet(
      id: widget.vet?.id ?? 'vet_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      zone: _selectedZone,
      status: _selectedStatus,
      specialization: _specializationController.text.isEmpty 
          ? _specializations.first 
          : _specializationController.text,
      todayAppointments: widget.vet?.todayAppointments ?? 0,
      totalCompleted: widget.vet?.totalCompleted ?? 0,
      earnings: widget.vet?.earnings ?? const VetEarnings(salary: 0, commission: 0),
      enabled: _enabled,
      joinDate: widget.vet?.joinDate ?? DateTime.now(),
    );

    try {
      if (widget.vet != null) {
        await ref.read(vetsNotifierProvider.notifier).updateVet(vet);
      } else {
        await ref.read(vetsNotifierProvider.notifier).addVet(vet);
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.vet != null ? 'Vet updated successfully' : 'Vet added successfully'),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${error.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}