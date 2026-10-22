import 'package:bloc/bloc.dart';

import '../../model/user.dart';
import '../../repositories/authentication/authentication_repository.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.authenticationRepository)
    : super(AuthenticationInitial()) {
    on<AuthenticationWithEmailEvent>((event, emit) async {
      emit(AuthenticationWaiting());
      try {
        user = await authenticationRepository.signIn(
          email: event.email,
          password: event.password,
        );
        emit(AuthenticationAuthenticated());
      } catch (error) {
        user = null;
        emit(AuthenticationError(errorText: error.toString()));
      }
    });
    on<AuthenticationSignOutEvent>((event, emit) async {
      emit(AuthenticationWaiting());
      user = null;
      try {
        await authenticationRepository.signOut();
        emit(AuthenticationInitial());
      } catch (error) {
        emit(AuthenticationError(errorText: error.toString()));
      }
    });
    on<AuthenticationErrorEvent>(
      (event, emit) => emit(AuthenticationError(errorText: event.errorText)),
    );
  }
  final AuthenticationRepository authenticationRepository;
  User? user;
}
