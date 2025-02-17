import 'package:bondify/pages/Dashboard.dart';
import 'package:bondify/pages/HomePageBuilder.dart';
import 'package:bondify/pages/String_Utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddProfile.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKeyForLogin = GlobalKey<FormState>();
  final _formKeyForSignUp = GlobalKey<FormState>();
  TextEditingController _emailForLogin = TextEditingController();
  TextEditingController _passwordForLogin = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _emailForSignUp = TextEditingController();
  TextEditingController _passwordForSignUp = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  bool isObscuredTextActiveForPassword = false;
  bool isObscuredTextActiveForConfirmPassword = false;
  bool isSignInOptionActive = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSignInOptionActive ? Container(
        decoration: BoxDecoration(
          color: Color(0XFF800f2f).withOpacity(0.25),
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0XFFfff0f3),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0XFF590d22).withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKeyForLogin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0XFF800f2f).withOpacity(0.2),
                        child: Icon(Icons.person_outline,size: 55,color: Colors.black,),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome back! Please Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF590d22),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Email Field
                    TextFormField(
                      controller: _emailForLogin,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,color : Color(0XFF800f2f)),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Color(0XFF590d22)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Password Field
                    TextFormField(
                      controller: _passwordForLogin,
                      maxLength: 15,
                      obscureText: !isObscuredTextActiveForPassword, // This hides the password input
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded,color: Color(0XFF800f2f),),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            isObscuredTextActiveForPassword = !isObscuredTextActiveForPassword;
                          });
                        }, icon: isObscuredTextActiveForPassword ? Icon(Icons.visibility_outlined,color:Color((0XFF800f2f)),) : Icon(Icons.visibility_off_outlined,color: Color(0XFF800f2f),)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Color(0XFF590d22)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16), // Space between fields
                    // Login Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () async{
                          if (_formKeyForLogin.currentState!.validate()) {
                            _formKeyForLogin.currentState!.save();

                            //If SuccessFully LoggedIn with the database
                            var sharedPref = await SharedPreferences.getInstance();
                            sharedPref.setBool(LOGINKEY,true);
                            Navigator.pushReplacement(context,MaterialPageRoute(
                                builder:(context) => DashboardScreen()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Logged into your account successfully!!')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0XFFc9184a),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    
                    //Text toggle for login and signup
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New to bondiy? ',style: TextStyle(color: Color(0XFF590d22)),),
                        InkWell(onTap: (){
                          setState(() {
                            isSignInOptionActive = !isSignInOptionActive;
                          },);
                        },
                        child:Text('Sign Up>',style: TextStyle(fontWeight:FontWeight.bold,color: Color(0XFFc9184a),fontSize: 16,decoration: TextDecoration.underline,decorationColor: Colors.red,decorationThickness: 1,),),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ) : Container(
        decoration: BoxDecoration(
          color: Color(0XFF800f2f).withOpacity(0.25),
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0XFFfff0f3),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0XFF590d22).withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKeyForSignUp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0XFF800f2f).withOpacity(0.2),
                        child: Icon(Icons.person_outline,size: 55,color: Colors.black,),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF590d22),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Username Field
                    TextFormField(
                      controller: _name,
                      maxLength: 40,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_2_outlined,color : Color(0XFF800f2f)),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Color(0XFF590d22)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Email Field
                    TextFormField(
                      controller: _emailForSignUp,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,color : Color(0XFF800f2f)),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Color(0XFF590d22)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Password Field
                    TextFormField(
                      controller: _passwordForSignUp,
                      maxLength: 15,
                      obscureText: !isObscuredTextActiveForPassword, // This hides the password input
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded,color : Color(0XFF800f2f)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscuredTextActiveForPassword = !isObscuredTextActiveForPassword;
                            });
                          },
                          icon: isObscuredTextActiveForPassword
                              ? Icon(Icons.visibility_outlined,color : Color(0XFF800f2f))
                              : Icon(Icons.visibility_off_outlined,color : Color(0XFF800f2f)),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Color(0XFF590d22)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    // Confirm Password Field
                    TextFormField(
                      controller: _confirmPassword,
                      maxLength: 15,
                      obscureText: !isObscuredTextActiveForConfirmPassword, // This hides the confirm password input
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded,color : Color(0XFF800f2f)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscuredTextActiveForConfirmPassword =
                              !isObscuredTextActiveForConfirmPassword;
                            });
                          },
                          icon: isObscuredTextActiveForConfirmPassword
                              ? Icon(Icons.visibility_outlined,color : Color(0XFF800f2f))
                              : Icon(Icons.visibility_off_outlined,color : Color(0XFF800f2f)),
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Color(0XFF590d22)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0XFF590d22), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordForSignUp.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    // Register Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKeyForSignUp.currentState!.validate()) {
                            _formKeyForSignUp.currentState!.save();
                            // Process the registration with _name, _phoneNumber, _email, _age
                            Navigator.push(context,MaterialPageRoute(
                                builder:(context) => HomePageBuilder(intialPageIndex: 1,)));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Profile created successfully $_name...')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0XFFc9184a),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),


                    //Text toggle for login and signup
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? ',style: TextStyle(color: Color(0XFF590d22)),),
                        InkWell(onTap: (){
                          setState(() {
                            isSignInOptionActive = !isSignInOptionActive;
                          },);
                        },
                          child:Text('Login>',style: TextStyle(fontWeight:FontWeight.bold,color: Color(0XFFc9184a),fontSize: 16,decoration: TextDecoration.underline,decorationColor: Colors.red,decorationThickness: 1,),),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}