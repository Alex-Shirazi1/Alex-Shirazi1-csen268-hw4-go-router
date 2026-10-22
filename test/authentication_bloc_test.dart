import 'package:flutter_test/flutter_test.dart';
import 'package:csen268_hw4_go_router/blocs/authentication/authentication_bloc.dart';
import 'package:csen268_hw4_go_router/model/user.dart';
import 'package:csen268_hw4_go_router/repositories/authentication/authentication_repository.dart';

void main() {
  late AuthenticationBloc bloc;
  setUp(
    () => bloc = AuthenticationBloc(
      MockAuthenticationRepository(delay: Duration.zero),
    ),
  );
  tearDown(() => bloc.close());
  test('initial state is logged out', () {
    expect(bloc.state, isA<AuthenticationInitial>());
    expect(bloc.user, isNull);
  });
  test(
    'login and logout emit waiting then terminal state and update user',
    () async {
      var states = bloc.stream.take(2).toList();
      bloc.add(
        AuthenticationWithEmailEvent(
          email: 'demo@example.com',
          password: 'demo1234',
        ),
      );
      expect(await states, [
        isA<AuthenticationWaiting>(),
        isA<AuthenticationAuthenticated>(),
      ]);
      expect(bloc.user, User.createMockUser());
      states = bloc.stream.take(2).toList();
      bloc.add(AuthenticationSignOutEvent());
      expect(await states, [
        isA<AuthenticationWaiting>(),
        isA<AuthenticationInitial>(),
      ]);
      expect(bloc.user, isNull);
    },
  );
  test('empty credentials produce an error', () async {
    final states = bloc.stream.take(2).toList();
    bloc.add(AuthenticationWithEmailEvent(email: '', password: 'demo'));
    expect(await states, [
      isA<AuthenticationWaiting>(),
      isA<AuthenticationError>(),
    ]);
    expect(
      (bloc.state as AuthenticationError).errorText,
      contains('Invalid credentials'),
    );
    expect(bloc.user, isNull);
  });
  test('error event exposes its message', () async {
    final state = bloc.stream.first;
    bloc.add(AuthenticationErrorEvent(errorText: 'Demo error'));
    expect((await state as AuthenticationError).errorText, 'Demo error');
  });
  test('user serialization, equality, and copies preserve fields', () {
    final user = User.createMockUser();
    expect(User.fromJson(user.toJson()), user);
    expect(User.fromMap(user.toMap()).hashCode, user.hashCode);
    expect(user.copyWith(firstName: 'New').firstName, 'New');
    expect(User.mockUsers().map((user) => user.uid), ['1', '2', '3']);
  });
}
