import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_mbdimsum/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MB Dimsum',
      theme: ThemeData(
        fontFamily: "Ubuntu",
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.purple,
          ),
        ),
      ),
      home: HomePage(title: 'MB Dimsum'),
    );
  }
}
