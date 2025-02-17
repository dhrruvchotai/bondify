import 'package:bondify/pages/AboutUs.dart';
import 'package:bondify/pages/AddProfile.dart';
import 'package:bondify/pages/Dashboard.dart';
import 'package:bondify/pages/DisplayAllProfiles.dart';
import 'package:bondify/pages/DisplayFavProfiles.dart';
import 'package:bondify/pages/String_Utils.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'RegistrationPage.dart';

class HomePageBuilder extends StatefulWidget {
  final int intialPageIndex;
  const HomePageBuilder({super.key,required this.intialPageIndex});

  @override
  State<HomePageBuilder> createState() => _HomePageBuilderState();
}

class _HomePageBuilderState extends State<HomePageBuilder> {

  PageController myPageController = PageController();
  var pagesList = [AddProfile(),UserProfiles(),DisplayFavUserProfiles(),AboutUsPage()];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.intialPageIndex;
    myPageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white70,),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'BONDIFY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        backgroundColor: Color(0XFFa4133c),
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
              rippleColor: Color(0XFFfff0f3)!,
              hoverColor: Color(0XFFffccd5)!,
              gap: 8,
              activeColor: Color(0XFF800f2f),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color(0XFFfff0f3)!,
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
                  myPageController.animateToPage(currentIndex, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
