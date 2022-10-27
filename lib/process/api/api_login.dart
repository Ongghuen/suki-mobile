import 'package:http/http.dart' as http;
import 'dart:convert';

Future apiLogin(username, password) async {
  var url = Uri.http("192.168.8.112", "/web/api/testlogin.php");
  var response =
      await http.post(url, body: {"username": username, "password": password});
  return json.decode(response.body);
}
