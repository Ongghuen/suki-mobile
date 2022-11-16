import 'package:http/http.dart' as http;

class CallApi {
  final String _url = "https://sukifurniture.herokuapp.com";
  // final String _url = "http://sukifurniture.herokuapp.com";

  postData(data, apiUrl) async {
    try {
      var fullUrl = _url + apiUrl;
      return await http.post(Uri.parse(fullUrl), body: data);
    } catch (ex) {
      print("API Error: $ex");
    }
  }

  getData(apiUrl) async {
    try {
      var fullUrl = _url + apiUrl;
      print(fullUrl);
      return await http.get(Uri.parse(fullUrl));
    } catch (ex) {
      print("API Error: $ex");
    }
  }

}
