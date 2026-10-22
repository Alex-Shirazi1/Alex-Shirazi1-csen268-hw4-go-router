import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/routerdemo.dart';
import '../../widgets/demo_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';

class RouterDemoLogin extends StatelessWidget {
  const RouterDemoLogin({super.key});
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) => DemoPage(
          title: 'Login',
          children: [
            const Text(
              'You are not logged in. Login sends an AuthenticationWithEmailEvent; the router redirects when authentication succeeds.',
            ),
            if (state is AuthenticationError) Text(state.errorText),
            if (state is AuthenticationWaiting)
              const Center(child: CircularProgressIndicator()),
            FilledButton(
              onPressed: state is AuthenticationWaiting
                  ? null
                  : () => context.read<AuthenticationBloc>().add(
                      AuthenticationWithEmailEvent(
                        email: 'demo@example.com',
                        password: 'demo1234',
                      ),
                    ),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => context.goNamed(RouteName.signUp),
              child: const Text('Sign up'),
            ),
            TextButton(
              onPressed: () => context.goNamed(RouteName.forgotPassword),
              child: const Text('Forgot password'),
            ),
          ],
        ),
      );
}
