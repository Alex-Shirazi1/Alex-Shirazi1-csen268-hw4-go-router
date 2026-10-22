import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/routerdemo.dart';
import '../../widgets/demo_page.dart';
import '../../model/user.dart';
import '../../widgets/user_list_tile.dart';
import '../../widgets/logout_button.dart';

class RouterDemoUsers extends StatelessWidget {
  const RouterDemoUsers({super.key, this.filter});
  final String? filter;
  @override
  Widget build(BuildContext context) {
    final users = User.mockUsers()
        .where(
          (user) => user.fullName.toLowerCase().contains(
            (filter ?? '').toLowerCase(),
          ),
        )
        .toList();
    return DemoPage(
      title: 'Users',
      children: [
        if (filter != null && filter!.isNotEmpty) Text('Filter: $filter'),
        ...users.map(
          (user) => UserListTile(
            user: user,
            onTap: () => context.goNamed(
              RouteName.userDetail,
              pathParameters: {'userId': user.uid},
            ),
          ),
        ),
        if (users.isEmpty) const Text('No users match this filter.'),
        const LogoutButton(),
      ],
    );
  }
}
