import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:csen268_hw4_go_router/main.dart';
import 'package:csen268_hw4_go_router/blocs/authentication/authentication_bloc.dart';
import 'package:csen268_hw4_go_router/repositories/authentication/authentication_repository.dart';

Future<GoRouter> startApp(
  WidgetTester tester, {
  bool loggedIn = false,
  Duration delay = Duration.zero,
}) async {
  final repository = MockAuthenticationRepository(delay: delay);
  final bloc = AuthenticationBloc(repository);
  await tester.pumpWidget(
    HomeworkApp(repository: repository, authenticationBloc: bloc),
  );
  await tester.pumpAndSettle();
  if (loggedIn) await tapLabel(tester, 'Login');
  return GoRouter.of(tester.element(find.byType(Scaffold).last));
}

Future<void> tapLabel(WidgetTester tester, String label) async {
  final target = switch (label) {
    'Login' ||
    'Logout' ||
    'Go to Books' => find.widgetWithText(FilledButton, label),
    _ => find.text(label).last,
  };
  await tester.tap(target);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 1));
  await tester.pumpAndSettle();
}

Future<void> back(WidgetTester tester) async {
  await tester.tap(find.byType(BackButton));
  await tester.pumpAndSettle();
}
