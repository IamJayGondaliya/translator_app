import 'package:flutter/material.dart';
import 'package:translator_app/helpers/api_helper.dart';

import '../models/language.dart';

class ApiController extends ChangeNotifier {
  List<Language> languages = [];
  String text = "";
  String trans = "No Data";
  String to = 'hi';
  String from = 'auto';

  ApiController() {
    initData();
  }

  Future<void> initData() async {
    languages = await ApiHelper.apiHelper.getLanguages();
    notifyListeners();
  }

  void onChanged(String val) {
    text = val;
  }

  void onToChanged(String? val) {
    to = val ?? 'hi';
    notifyListeners();
  }

  void onFromChanged(String? val) {
    from = val ?? 'auto';
  }

  Future<void> translate() async {
    trans = await ApiHelper.apiHelper.translateText(
      from: from,
      to: to,
      text: text,
    );
    notifyListeners();
  }
}
