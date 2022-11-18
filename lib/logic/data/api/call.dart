import 'package:http/http.dart' as http;

class CallApi {
  final String _url = "http://192.168.0.116:8000";
  // final String _url = "http://sukifurniture.herokuapp.com";

  postData(data, apiUrl) async {
    try {
      var fullUrl = _url + apiUrl;
      return await http.post(Uri.parse(fullUrl), body: data);
    } catch (ex, stacktrace) {
      print("Exception occured: $ex stackTrace: $stacktrace");
    }
  }

  getData(apiUrl) async {
    try {
      var fullUrl = _url + apiUrl;
      print(fullUrl);
      return await http.get(Uri.parse(fullUrl));
    } catch (ex, stacktrace) {
      print("Exception occured: $ex stackTrace: $stacktrace");
    }
  }

}
