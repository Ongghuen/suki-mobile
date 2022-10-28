import 'package:hive_flutter/adapters.dart';

class UserHiveDatabase {
  final userBox = Hive.box("user");
  String user = "";

  loadDB() {
    user = userBox.get("username");
  }

  updateDB() {
    userBox.put("username", user);
  }

  removeUser() {
    userBox.delete("username");
  }
}
