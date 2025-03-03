import '../pages/String_Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      //get user details from google
      final googleUser = await GoogleSignIn().signIn();
      //get authentication of the user
      final googleAuth = await googleUser?.authentication;
      //get the user credentials
      final cred = GoogleAuthProvider.credential(idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      UserCredential userCredential = await _auth.signInWithCredential(cred);
      String? userEmail = userCredential.user?.email;
      var sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString(LOGGEDINUSEREMAIL, userEmail!);
      return userCredential;
    }
    catch (e) {
      print("Error Occured while Logging In with Google : ${e.toString()}");
    }
    return null;
  }

  Future<void> logOutWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      FirebaseAuth.instance.signOut();
    }
    catch (e) {
      print(e.toString());
    }
  }

}
