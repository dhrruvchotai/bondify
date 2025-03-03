import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePageBuilder.dart';
import 'RegistrationPage.dart';
import 'String_Utils.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0XFFfff0f3).withOpacity(0.9),
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
            setState(() {

            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white70, size: 28),
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ],
      ),
      drawer: _buildSidebar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeInDown(
                duration: Duration(milliseconds: 800),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: _buildCarousel(),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: GridView.builder(
                  itemCount: 6, // Increased item count
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final options = [
                      {'icon': Icons.person_add, 'label': 'Add Profile', 'indx': 0},
                      {'icon': Icons.people, 'label': 'All Profiles', 'indx': 1},
                      {'icon': Icons.favorite, 'label': 'Favorites', 'indx': 2},
                      {'icon': Icons.chat, 'label': 'Messages', 'indx': 3},
                      {'icon': Icons.event, 'label': 'Events', 'indx': 4},
                      {'icon': Icons.info, 'label': 'About Us', 'indx': 5},
                    ];
                    return FadeInUp(
                      duration: Duration(milliseconds: 200 + (index * 200)),
                      child: _buildDashboardButton(
                        context,
                        options[index]['icon'] as IconData,
                        options[index]['label'] as String,
                        options[index]['indx'] as int,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 38),
              _buildFAQsSection(),
            ],
          ),
        ),
      ),
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
              Navigator.pop(context); // Close the drawer
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
              var sharedPrf = await SharedPreferences.getInstance();
              sharedPrf.setBool(LOGINKEY, false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RegistrationPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
          viewportFraction: 0.99,
        ),
        items: [
          _buildCarouselItem("lib/assets/images/Slider_Img_1.jpg"),
          _buildCarouselItem("lib/assets/images/Slider_Img_2.jpg"),
          _buildCarouselItem("lib/assets/images/Slider_Img_3.jpg"),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDashboardButton(
      BuildContext context, IconData icon, String label, int indx) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePageBuilder(intialPageIndex: indx)));
          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.7),
          shadowColor: Color(0XFFfff0f3),
          padding: EdgeInsets.symmetric(vertical: 16),
          textStyle: TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Color(0XFFa4133c)),
            SizedBox(height: 8),
            Text(label, style: TextStyle(color: Color(0XFF590d22))),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FAQs',
          style: TextStyle(
            color: Color(0XFFa4133c),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ..._buildFAQItems(),
      ],
    );
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
        collapsedIconColor: Color(0XFFa4133c),

        iconColor: Colors.black,
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
}