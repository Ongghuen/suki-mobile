import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/logic/data/bloc/auth/auth_bloc.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthLoaded) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Logout",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(UserAuthLogout(state.userModel.token));
                  },
                ),
              ],
            );
          }
          return IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_left));
        }),
      ),
    );
  }
}
