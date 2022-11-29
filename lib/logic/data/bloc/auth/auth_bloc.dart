import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<UserAuthLogin>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(AuthInitial());
        emit(AuthLoading());

        String apiUrl = "/api/login";
        var res = await CallApi().postData(apiUrl, event.data);
        var body = json.decode(res.body);
        if (res.statusCode == 201) {
          final auth = AuthModel.fromJson(body);
          print(auth.token);
          emit(AuthLoaded(auth));
        } else {
          emit(AuthError(body['message']));
        }
      } catch (ex, trace) {
        print("$ex $trace");
      }
    });
    on<UserAuthLogout>((event, emit) async {
      String apiUrl = "/api/logout";

      var res = await CallApi().postData(apiUrl, [], token: event.token);
      var body = json.decode(res.body);

      if (res.statusCode == 200) {
        emit(AuthLogout());
      } else {
        print("Logout Failed");
      }
    });
  }
}
