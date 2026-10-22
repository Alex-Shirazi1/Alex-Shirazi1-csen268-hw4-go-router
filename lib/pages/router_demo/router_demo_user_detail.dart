import 'package:material_ui/material_ui.dart';

import '../../widgets/demo_page.dart';
import '../../model/user.dart';

class RouterDemoUserDetail extends StatelessWidget {
  const RouterDemoUserDetail({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    final user = User.mockUsers()
        .where((user) => user.uid == userId)
        .firstOrNull;
    return DemoPage(
      title: 'User Detail',
      children: [
        Text('User ID: $userId'),
        if (user != null) ...[
          Text(user.fullName),
          Text(user.email),
        ] else
          const Text('User not found.'),
      ],
    );
  }
}
