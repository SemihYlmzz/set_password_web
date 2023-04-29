import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:set_new_password/screen/change_password_screen.dart';
import 'package:set_new_password/screen/home_screen.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _key,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: HomeScreen.routeName,
        path: '/',
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/:resetlink',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ChangePasswordScreen(
              oobCode: state.queryParams['oobCode'] ?? '',
            ),
          );
        },
      ),
    ],
  );
});
