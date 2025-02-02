import 'package:bondify/pages/AboutUs.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'AddProfile.dart';
import 'DisplayFavProfiles.dart';
import 'RegistrationPage.dart';
import 'String_Utils.dart';
import 'User.dart';

class UserProfiles extends StatefulWidget {
  const UserProfiles({super.key});

  @override
  State createState() => _UserProfilesState();
}

class _UserProfilesState extends State<UserProfiles> {
  User users = User(); // Assuming this is your User class
  List<Map<String, dynamic>> usersList = []; // Corrected List type

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
                )
            ),
            child: usersList.isEmpty
                ? Center(
                  child: Text(
                    'No profiles available.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
                : ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                var user = usersList[index];
                return Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Card(
                    elevation: 5,
                    borderOnForeground: true,
                    color: Colors.brown[100],
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top:10),
                          child: Row(
                            children: [
                              Icon(Icons.person_2_outlined)
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 60,),
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
                            SizedBox(width: 60,),
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
                        Row(
                          mainAxisAlignment:MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 15,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 7),
                                  child: IconButton(onPressed: (){
                                    setState(() {
                                      users.deleteUser(index);
                                    });
                                  }, icon:Icon(Icons.delete)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        user[ISUSERFAV] = !(user[ISUSERFAV] ?? false);;
                                      });
                                    }, icon:(user[ISUSERFAV] ?? false) ? Icon(Icons.favorite, color: Colors.redAccent)
                                      : Icon(Icons.favorite_outline_rounded, color: Colors.redAccent),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6,left: 10),
                                  child: Text("View Full Details"),
                                ),
                              ],
                            ),
                            IconButton(onPressed: (){
                            }, icon: Icon(Icons.arrow_forward_ios))
                          ],
                        )
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
