import 'package:aswdc_flutter_pub/aswdc_flutter_pub.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: DeveloperScreen(
            backgroundColor: Colors.brown[50],
            colorValue:Colors.redAccent[200],
            developerName: ' Dhruv Chotai (23010101051)',
            mentorName: ' Prof. Mehul Bhundiya',
            exploredByName: ' ASWDC',
            isAdmissionApp: true,
            isDBUpdate: true,
            shareMessage: '',
            appTitle: 'bondify',
            appLogo: 'lib/assets/images/appLogo.png',
            appBarColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}