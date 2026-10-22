import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:csen268_hw4_go_router/navigation/routerdemo.dart';

import 'test_harness.dart';

void main() {
  testWidgets(
    'tabs select correctly and profile detail escapes shell then returns',
    (tester) async {
      final router = await startApp(tester, loggedIn: true);
      await tapLabel(tester, 'Profile');
      expect(router.state.uri.path, '/profile');
      expect(
        tester
            .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
            .currentIndex,
        1,
      );
      await tapLabel(tester, 'Show Detail');
      expect(router.state.uri.path, '/profile/detail');
      expect(find.text('Profile Detail Page'), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsNothing);
      await back(tester);
      expect(router.state.uri.path, '/profile');
      await tapLabel(tester, 'Users');
      expect(router.state.uri.path, '/users');
      expect(
        tester
            .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
            .currentIndex,
        0,
      );
    },
  );
  for (final tab in ['Users', 'Profile']) {
    testWidgets('logout from $tab returns to login', (tester) async {
      final router = await startApp(tester, loggedIn: true);
      if (tab == 'Profile') await tapLabel(tester, tab);
      await tapLabel(tester, 'Logout');
      expect(router.state.uri.path, '/login');
      expect(find.byType(BottomNavigationBar), findsNothing);
    });
  }
  for (final entry in {
    'Sign up': '/login/signup',
    'Forgot password': '/login/forgot',
  }.entries) {
    testWidgets('login child ${entry.key} and back', (tester) async {
      final router = await startApp(tester);
      await tapLabel(tester, entry.key);
      expect(router.state.uri.path, entry.value);
      expect(find.byType(BottomNavigationBar), findsNothing);
      await back(tester);
      expect(router.state.uri.path, '/login');
    });
  }
  testWidgets('user parameter, detail back, and unknown user', (tester) async {
    final router = await startApp(tester, loggedIn: true);
    await tapLabel(tester, 'Alex Shirazi');
    expect(router.state.uri.path, '/users/1');
    expect(find.text('/users/:userId'), findsOneWidget);
    expect(find.text('User ID: 1'), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsNothing);
    await back(tester);
    expect(router.state.uri.path, '/users');
    router.goNamed(RouteName.userDetail, pathParameters: {'userId': '999'});
    await tester.pumpAndSettle();
    expect(find.text('User not found.'), findsOneWidget);
  });
  testWidgets('unknown location shows error and recovery button works', (
    tester,
  ) async {
    final router = await startApp(tester, loggedIn: true);
    router.go('/does-not-exist');
    await tester.pumpAndSettle();
    expect(find.text('Page Not Found'), findsOneWidget);
    expect(find.text('No page exists at /does-not-exist'), findsOneWidget);
    await tapLabel(tester, 'Go to Users');
    expect(router.state.uri.path, '/users');
  });
  testWidgets('logged in visit to login redirects to users', (tester) async {
    final router = await startApp(tester, loggedIn: true);
    router.goNamed(RouteName.login);
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/users');
  });
  testWidgets('query filtering is case insensitive and handles no results', (
    tester,
  ) async {
    final router = await startApp(tester, loggedIn: true);
    router.goNamed(RouteName.users, queryParameters: {'filter': 'aLeX'});
    await tester.pumpAndSettle();
    expect(find.text('Filter: aLeX'), findsOneWidget);
    expect(find.text('Alex Shirazi'), findsOneWidget);
    expect(find.text('Jordan Lee'), findsNothing);
    router.goNamed(RouteName.users, queryParameters: {'filter': 'nobody'});
    await tester.pumpAndSettle();
    expect(find.text('No users match this filter.'), findsOneWidget);
  });
  testWidgets('home parent is reachable outside shell', (tester) async {
    final router = await startApp(tester, loggedIn: true);
    router.goNamed(RouteName.home);
    await tester.pumpAndSettle();
    expect(find.text('Router Demo Home'), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsNothing);
  });
}
