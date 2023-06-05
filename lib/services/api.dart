import 'dart:convert';

import 'package:http/http.dart' as http;

const String endpoint =
    'https://raw.githubusercontent.com/FEND16/movie-json-data/master/json/movies-coming-soon.json';

final http.Client _httpClient = http.Client();

class Client {
  static Future get() async {
    try {
      final Uri url = Uri.parse(endpoint);
      http.Response response = await _httpClient.get(url);
      String data = utf8.decode(response.bodyBytes.toList());

      if (isStatusCodeSuccessful(response.statusCode)) {
        return jsonDecode(data);
      } else {
        if (isStatusCodeFailure(response.statusCode)) {
          return jsonDecode(data);
        } else {
          return invalidRequest(data.toString());
        }
      }
    } catch (exception_, stackTrace) {
      return invalidRequest('$exception_\n\n\n$stackTrace');
    }
  }

  static bool isStatusCodeSuccessful(int status) {
    return status >= 200 && status <= 300;
  }

  static bool isStatusCodeFailure(int status) {
    return status == 400;
  }

  static Map invalidRequest(String error) {
    return {
      "status": 0,
      "message": error,
    };
  }
}
