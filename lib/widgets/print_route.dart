import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

class PrintRoute extends StatelessWidget {
  const PrintRoute({super.key});
  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Route'),
          Text(
            router.routerDelegate.currentConfiguration.isError
                ? 'Unmatched route'
                : (router.state.fullPath ?? 'Unmatched route'),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            router.routerDelegate.currentConfiguration.isError
                ? router.routerDelegate.currentConfiguration.uri.toString()
                : router.state.uri.toString(),
          ),
        ],
      ),
    );
  }
}
