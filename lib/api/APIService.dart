import 'dart:convert';

import 'package:http/http.dart' as http;
class APIService{
  
  String API = 'https://6673d5f375872d0e0a93e612.mockapi.io/me/Dhruv/Matrimony';

  Future<List<Map<String,dynamic>>> fetchUsers() async{
    final res = await http.get(Uri.parse(API));
    if(res.statusCode == 200){
      return List<Map<String,dynamic>>.from(jsonDecode(res.body));
    }
    else{
      return [];
    }
  }

  Future<void> addUser(Map<String,dynamic> User) async{
    try{
      final res = await http.post(Uri.parse(API),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode(User),
      );
    }
    catch(e){
      print('Error in adding the user : ${e.toString()}');
    }
  }

  Future<void> deleteUser(String id) async{
    try{
      final res = await http.delete(Uri.parse(API+"/$id"));
      fetchUsers();
    }
    catch(e){
      print("Error in deleting the data ${e.toString()}");
    }
  }

  Future<void> editUser(String id,Map<String,dynamic> User) async{
    try{
      final res = await http.put(
        Uri.parse(API+"/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(User),
      );
      if (res.statusCode == 200) {
        print('User updated Successfully!!');
        fetchUsers();
      }
      else {
        print('Failed to update: ${res.reasonPhrase}');
      }
    }
    catch(e){
      print("Error in updating user : ${e.toString()}");
    }
  }

}
