import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _user = FirebaseAuth.instance.currentUser!;

  Future _signOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("signed in as: ${_user.email!}"),
            MaterialButton(
              onPressed: _signOut,
              color: Colors.yellow[500],
              child: Text("Sign Out"),
            )
          ],
        ),
      )),
    );
  }
}
