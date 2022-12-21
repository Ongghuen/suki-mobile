part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  late AuthModel userModel;
}

class AuthLoading extends AuthState {}
class AuthRegistered extends AuthState {}

class AuthLoaded extends AuthState {
  final AuthModel userModel;
  AuthLoaded(this.userModel);

  Map<String, dynamic> toJson() {
    return {'user': userModel};
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userModel];
}

class AuthLogout extends AuthState {}

class AuthError extends AuthState {
  final String? msg;
  AuthError(this.msg);
}

class AuthUpdateError extends AuthState {
  final String? msg;
  AuthUpdateError(this.msg);
}
