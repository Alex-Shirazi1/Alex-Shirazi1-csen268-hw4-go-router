import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'navigation/routerdemo.dart';
import 'repositories/authentication/authentication_repository.dart';

void main() {
  if (kIsWeb) usePathUrlStrategy();
  final repository = MockAuthenticationRepository();
  final authenticationBloc = AuthenticationBloc(repository);
  runApp(
    HomeworkApp(repository: repository, authenticationBloc: authenticationBloc),
  );
}

class HomeworkApp extends StatefulWidget {
  const HomeworkApp({
    super.key,
    required this.repository,
    required this.authenticationBloc,
  });
  final AuthenticationRepository repository;
  final AuthenticationBloc authenticationBloc;
  @override
  State<HomeworkApp> createState() => _HomeworkAppState();
}

class _HomeworkAppState extends State<HomeworkApp> {
  late final GoRouter router = routerDemo(widget.authenticationBloc);
  @override
  void dispose() {
    disposeRouter(router);
    widget.authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthenticationRepository>.value(
        value: widget.repository,
      ),
    ],
    child: BlocProvider.value(
      value: widget.authenticationBloc,
      child: MaterialApp.router(
        title: 'CSEN 268 HW4 GoRouter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          splashFactory: InkRipple.splashFactory,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF67558F)),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        routerConfig: router,
      ),
    ),
  );
}
