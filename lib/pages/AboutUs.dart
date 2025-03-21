import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AboutUsPage(),
  ));
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0XFFffccd5),
                child: Image.asset('lib/assets/images/appLogo.png',color: Color(0XFFc9184a),),
              ),
              SizedBox(height: 10),
              Text("BONDIFY", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0XFF800f2f))),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Meet our Team', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0XFF800f2f))),
              ),
              _buildInfoCard([
                _buildInfoRow("Developed by", "Dhruv Chotai (23010101051)"),
                _buildInfoRow("Mentored by", "Prof. Mehul Bhundiya (Computer Engineering Department)"),
                _buildInfoRow("Explored by", "ASWDC, School Of Computer Science"),
                _buildInfoRow("Eulogized by", "Darshan University, Rajkot, Gujarat - INDIA"),
              ]),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('About ASWDC', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0XFF800f2f))),
              ),
              _buildInfoCard([
                Text(
                  "ASWDC is an Application, Software and Website Development Center @ Darshan University run by students and staff of the School of Computer Science. \n\nThe sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands, enabling students to learn cutting-edge technologies, develop real-world applications, and gain professional experience under the guidance of industry experts & faculty members.",
                  textAlign: TextAlign.justify,
                )
              ]),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Contact Us', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0XFF800f2f))),
              ),
              _buildInfoCard([
                _buildContactRow(Icons.email, "aswdc@darshan.ac.in"),
                _buildContactRow(Icons.phone, "+91 9998177346"),
                _buildContactRow(Icons.web, "www.darshan.ac.in"),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Color(0XFF800f2f))),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      color: Color(0XFFfff0f3).withOpacity(0.8),
      borderOnForeground:true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Color(0XFF590d22))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Expanded(child: Text(value, softWrap: true)),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0XFF800f2f)),
          SizedBox(width: 10),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }



  Widget _buildIconButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Color(0XFF800f2f), size: 28),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}