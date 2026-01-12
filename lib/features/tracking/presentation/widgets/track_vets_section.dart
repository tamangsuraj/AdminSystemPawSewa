import 'package:flutter/material.dart';

class TrackVetsSection extends StatelessWidget {
  const TrackVetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Track Vets', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Expanded(child: Card(child: Padding(padding: const EdgeInsets.all(24), child: const Center(child: Text('Vet tracking interface'))))),
      ],
    );
  }
}