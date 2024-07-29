import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/controllers/api_controller.dart';

import 'my_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ApiController(),
      child: const MyApp(),
    ),
  );
}
