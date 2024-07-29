import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:translator_app/controllers/api_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ApiController mutable = Provider.of<ApiController>(context);
    ApiController immutable =
        Provider.of<ApiController>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("My Translator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Your Language"),
                const SizedBox(
                  height: 5,
                ),
                DropdownButton(
                  value: mutable.from,
                  items: mutable.languages
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.code,
                          child: Text("${e.code} - ${e.language}"),
                        ),
                      )
                      .toList(),
                  onChanged: immutable.onFromChanged,
                ),
              ],
            ),
            TextField(
              onChanged: immutable.onChanged,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    icon: const Icon(Icons.translate),
                    onPressed: () {
                      immutable.translate();
                    },
                  ),
                ),
                labelText: "Text",
                hintText: "Enter text",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Target Language"),
                const SizedBox(
                  height: 5,
                ),
                DropdownButton(
                  value: mutable.to,
                  items: mutable.languages
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.code,
                          child: Text("${e.code} - ${e.language}"),
                        ),
                      )
                      .toList(),
                  onChanged: immutable.onToChanged,
                ),
              ],
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 200,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(mutable.trans),
                ),
                IconButton(
                  onPressed: () {
                    FlutterTts flutterTts = FlutterTts();
                    flutterTts
                        .speak(mutable.trans)
                        .then((value) => log("Started..."))
                        .onError((error, stackTrace) => log("ERROR: $error"));
                  },
                  icon: const Icon(Icons.volume_up),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
