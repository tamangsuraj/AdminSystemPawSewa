import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeSectionProvider = StateProvider<String>((ref) => 'dashboard');