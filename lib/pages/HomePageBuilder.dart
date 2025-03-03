import 'dart:async';
import 'package:bondify/auth/AuthService.dart';
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController myPageController = PageController();
  var pagesList = [AddProfile(),UserProfiles(),DisplayFavUserProfiles(),AboutUsPage()];
  int currentIndex = 0;
  String? userInitialToDisplayInProfile;
  AuthService _userAuth = AuthService();

  void _getUserInitial() async{
    var sharedpref = await SharedPreferences.getInstance();
    userInitialToDisplayInProfile = await sharedpref.getString(LOGGEDINUSEREMAIL);
  }


  @override
  void initState() {
    super.initState();
    currentIndex = widget.intialPageIndex;
    myPageController = PageController(initialPage: currentIndex);
    _getUserInitial();
  }


  List<Widget> _buildFAQItems() {
    final faqs = [
      {
        'question': 'How do I add a new user profile?',
        'answer': 'Go to the "Add Profile" section and fill in the required details.',
      },
      {
        'question': 'How can I search for profiles?',
        'answer': 'Use the "All Profiles" section to browse and search for profiles.',
      },
      {
        'question': 'Can I save profiles?',
        'answer': 'Yes, you can save profiles to your favorites for easy access.',
      },
      {
        'question': 'How do I contact support?',
        'answer': 'Use the "Feedback" section to reach out to our support team.',
      },
    ];

    return faqs.map((faq) {
      return ExpansionTile(
        title: Text(
          faq['question']!,
          style: TextStyle(
            color: Color(0XFF590d22),
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              faq['answer']!,
              style: TextStyle(color: Color(0XFF590d22)),
            ),
          ),
        ],
      );
    }).toList();
  }

  void _showFAQsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to take up more space if needed
      backgroundColor: Colors.transparent, // Makes the background transparent
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.53,
          maxChildSize: 0.6,
          minChildSize: 0.3,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    'FAQs',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFFa4133c),
                    ),
                  ),
                  SizedBox(height: 16), // Spacing between title and content
                  // FAQs List
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController, // Connect the scroll controller
                      child: Column(
                        children: _buildFAQItems(),
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Spacing between content and button
                  // Close Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFFa4133c), // Button background color
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded button corners
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.white, // Button text color
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSidebar() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0XFFa4133c),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'BONDIFY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your Matrimony Partner',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Color(0XFFa4133c)),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Timer(Duration(seconds: 1),() {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen(),));
              },);
            },
          ),
          ListTile(
            leading: Icon(Icons.help, color: Color(0XFFa4133c)),
            title: Text('FAQs'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              _showFAQsSheet(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback, color: Color(0XFFa4133c)),
            title: Text('Feedback'),
            onTap: () {
              // Navigate to Feedback page
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Color(0XFFa4133c)),
            title: Text('Settings'),
            onTap: () {
              // Navigate to Settings page
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Color(0XFFa4133c)),
            title: Text('Logout'),
            onTap: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(child: CircularProgressIndicator(color: Color(0XFF590d22),)),
              );
              try{
                _userAuth.logOutWithGoogle();
                var sharedPrf = await SharedPreferences.getInstance();
                sharedPrf.setBool(LOGINKEY, false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Logged Out Successfully!!")),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              }
              catch(e){
                print("An error occurred while logging out ${e.toString()}");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("An error occurred while logging out!!")),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0XFFa4133c),
        elevation: 0,
        title: Text(
          'BONDIFY',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white70, size: 28),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color(0XFFfff0f3),
              child: Center(
                child: userInitialToDisplayInProfile != null && userInitialToDisplayInProfile!.isNotEmpty
                    ? Text(
                  userInitialToDisplayInProfile![0].toUpperCase(),
                  style: TextStyle(color: Color(0XFF800f2f), fontSize: 22),
                )
                    : CircularProgressIndicator(color: Color(0XFF590d22),strokeWidth: 2,strokeAlign:BorderSide.strokeAlignInside,), // Show loader if initials are not available
              ),
            ),
          )
        ],
      ),
      drawer: _buildSidebar(),
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
