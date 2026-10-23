import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../utilities/stream_to_listenable.dart';
import '../widgets/scaffold_with_nav_bar.dart';
import '../data/book_data.dart';
import '../models/book.dart';
import '../pages/book_list_page.dart';
import '../pages/book_detail_page.dart';
import '../pages/router_demo/router_demo_login.dart';
import '../pages/router_demo/router_demo_profile.dart';
import '../pages/router_demo/router_demo_not_found.dart';

class RouteName {
  static const home = 'home',
      byAuthor = 'byAuthor',
      byAuthorDetail = 'byAuthorDetail',
      byTitle = 'byTitle',
      byTitleDetail = 'byTitleDetail',
      profile = 'profile',
      login = 'login';
}

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');
final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Shell');
GoRouter routerDemo(AuthenticationBloc authenticationBloc) {
  final refresh = StreamToListenable([authenticationBloc.stream]);
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/byAuthor',
    refreshListenable: refresh,
    redirect: (context, state) {
      final loggedIn = authenticationBloc.state is AuthenticationAuthenticated;
      final atLogin = state.matchedLocation == '/login';
      if (loggedIn && atLogin) return '/byAuthor';
      if (!loggedIn && !atLogin) return '/login';
      return null;
    },
    errorBuilder: (context, state) =>
        RouterDemoNotFound(path: state.uri.toString()),
    routes: [
      GoRoute(
        path: '/login',
        name: RouteName.login,
        builder: (context, state) => const RouterDemoLogin(),
      ),
      GoRoute(
        path: '/',
        name: RouteName.home,
        redirect: (context, state) =>
            state.uri.path == '/' ? '/byAuthor' : null,
        builder: (context, state) => const SizedBox.shrink(),
        routes: [
          ShellRoute(
            navigatorKey: shellNavigatorKey,
            builder: (context, state, child) =>
                ScaffoldWithNavBar(child: child),
            routes: [
              GoRoute(
                path: 'byAuthor',
                name: RouteName.byAuthor,
                builder: (context, state) =>
                    const BookListPage(sort: BookSort.author),
                routes: [
                  GoRoute(
                    path: 'detail',
                    name: RouteName.byAuthorDetail,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => BookDetailPage(
                      book: state.extra is Book ? state.extra as Book : null,
                      parentRoute: RouteName.byAuthor,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'byTitle',
                name: RouteName.byTitle,
                builder: (context, state) =>
                    const BookListPage(sort: BookSort.title),
                routes: [
                  GoRoute(
                    path: 'detail',
                    name: RouteName.byTitleDetail,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => BookDetailPage(
                      book: state.extra is Book ? state.extra as Book : null,
                      parentRoute: RouteName.byTitle,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'profile',
                name: RouteName.profile,
                builder: (context, state) => const RouterDemoProfile(),
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

// The router removes its listener; we also cancel the bloc subscription.
final _refreshAdapters = Expando<StreamToListenable>();
void disposeRouter(GoRouter router) {
  router.dispose();
  _refreshAdapters[router]?.dispose();
  _refreshAdapters[router] = null;
}
