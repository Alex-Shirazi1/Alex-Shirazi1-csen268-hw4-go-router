import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../navigation/routerdemo.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: child,
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _calculateSelectedIndex(context),
      onTap: (index) => _onItemTapped(index, context),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Users'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    ),
  );
  int _calculateSelectedIndex(BuildContext context) =>
      GoRouterState.of(context).uri.path.startsWith('/profile') ? 1 : 0;
  void _onItemTapped(int index, BuildContext context) =>
      context.goNamed(index == 0 ? RouteName.users : RouteName.profile);
}
