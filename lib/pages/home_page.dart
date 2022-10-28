import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile/data/user.dart';
import 'package:mobile/pages/detail_page.dart';

void main(List<String> args) {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userBox = Hive.box("user");
  UserHiveDatabase udb = UserHiveDatabase();

  late String username = "User";

  @override
  void initState() {
    // TODO: implement initState
    udb.loadDB();
    getUsername();
    super.initState();
  }

  void getUsername() {
    setState(() {
      username = udb.user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //

            Text("signed in as: $username"),
            // MaterialButton(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const DetailPage()));
            //   },
            //   // onPressed: _signOut,
            //   color: Colors.yellow[500],
            //   child: Text("Coba coba"),
            // ),

            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                udb.removeUser();
              },
              color: Colors.yellow[500],
              child: Text("bye"),
            )
          ],
        ),
      )),
    );
  }
}
