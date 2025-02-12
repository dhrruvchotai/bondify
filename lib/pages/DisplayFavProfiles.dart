import 'package:bondify/Database/DB.dart';
import 'package:flutter/material.dart';
import 'String_Utils.dart';

class DisplayFavUserProfiles extends StatefulWidget {
  const DisplayFavUserProfiles({super.key});

  @override
  State createState() => _DisplayFavUserProfilesState();
}

class _DisplayFavUserProfilesState extends State<DisplayFavUserProfiles> {
  DB myDatabase = DB();
  List<Map<String,dynamic>> favUsers = [];
  bool isUserMale = true;

  @override
  void initState() { // Corrected method name
    super.initState();
    loadFavUsers();
  }

  Future<void> loadFavUsers() async {
    await myDatabase.fetchUsersFromUsersTable();
    fetchFavUsers();
  }

  Future<void> fetchFavUsers() async{
    setState(() {
      favUsers = myDatabase.usersList.where((user) => user[ISUSERFAV] == 1).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    // Filter favorite users first
    List favUsers = myDatabase.usersList.where((user) => user[ISUSERFAV] == 1).toList();

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
                              onPressed: () async{
                                int userId = user['id'];
                                int newFavStatus = (user[ISUSERFAV] == 1) ? 0 : 1;
                                await myDatabase.makeUserFav(userId, newFavStatus);
                                await fetchFavUsers();
                              },
                              icon: (user[ISUSERFAV] == 1)
                                  ? Icon(Icons.favorite, color: Colors.redAccent)
                                  : Icon(Icons.favorite_outline_rounded, color: Colors.redAccent),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
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
                              Expanded(
                                child: Text(
                                  user[FULLNAME],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 15),
                                ),
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
