import 'dart:convert';

import 'package:http/http.dart' as http;

class CallApi {
  final String _url = "http://192.168.8.112";

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl), body: data);
  }
}
