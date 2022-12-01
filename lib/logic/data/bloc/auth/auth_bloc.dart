import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/logic/data/api/call.dart';
import 'package:mobile/logic/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<UserAuthLogin>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(AuthLoading());

        String apiUrl = "/api/login";
        var res = await CallApi().postData(apiUrl, event.data);
        var body = json.decode(res.body);
        if (res.statusCode == 201) {
          final auth = AuthModel.fromJson(body);
          emit(AuthLoaded(auth));
        } else {
          emit(AuthError(body['message']));
        }
      } catch (ex, trace) {
        print("$ex $trace");
        emit(AuthError("Something's wrong"));
      }
    });

    on<UserAuthRegister>((event, emit) async {
      emit(AuthLoading());

      try {
        emit(AuthLoading());

        String apiUrl = "/api/register";
        var res = await CallApi().postData(apiUrl, event.data);
        var body = json.decode(res.body);
        if (res.statusCode == 201) {
          final auth = AuthModel.fromJson(body);
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
        emit(AuthError("Logout Failed"));
      }
    });
  }
}
