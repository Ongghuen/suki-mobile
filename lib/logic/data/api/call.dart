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
      // .timeout(Duration(seconds: 3));
    } catch (ex, stacktrace) {
      print("Exception occured: $ex stackTrace: $stacktrace");
    }
  }

  postData(apiUrl, {data = "", token = ""}) async {
    try {
      var fullUrl = _url + apiUrl;
      print("call to $fullUrl. with data: $data, and token $token");
      return await http.post(Uri.parse(fullUrl), body: data, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
    } catch (ex, stacktrace) {
      print("Exception occured: $ex stackTrace: $stacktrace");
    }
  }

  putData(apiUrl, {data = "", token = ""}) async {
    try {
      var fullUrl = _url + apiUrl;
      print("call to $fullUrl. with data: $data, and token $token");
      return await http.put(Uri.parse(fullUrl), body: data, headers: {
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
      print(fullUrl);
      return await http.delete(Uri.parse(fullUrl), body: data, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
    } catch (ex, stacktrace) {
      print("Exception occured: $ex stackTrace: $stacktrace");
    }
  }

  multiPartData(apiUrl, {data = "", token = ""}) async {
    try {
      var fullUrl = _url + apiUrl;
      print(fullUrl);
      var req = await http.MultipartRequest('POST', Uri.parse(fullUrl));
      req.files.add(await http.MultipartFile.fromPath("bukti_bayar", data));
      req.headers.addAll({'Authorization': 'Bearer $token'});


      var res = await req.send();
      //for getting and decoding the response into json format
      var response = await http.Response.fromStream(res);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        print(data);
        print(req.headers);
      } else {
        print("ERROR");
      }
    } catch (ex, stacktrace) {
      print("Exception occured: $ex stackTrace: $stacktrace");
    }
  }
}
