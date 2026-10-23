import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';

class RouterDemoLogin extends StatelessWidget {
  const RouterDemoLogin({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Login'),
      automaticallyImplyLeading: false,
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state is AuthenticationError) Text(state.errorText),
              if (state is AuthenticationWaiting)
                const CircularProgressIndicator(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
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
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
