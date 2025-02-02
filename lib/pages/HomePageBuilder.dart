import 'package:bondify/pages/AboutUs.dart';
import 'package:bondify/pages/AddProfile.dart';
import 'package:bondify/pages/DisplayAllProfiles.dart';
import 'package:bondify/pages/DisplayFavProfiles.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'RegistrationPage.dart';

class HomePageBuilder extends StatefulWidget {
  const HomePageBuilder({super.key});

  @override
  State<HomePageBuilder> createState() => _HomePageBuilderState();
}

class _HomePageBuilderState extends State<HomePageBuilder> {

  PageController myPageController = PageController();
  var pagesList = [AddProfile(),UserProfiles(),DisplayFavUserProfiles(),AboutUsPage()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RegistrationPage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'bondify',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: PageView(
        controller: myPageController,
        children: pagesList,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },

      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.person_add_sharp,
                  text: 'Add Profile',
                ),
                GButton(
                  icon: LineIcons.list,
                  text: 'All Profiles',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Favorites',

                ),
                GButton(
                  icon: Icons.supervised_user_circle_rounded,
                  text: 'About Us',
                ),
              ],
              selectedIndex: currentIndex,
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                  myPageController.animateToPage(currentIndex, duration: Duration(milliseconds: 500), curve: Easing.emphasizedAccelerate);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
