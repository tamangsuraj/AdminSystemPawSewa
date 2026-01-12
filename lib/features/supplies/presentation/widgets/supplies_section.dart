import 'package:flutter/material.dart';

class SuppliesSection extends StatelessWidget {
  final String subSection;

  const SuppliesSection({
    super.key,
    required this.subSection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pet Supplies - ${subSection.toUpperCase()}',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text('$subSection supplies will be displayed here'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}