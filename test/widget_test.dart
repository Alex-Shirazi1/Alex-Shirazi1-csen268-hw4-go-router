import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'test_harness.dart';

void main() {
  testWidgets('logged out start and login redirect show Users shell', (
    tester,
  ) async {
    final router = await startApp(tester);
    expect(router.state.uri.path, '/login');
    expect(find.text('/login'), findsWidgets);
    expect(find.byType(BottomNavigationBar), findsNothing);
    await tapLabel(tester, 'Login');
    expect(router.state.uri.path, '/users');
    expect(
      tester
          .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
          .currentIndex,
      0,
    );
    expect(find.text('Alex Shirazi'), findsOneWidget);
    expect(find.text('Jordan Lee'), findsOneWidget);
    expect(find.text('Sam Rivera'), findsOneWidget);
  });
  testWidgets('login remains disabled while waiting', (tester) async {
    await startApp(tester, delay: const Duration(seconds: 1));
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Login'))
          .onPressed,
      isNull,
    );
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
