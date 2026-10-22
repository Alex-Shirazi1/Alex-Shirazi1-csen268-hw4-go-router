import 'package:material_ui/material_ui.dart';

import '../model/user.dart';
import 'user_avatar.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({super.key, required this.user, required this.onTap});
  final User user;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ListTile(
    leading: UserAvatar(user: user),
    title: Text(user.fullName),
    subtitle: Text(user.email),
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap,
  );
}
