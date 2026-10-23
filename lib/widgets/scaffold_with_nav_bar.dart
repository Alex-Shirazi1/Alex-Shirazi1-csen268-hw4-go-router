import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../navigation/routerdemo.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    final index = path.startsWith('/profile')
        ? 2
        : path.startsWith('/byTitle')
        ? 1
        : 0;
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (index) => context.goNamed(
          [RouteName.byAuthor, RouteName.byTitle, RouteName.profile][index],
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'By Author',
          ),
          NavigationDestination(
            icon: Icon(Icons.text_fields),
            label: 'By Title',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
