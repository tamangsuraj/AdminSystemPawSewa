import 'package:flutter/material.dart';

class AppointmentsFilterBar extends StatelessWidget {
  final String subSection;
  final String searchQuery;
  final String statusFilter;
  final DateTimeRange? dateRange;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;

  const AppointmentsFilterBar({
    super.key,
    required this.subSection,
    required this.searchQuery,
    required this.statusFilter,
    required this.dateRange,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onDateRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Search Field
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search appointments',
                      hintText: 'Search by email, phone, or customer name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: onSearchChanged,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Status Filter
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: statusFilter,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: _getStatusOptions().map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (value) => onStatusChanged(value ?? 'All'),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Date Range (for past appointments)
                if (subSection == 'past')
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _selectDateRange(context),
                      icon: const Icon(Icons.date_range),
                      label: Text(
                        dateRange == null
                            ? 'Select Date Range'
                            : '${_formatDate(dateRange!.start)} - ${_formatDate(dateRange!.end)}',
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Quick Filters
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Today'),
                  selected: false,
                  onSelected: (selected) {
                    if (selected) {
                      final today = DateTime.now();
                      onDateRangeChanged(DateTimeRange(
                        start: DateTime(today.year, today.month, today.day),
                        end: DateTime(today.year, today.month, today.day, 23, 59, 59),
                      ));
                    }
                  },
                ),
                FilterChip(
                  label: const Text('This Week'),
                  selected: false,
                  onSelected: (selected) {
                    if (selected) {
                      final now = DateTime.now();
                      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
                      final endOfWeek = startOfWeek.add(const Duration(days: 6));
                      onDateRangeChanged(DateTimeRange(
                        start: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
                        end: DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59),
                      ));
                    }
                  },
                ),
                FilterChip(
                  label: const Text('This Month'),
                  selected: false,
                  onSelected: (selected) {
                    if (selected) {
                      final now = DateTime.now();
                      final startOfMonth = DateTime(now.year, now.month, 1);
                      final endOfMonth = DateTime(now.year, now.month + 1, 0);
                      onDateRangeChanged(DateTimeRange(
                        start: startOfMonth,
                        end: DateTime(endOfMonth.year, endOfMonth.month, endOfMonth.day, 23, 59, 59),
                      ));
                    }
                  },
                ),
                if (dateRange != null)
                  ActionChip(
                    label: const Text('Clear'),
                    onPressed: () => onDateRangeChanged(null),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getStatusOptions() {
    switch (subSection) {
      case 'live':
        return ['All', 'Pending', 'Confirmed', 'In Progress', 'Assigned'];
      case 'cancelled':
        return ['All', 'Cancelled by Customer', 'Cancelled by Admin', 'No Show'];
      case 'past':
        return ['All', 'Completed', 'Cancelled'];
      default:
        return ['All'];
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: dateRange,
    );
    if (picked != null) {
      onDateRangeChanged(picked);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}