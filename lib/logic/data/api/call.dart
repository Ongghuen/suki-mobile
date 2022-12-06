import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/presentation/utils/default.dart';

class CallApi {
  final String _url = apiUrl;

  getData(apiUrl, {token = ""}) async {
    try {
      var fullUrl = _url + apiUrl;
      print(fullUrl);
      return await http.get(Uri.parse(fullUrl), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
    } catch (ex, stacktrace) {
      print("Exception occured: $ex stackTrace: $stacktrace");
    }
  }

  postData(apiUrl, data, {token = ""}) async {
    try {
      var fullUrl = _url + apiUrl;
      return await http.post(Uri.parse(fullUrl), body: data, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
    } catch (ex, stacktrace) {
      print("Exception occured: $ex stackTrace: $stacktrace");
    }
  }

  deleteData(apiUrl, {data = "", token = ""}) async {
    try {
      var fullUrl = _url + apiUrl;
      return await http.delete(Uri.parse(fullUrl), body: data, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
    } catch (ex, stacktrace) {
      print("Exception occured: $ex stackTrace: $stacktrace");
    }
  }
}
