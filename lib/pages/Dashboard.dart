import 'package:bondify/pages/HomePageBuilder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'RegistrationPage.dart';
import 'String_Utils.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout_rounded, color: Colors.white70, size: 28),
            onPressed: () async {
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
                padding: const EdgeInsets.only(top: 20),
                child: GridView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final options = [
                      {'icon': Icons.person_add, 'label': 'Add Profile', 'indx' : 0},
                      {'icon': Icons.people, 'label': 'All Profiles', 'indx' : 1},
                      {'icon': Icons.favorite, 'label': 'Favorites', 'indx' : 2},
                      {'icon': Icons.info, 'label': 'About Us', 'indx' : 3},
                    ];
                    return FadeInUp(
                      child: _buildDashboardButton(
                        context,
                        options[index]['icon'] as IconData,
                        options[index]['label'] as String,
                        options[index]['indx'] as int
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
          viewportFraction:0.99,
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
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePageBuilder(intialPageIndex: indx)));
          setState(() {
          });
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
}
