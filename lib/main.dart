import 'package:bondify/database/DB.dart';
import 'package:bondify/pages/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///For Local DB
  // final db = DB();
  // await db.initDatabase();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    home:Splash_Screen(),
    debugShowCheckedModeBanner: false,
  ));
}