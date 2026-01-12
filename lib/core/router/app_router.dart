import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/appointments/presentation/pages/appointment_details_page.dart';
import '../../features/orders/presentation/pages/order_details_page.dart';
import '../../shared/presentation/pages/not_found_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      // Check if user is logged in by checking the auth state
      final authState = ref.read(authNotifierProvider);
      final isLoggedIn = authState.hasValue && authState.value != null;
      final isLoginRoute = state.matchedLocation == '/login';
      
      if (!isLoggedIn && !isLoginRoute) {
        return '/login';
      }
      
      if (isLoggedIn && isLoginRoute) {
        return '/';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/appointments/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AppointmentDetailsPage(appointmentId: id);
        },
      ),
      GoRoute(
        path: '/orders/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return OrderDetailsPage(orderId: id);
        },
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
});