import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reno_email/features/presentation/home_screen/page/home_page.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomePage(),
      ),
      // GoRoute(
      //   path: "/settings",
      //   builder: (context, state) => const SettingsPage(),
      // )
    ],
  );
});
