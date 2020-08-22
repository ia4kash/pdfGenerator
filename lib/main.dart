import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenit/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(
            MaterialApp(
              title: "GREEN IT",
              debugShowCheckedModeBanner: false,
              home: HomePage(),
            ),
          ));
}
