import 'package:flutter/material.dart';
import 'package:wallpaper/Layouts/login.dart';
import './startup_name.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: const ColorScheme.light()
                .copyWith(primary: Colors.deepOrange[900])),
        home: LoginPage());
  }
}
