import 'package:http/http.dart' as http;

class ApiServices {
  static const String _baseUrl = 'http://localhost:8081';

  static const String whoAmI = '$_baseUrl/whoami';

  static Future<http.Response> postWhoAmI(String token) {
    return http.post(
      Uri.parse(whoAmI),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}