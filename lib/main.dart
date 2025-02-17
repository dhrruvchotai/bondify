import 'package:bondify/pages/AddProfile.dart';
import 'package:bondify/pages/Dashboard.dart';
import 'package:bondify/pages/Splash_Screen.dart';
import 'package:bondify/pages/HomePageBuilder.dart';
import 'package:bondify/pages/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'Database/DB.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = DB();
  await db.initDatabase();

  runApp(MaterialApp(
    home:Splash_Screen(),
    debugShowCheckedModeBanner: false,
  ));
}