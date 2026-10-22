import 'package:material_ui/material_ui.dart';

import '../../widgets/demo_page.dart';

class RouterDemoForgotPassword extends StatelessWidget {
  const RouterDemoForgotPassword({super.key});
  @override
  Widget build(BuildContext context) => const DemoPage(
    title: 'Forgot password',
    children: [
      Center(child: Text('Demo password recovery page. No email is sent.')),
    ],
  );
}
