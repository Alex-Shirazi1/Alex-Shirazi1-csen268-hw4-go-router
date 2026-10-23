import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../models/book.dart';
import '../widgets/book_details.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({
    super.key,
    required this.book,
    required this.parentRoute,
  });
  final Book? book;
  final String parentRoute;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Book Detail'),
      leading: BackButton(
        onPressed: () =>
            context.canPop() ? context.pop() : context.goNamed(parentRoute),
      ),
    ),
    body: SafeArea(
      child: book != null
          ? BookDetails(book: book!)
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No book selected'),
                  TextButton(
                    onPressed: () => context.goNamed(parentRoute),
                    child: const Text('Back to books'),
                  ),
                ],
              ),
            ),
    ),
  );
}
