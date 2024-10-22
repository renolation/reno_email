import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reno_email/features/domain/email_entity.dart';
import 'package:reno_email/features/presentation/create_screen/page/create_page.dart';
import 'package:reno_email/features/presentation/detail_screen/page/detail_page.dart';
import 'package:reno_email/features/presentation/home_screen/page/home_page.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: "create",
            builder: (context, state) => const CreatePage(),
          ),
          GoRoute(
            path: "detail",
            builder: (context, state) {
              EmailEntity email = state.extra as EmailEntity;
              return DetailPage(emailEntity: email);
            },
          )
        ]
      ),

    ],
  );
});
