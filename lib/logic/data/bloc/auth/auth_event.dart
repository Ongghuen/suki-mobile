part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserAuthLogin extends AuthEvent {
  var data;
  UserAuthLogin(this.data);
}
class UserAuthLogout extends AuthEvent {
  var token;
  UserAuthLogout(this.token);
}
