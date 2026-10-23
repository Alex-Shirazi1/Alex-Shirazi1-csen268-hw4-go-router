import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:csen268_hw4_go_router/navigation/routerdemo.dart';
import 'package:csen268_hw4_go_router/blocs/authentication/authentication_bloc.dart';
import 'package:csen268_hw4_go_router/widgets/book_details.dart';
import 'package:csen268_hw4_go_router/data/book_data.dart';

import 'test_harness.dart';

void main() {
  testWidgets('tabs select routes and genuinely sort the books', (
    tester,
  ) async {
    final router = await startApp(tester, loggedIn: true);
    expect(router.state.uri.path, '/byAuthor');
    expect(
      tester.widget<ListTile>(find.byType(ListTile).first).title,
      isA<Text>().having(
        (t) => t.data,
        'first book',
        'The Imperfections of Memory',
      ),
    );
    await tapLabel(tester, 'By Title');
    expect(router.state.uri.path, '/byTitle');
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      1,
    );
    expect(
      tester.widget<ListTile>(find.byType(ListTile).first).title,
      isA<Text>().having((t) => t.data, 'first book', 'A Clockwork Orange'),
    );
    await tapLabel(tester, 'Profile');
    expect(router.state.uri.path, '/profile');
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      2,
    );
    await tapLabel(tester, 'Logout');
    expect(router.state.uri.path, '/login');
    expect(find.byType(NavigationBar), findsNothing);
  });
  for (final entry in {
    'By Author': '/byAuthor',
    'By Title': '/byTitle',
  }.entries) {
    testWidgets(
      '${entry.key} detail displays selection and back returns to parent',
      (tester) async {
        final router = await startApp(tester, loggedIn: true);
        await tapLabel(tester, entry.key);
        await tester.tap(find.byKey(const ValueKey('book-clockwork')));
        await tester.pumpAndSettle();
        expect(router.state.uri.path, '${entry.value}/detail');
        expect(find.byType(NavigationBar), findsNothing);
        expect(
          tester.widget<BookDetails>(find.byType(BookDetails)).book.id,
          'clockwork',
        );
        await back(tester);
        expect(router.state.uri.path, entry.value);
        expect(find.byType(NavigationBar), findsOneWidget);
      },
    );
    testWidgets('${entry.key} direct detail without extra has safe recovery', (
      tester,
    ) async {
      final router = await startApp(tester, loggedIn: true);
      router.go('${entry.value}/detail');
      await tester.pumpAndSettle();
      expect(find.text('No book selected'), findsOneWidget);
      await tapLabel(tester, 'Back to books');
      expect(router.state.uri.path, entry.value);
    });
  }
  testWidgets('home defaults to byAuthor and authenticated login redirects', (
    tester,
  ) async {
    final router = await startApp(tester, loggedIn: true);
    router.goNamed(RouteName.home);
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/byAuthor');
    router.goNamed(RouteName.login);
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/byAuthor');
  });
  testWidgets('every protected route rejects logged-out navigation', (
    tester,
  ) async {
    final router = await startApp(tester);
    for (final path in [
      '/',
      '/byAuthor',
      '/byTitle',
      '/profile',
      '/byAuthor/detail',
      '/byTitle/detail',
    ]) {
      router.go(path);
      await tester.pumpAndSettle();
      expect(router.state.uri.path, '/login', reason: path);
    }
  });
  testWidgets('auth error refresh redirects from a protected page', (
    tester,
  ) async {
    final router = await startApp(tester, loggedIn: true);
    final bloc = tester
        .element(find.byType(NavigationBar))
        .read<AuthenticationBloc>();
    bloc.add(AuthenticationErrorEvent(errorText: 'Session ended'));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/login');
    expect(find.text('Session ended'), findsOneWidget);
  });
  testWidgets('unknown route can recover', (tester) async {
    final router = await startApp(tester, loggedIn: true);
    router.go('/does-not-exist');
    await tester.pumpAndSettle();
    expect(find.text('Page Not Found'), findsOneWidget);
    await tapLabel(tester, 'Go to Books');
    expect(router.state.uri.path, '/byAuthor');
  });
  test('sorting leaves original book data unchanged', () {
    final original = allBooks.toList();
    expect(sortedBooks(BookSort.author).first.author, 'Angelina Aludo');
    expect(sortedBooks(BookSort.title).first.title, 'A Clockwork Orange');
    expect(allBooks, original);
  });
}
