import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../data/book_data.dart';
import '../navigation/routerdemo.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key, required this.sort});
  final BookSort sort;
  @override
  Widget build(BuildContext context) {
    final books = sortedBooks(sort);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Profile',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => context.goNamed(RouteName.profile),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Sorted by ${sort == BookSort.author ? 'Author' : 'Title'}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            for (final book in books)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  child: ListTile(
                    key: ValueKey('book-${book.id}'),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    onTap: () => context.goNamed(
                      sort == BookSort.author
                          ? RouteName.byAuthorDetail
                          : RouteName.byTitleDetail,
                      extra: book,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
