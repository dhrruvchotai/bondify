import 'package:bondify/pages/AboutUs.dart';
import 'package:bondify/pages/DisplayAllProfiles.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'AddProfile.dart';
import 'RegistrationPage.dart';
import 'String_Utils.dart';
import 'User.dart';

class DisplayFavUserProfiles extends StatefulWidget {
  const DisplayFavUserProfiles({super.key});

  @override
  State createState() => _DisplayFavUserProfilesState();
}

class _DisplayFavUserProfilesState extends State<DisplayFavUserProfiles> {
  User users = User(); // Assuming this is your User class
  List<Map<String, dynamic>> usersList = []; // Corrected List type
  int _selectedIndex = 2;
  bool isUserMale = true;

  @override
  void initState() { // Corrected method name
    super.initState();
    // Populate the user list
    setState(() {
      usersList = users.getUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter favorite users first
    List favUsers = usersList.where((user) => user[ISUSERFAV] == true).toList();

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.brown[100]!,
                Colors.brown[50]!,
                Colors.brown[200]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: favUsers.isEmpty
              ? Center(
            child: Text(
              'No favorite profiles available.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
              : ListView.builder(
            itemCount: favUsers.length,
            itemBuilder: (context, index) {
              var user = favUsers[index];
              bool isUserMale = user[GENDER] == "Male";
              return Padding(
                padding: const EdgeInsets.all(13.0),
                child: Card(
                  elevation: 5,
                  borderOnForeground: true,
                  color: Colors.brown[100],
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  user[ISUSERFAV] = !(user[ISUSERFAV] ?? false);
                                });
                              },
                              icon: (user[ISUSERFAV] ?? true)
                                  ? Icon(Icons.favorite, color: Colors.redAccent)
                                  : Icon(Icons.favorite_outline_rounded, color: Colors.redAccent),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 15,),
                              Icon(Icons.person_2_outlined),
                              SizedBox(width: 10,),
                              Text(
                                "Fullname",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10,),
                              Text(":"),
                              SizedBox(width: 10,),
                              Text(
                                user[FULLNAME],
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(height: 3,),
                          Row(
                            children: [
                              SizedBox(width: 15,),
                              Icon(Icons.phone),
                              SizedBox(width: 10,),
                              Text(
                                "Phone",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10,),
                              Text(":"),
                              SizedBox(width: 10,),
                              Text(
                                user[PHONE],
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(height: 3,),
                          Row(
                            children: [
                              SizedBox(width: 16,),
                              Icon(Icons.email_outlined),
                              SizedBox(width: 10,),
                              Text(
                                "Email",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10,),
                              Text(":"),
                              SizedBox(width: 10,),
                              Text(
                                user[EMAIL],
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(height: 3,),
                          Row(
                            children: [
                              SizedBox(width: 15,),
                              Icon(Icons.date_range_outlined),
                              SizedBox(width: 10,),
                              Text(
                                "Date Of Birth",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10,),
                              Text(":"),
                              SizedBox(width: 10,),
                              Text(
                                user[DOB],
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(height: 3,),
                          Row(
                            children: [
                              SizedBox(width: 15,),
                              Icon(isUserMale ? Icons.male : Icons.female),
                              SizedBox(width: 10,),
                              Text(
                                "Gender",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10,),
                              Text(":"),
                              SizedBox(width: 10,),
                              Text(
                                user[GENDER],
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(height: 7,),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
