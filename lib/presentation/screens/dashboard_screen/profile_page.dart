import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController names = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Logout"),
                    IconButton(
                      icon: const Icon(Icons.logout_outlined),
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(UserAuthLogout(state.userModel.token));
                      },
                    ),
                  ],
                );
              }
              return IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_left));
            }),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder myInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 3,
        ));
  }

  OutlineInputBorder myFocusBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color(0xffcbf49),
          width: 3,
        ));
  }
}
