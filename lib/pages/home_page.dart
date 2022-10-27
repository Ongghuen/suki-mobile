import 'package:flutter/material.dart';
import 'package:mobile/pages/detail_page.dart';
import 'package:mobile/process/prefs.dart';

void main(List<String> args) {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String username = "User";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  void getUsername() async {
    var getUname = await getPrefs("username");
    setState(() {
      username = getUname;
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
            Text("signed in as: $username"),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetailPage()));
              },
              // onPressed: _signOut,
              color: Colors.yellow[500],
              child: Text("Coba coba"),
            ),
            MaterialButton(
              onPressed: () async {
                Navigator.pop(context);
                await removePrevs("username");
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
