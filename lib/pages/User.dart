import 'String_Utils.dart';

class User {
  static final User _instance = User._internal();
  factory User() => _instance;
  User._internal();
  List<Map<String, dynamic>> userList = [];
  List<Map<String, dynamic>> favUserList = [];

  void addUserInList({
    //List of params
    required fullname, required phone, required email, required dob, required gender, required religion, required city, required hobbies,required isUserFav
  })
  {
    Map<String, dynamic> map = {};
    map[FULLNAME] = fullname;
    map[PHONE] = phone;
    map[EMAIL] = email;
    map[DOB] = dob;
    map[GENDER] = gender;
    map[RELIGION] = religion;
    map[CITY] = city;
    map[HOBBIES] = hobbies;
    map[ISUSERFAV] = isUserFav;
    print('User named $fullname added!!');
    userList.add(map);
  }

  List<Map<String, dynamic>> getUserList() {
    return userList;
  }

  void updateUser(
      //List of params
      {required id,required fullname, required phone, required email, required dob, required gender, required religion, required city, required hobbies}
  ){
    Map<String, dynamic> map = {};
    map[FULLNAME] = fullname;
    map[PHONE] = phone;
    map[EMAIL] = email;
    map[DOB] = dob;
    map[GENDER] = gender;
    map[RELIGION] = religion;
    map[CITY] = city;
    map[HOBBIES] = hobbies;
    userList[id] = map;
  }

  void deleteUser(id) {
    userList.removeAt(id);
  }

  void searchDeatail({required searchData}) {
    for (var element in userList) {
      if (element[FULLNAME]
          .toString()
          .toLowerCase()
          .contains(searchData.toString().toLowerCase()) ||
          element[EMAIL]
              .toString()
              .toLowerCase()
              .contains(searchData.toString().toLowerCase()) ||
          element[CITY]
              .toString()
              .toLowerCase()
              .contains(searchData.toString().toLowerCase()) ||
          element[RELIGION]
              .toString()
              .toLowerCase()
              .contains(searchData.toString().toLowerCase())) {
          printResultText(
              '${element[FULLNAME]} . ${element[EMAIL]} . ${element[CITY]} . ${element[RELIGION]}');
        }
    }
  }
}
