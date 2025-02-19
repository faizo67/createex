import 'package:faizahmad_createex/Ui/shared/theme/dark_theme.dart';
import 'package:faizahmad_createex/Ui/shared/theme/light_theme.dart';
import 'package:faizahmad_createex/Ui/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: drakTheme,
      home: LoginView(),
    );
  }
}
