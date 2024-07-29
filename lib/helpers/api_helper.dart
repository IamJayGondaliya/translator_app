import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:translator_app/models/language.dart';

class ApiHelper {
  ApiHelper._pc();
  static final ApiHelper apiHelper = ApiHelper._pc();

  String baseUrl =
      "https://google-translate113.p.rapidapi.com/api/v1/translator/";
  String endPointDetect = "detect-language";
  String endPointLanguages = "support-languages";
  String endPointText = "text";

  Map<String, String> headers = {
    'x-rapidapi-key': '2e59e3a545mshd803fd1ed71a23cp1eb9c0jsne0d6a0bc95b6',
    'x-rapidapi-host': 'google-translate113.p.rapidapi.com'
  };

  Future<List<Language>> getLanguages() async {
    List<Language> languages = [];

    http.Response response = await http
        .get(Uri.parse(baseUrl + endPointLanguages), headers: headers);

    if (response.statusCode == 200) {
      List allData = jsonDecode(response.body);

      languages = allData.map((e) => Language.fromMap(e)).toList();
    }

    return languages;
  }

  Future<String> translateText({
    String from = 'auto',
    String to = 'hi',
    required String text,
  }) async {
    String trans = "No Data";

    http.Response response = await http.post(
      Uri.parse(baseUrl + endPointText),
      headers: headers,
      body: {
        'from': from,
        'to': to,
        'text': text,
      },
    );

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      trans = data['trans'] ?? "No data";
    }

    return trans;
  }
}
