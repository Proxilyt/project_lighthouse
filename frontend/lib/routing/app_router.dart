import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/auth/phone_auth_screen.dart';
import '../features/auth/otp_screen.dart';
// import '../features/onboarding/business_setup_screen.dart';
// import '../features/results/results_screen.dart';

/// Expose GoRouter via Riverpod
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/auth',
    refreshListenable: authState,
    routes: [
      /// ---------- AUTH ----------
      GoRoute(
        path: '/auth',
        builder: (context, state) => const PhoneAuthScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final phone = state.extra as String;
          return OtpScreen(phone: phone);
        },
      ),

      /// ---------- ONBOARDING ----------
      // GoRoute(
      //   path: '/onboarding',
      //   builder: (context, state) => const BusinessSetupScreen(),
      // ),

      // /// ---------- MAIN ----------
      // GoRoute(
      //   path: '/results',
      //   builder: (context, state) => const ResultsScreen(),
      // ),
    ],

    /// ---------- AUTH GUARD ----------
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final loggedIn = session != null;

      final goingToAuth =
          state.matchedLocation == '/auth' ||
          state.matchedLocation == '/otp';

      if (!loggedIn && !goingToAuth) {
        return '/auth';
      }

      if (loggedIn && goingToAuth) {
        // Later we’ll check onboarding status here
        return '/results';
      }

      return null;
    },
  );
});

/// Listens to Supabase auth state and notifies GoRouter
final authStateProvider = ChangeNotifierProvider<AuthStateNotifier>((ref) {
  return AuthStateNotifier();
});

class AuthStateNotifier extends ChangeNotifier {
  late final StreamSubscription<AuthState> _sub;

  AuthStateNotifier() {
    _sub = Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
