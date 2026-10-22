import 'package:material_ui/material_ui.dart';

import '../model/user.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    final initials =
        (user.firstName.isEmpty ? '' : user.firstName[0]) +
        (user.lastName.isEmpty ? '' : user.lastName[0]);
    final fallback = CircleAvatar(child: Text(initials));
    if (user.imageUrl.isEmpty) return fallback;
    return ClipOval(
      child: Image.network(
        user.imageUrl,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => fallback,
      ),
    );
  }
}
