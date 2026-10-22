import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../utilities/stream_to_listenable.dart';
import '../widgets/scaffold_with_nav_bar.dart';
import '../pages/router_demo/router_demo_home.dart';
import '../pages/router_demo/router_demo_login.dart';
import '../pages/router_demo/router_demo_users.dart';
import '../pages/router_demo/router_demo_user_detail.dart';
import '../pages/router_demo/router_demo_profile.dart';
import '../pages/router_demo/router_demo_profile_detail.dart';
import '../pages/router_demo/router_demo_signup.dart';
import '../pages/router_demo/router_demo_forgot_password.dart';
import '../pages/router_demo/router_demo_not_found.dart';

class RouteName {
  static const home = 'home',
      login = 'login',
      signUp = 'signUp',
      forgotPassword = 'forgotPassword',
      users = 'users',
      userDetail = 'userDetail',
      profile = 'profile',
      profileDetail = 'profileDetail',
      notFound = 'notFound';
}

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');
final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Shell');
GoRouter routerDemo(AuthenticationBloc authenticationBloc) {
  final refresh = StreamToListenable([authenticationBloc.stream]);
  final router = GoRouter(
    refreshListenable: refresh,
    navigatorKey: rootNavigatorKey,
    initialLocation: '/users',
    redirect: (context, state) async {
      final onLogin = state.matchedLocation.startsWith('/login');
      if (authenticationBloc.state is AuthenticationInitial && !onLogin) {
        return '/login';
      }
      if (authenticationBloc.state is AuthenticationAuthenticated && onLogin) {
        return '/users';
      }
      return null;
    },
    errorBuilder: (context, state) =>
        RouterDemoNotFound(path: state.uri.toString()),
    routes: [
      GoRoute(
        path: '/login',
        name: RouteName.login,
        builder: (context, state) => const RouterDemoLogin(),
        routes: [
          GoRoute(
            path: 'signup',
            name: RouteName.signUp,
            builder: (context, state) => const RouterDemoSignUp(),
          ),
          GoRoute(
            path: 'forgot',
            name: RouteName.forgotPassword,
            builder: (context, state) => const RouterDemoForgotPassword(),
          ),
        ],
      ),
      GoRoute(
        path: '/',
        name: RouteName.home,
        builder: (context, state) => const RouterDemoHome(),
        routes: [
          ShellRoute(
            navigatorKey: shellNavigatorKey,
            builder: (context, state, child) =>
                ScaffoldWithNavBar(child: child),
            routes: [
              GoRoute(
                path: 'users',
                name: RouteName.users,
                builder: (context, state) => RouterDemoUsers(
                  filter: state.uri.queryParameters['filter'],
                ),
                routes: [
                  GoRoute(
                    path: ':userId',
                    name: RouteName.userDetail,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => RouterDemoUserDetail(
                      userId: state.pathParameters['userId']!,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'profile',
                name: RouteName.profile,
                builder: (context, state) => const RouterDemoProfile(),
                routes: [
                  GoRoute(
                    path: 'detail',
                    name: RouteName.profileDetail,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) =>
                        const RouterDemoProfileDetail(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
  _refreshAdapters[router] = refresh;
  return router;
}

final _refreshAdapters = Expando<StreamToListenable>();
void disposeRouter(GoRouter router) {
  router.dispose();
  _refreshAdapters[router]?.dispose();
  _refreshAdapters[router] = null;
}
