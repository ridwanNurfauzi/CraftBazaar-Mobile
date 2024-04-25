import 'package:shared_preferences/shared_preferences.dart';

class Api {
  // static final String baseUrl = 'http://10.0.2.2:3000';
  // static final String baseUrl = 'http://192.168.0.75:3000';
  static final String baseUrl = 'http://127.0.0.1:3000';

  static Future<Map<String, String>> getHeaders() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');

    if (token != null) {
      return {'Authorization': 'Bearer $token'};
    } else {
      return {};
    }
  }
}
