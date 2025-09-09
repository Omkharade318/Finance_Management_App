import 'package:finance/screens/home.dart';
import 'package:finance/screens/statistics.dart';
import 'package:finance/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bottom()
    );
  }

}