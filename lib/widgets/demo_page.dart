import 'package:material_ui/material_ui.dart';

import 'print_route.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key, required this.title, required this.children});
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const PrintRoute(),
              const SizedBox(height: 24),
              ...children.expand(
                (child) => [child, const SizedBox(height: 16)],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
