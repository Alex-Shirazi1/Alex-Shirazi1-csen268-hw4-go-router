import 'package:material_ui/material_ui.dart';

import '../../widgets/demo_page.dart';

class RouterDemoProfileDetail extends StatelessWidget {
  const RouterDemoProfileDetail({super.key});
  @override
  Widget build(BuildContext context) => const DemoPage(
    title: 'Profile',
    children: [Center(child: Text('Profile Detail Page'))],
  );
}
