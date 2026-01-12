import 'dart:async';
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
  final authState = ref.watch(currentUserProvider);
  
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final user = authState;
      final isLoggedIn = user != null;
      final isLoginRoute = state.matchedLocation == '/login';
      
      // Debug print to see what's happening
      print('Router redirect - isLoggedIn: $isLoggedIn, isLoginRoute: $isLoginRoute, path: ${state.matchedLocation}');
      
      // If not logged in and trying to access protected route, redirect to login
      if (!isLoggedIn && !isLoginRoute) {
        return '/login';
      }
      
      // If logged in and on login page, redirect to dashboard
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