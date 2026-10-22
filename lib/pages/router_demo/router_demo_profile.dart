import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/routerdemo.dart';
import '../../widgets/demo_page.dart';
import '../../widgets/logout_button.dart';

class RouterDemoProfile extends StatelessWidget {
  const RouterDemoProfile({super.key});
  @override
  Widget build(BuildContext context) => DemoPage(
    title: 'Profile',
    children: [
      const Text('Router Demo Profile'),
      const LogoutButton(),
      OutlinedButton(
        onPressed: () => context.goNamed(RouteName.profileDetail),
        child: const Text('Show Detail'),
      ),
    ],
  );
}
