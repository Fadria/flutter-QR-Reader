import 'package:flutter/material.dart';
import 'package:qrreader/pages/home_page.dart';
import 'package:qrreader/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: 
      {
        'home': (_) => HomePage(),
        'mapa': (_) => MapaPage(),
      },
      theme: ThemeData
      (
        primaryColor: Colors.deepPurple,
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.deepPurple),
      ),
    );
  }
}