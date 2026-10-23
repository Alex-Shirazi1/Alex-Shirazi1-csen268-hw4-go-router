import 'package:material_ui/material_ui.dart';

import '../../widgets/logout_button.dart';

class RouterDemoProfile extends StatelessWidget {
  const RouterDemoProfile({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Profile'),
      automaticallyImplyLeading: false,
    ),
    body: const Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: SizedBox(width: double.infinity, child: LogoutButton()),
      ),
    ),
  );
}
