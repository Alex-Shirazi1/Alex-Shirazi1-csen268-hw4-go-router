import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/routerdemo.dart';
import '../../widgets/demo_page.dart';

class RouterDemoNotFound extends StatelessWidget {
  const RouterDemoNotFound({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) => DemoPage(
    title: 'Page Not Found',
    children: [
      Text('No page exists at $path'),
      FilledButton(
        onPressed: () => context.goNamed(RouteName.byAuthor),
        child: const Text('Go to Books'),
      ),
    ],
  );
}
