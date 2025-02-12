import 'package:bondify/pages/HomePage.dart';
import 'package:bondify/pages/HomePageBuilder.dart';
import 'package:flutter/material.dart';
import 'Database/DB.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = DB();
  await db.initDatabase(); // Wait for database initialization

  runApp(MaterialApp(
    home: HomePageBuilder(),
    debugShowCheckedModeBanner: false,
  ));
}