import '../../model/user.dart';

abstract class AuthenticationRepository {
  Future<User> signIn({required String email, required String password});
  Future<void> signOut();
}

class MockAuthenticationRepository implements AuthenticationRepository {
  MockAuthenticationRepository({this.delay = const Duration(seconds: 1)});
  final Duration delay;
  @override
  Future<User> signIn({required String email, required String password}) async {
    await Future<void>.delayed(delay);
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Invalid credentials');
    }
    return User.createMockUser();
  }

  @override
  Future<void> signOut() => Future<void>.delayed(delay);
}
