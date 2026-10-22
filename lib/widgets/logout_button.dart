import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) => FilledButton(
          onPressed: state is AuthenticationWaiting
              ? null
              : () => context.read<AuthenticationBloc>().add(
                  AuthenticationSignOutEvent(),
                ),
          child: const Text('Logout'),
        ),
      );
}
