part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable{
  @override
    // TODO: implement props
    List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthLoaded extends AuthState {
  final AuthModel userModel;
  AuthLoaded(this.userModel);
}
class AuthLogout extends AuthState {}
class AuthError extends AuthState {
  final String? msg;
  AuthError(this.msg);
}
