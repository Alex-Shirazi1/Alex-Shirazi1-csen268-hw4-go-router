import 'package:material_ui/material_ui.dart';

import '../../widgets/demo_page.dart';

class RouterDemoSignUp extends StatelessWidget {
  const RouterDemoSignUp({super.key});
  @override
  Widget build(BuildContext context) => const DemoPage(
    title: 'Sign up',
    children: [Center(child: Text('Demo signup page. No account is created.'))],
  );
}
