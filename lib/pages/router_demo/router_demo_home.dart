import 'package:material_ui/material_ui.dart';

import '../../widgets/demo_page.dart';

class RouterDemoHome extends StatelessWidget {
  const RouterDemoHome({super.key});
  @override
  Widget build(BuildContext context) => const DemoPage(
    title: 'Home',
    children: [Center(child: Text('Router Demo Home'))],
  );
}
