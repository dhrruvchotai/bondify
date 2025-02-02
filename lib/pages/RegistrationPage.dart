import 'package:bondify/pages/HomePageBuilder.dart';
import 'package:flutter/material.dart';
import 'AddProfile.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKeyForLogin = GlobalKey<FormState>();
  final _formKeyForSignUp = GlobalKey<FormState>();
  String? _name,_emailForLogin,_emailForSignUp;
  String? _passwordForLogin,_passwordForSignUp;
  String? _confirmPassword;
  bool isObscuredTextActiveForPassword = true;
  bool isObscuredTextActiveForConfirmPassword = false;
  bool isSignInOptionActive = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSignInOptionActive ? Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.brown[100]!,
              Colors.brown[200]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.5),
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
                    Text(
                      'Welcome back! Please Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent[400],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Email Field
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
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
                      onSaved: (value) {
                        _emailForLogin = value;
                      },
                    ),
                    SizedBox(height: 16),
                    // Password Field
                    TextFormField(
                      maxLength: 15,
                      obscureText: !isObscuredTextActiveForPassword, // This hides the password input
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            isObscuredTextActiveForPassword = !isObscuredTextActiveForPassword;
                          });
                        }, icon: isObscuredTextActiveForPassword ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined)),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
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
                      onSaved: (value) {
                        _passwordForLogin = value; // Save the password
                      },
                    ),
                    SizedBox(height: 16), // Space between fields
                    // Login Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKeyForLogin.currentState!.validate()) {
                            _formKeyForLogin.currentState!.save();
                            // FOR DB registration with _name, phoneNumber, _email, _age
                            Navigator.push(context,MaterialPageRoute(
                                builder:(context) => HomePageBuilder()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Logged into your account successfully!!')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent, // Background color
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
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
                        Text('New to bondiy? '),
                        InkWell(onTap: (){
                          setState(() {
                            isSignInOptionActive = !isSignInOptionActive;
                          },);
                        },
                        child:Text('Sign Up>',style: TextStyle(fontWeight:FontWeight.bold,color: Colors.redAccent,fontSize: 16,decoration: TextDecoration.underline,decorationColor: Colors.red,decorationThickness: 1,),),)
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
          gradient: LinearGradient(
            colors: [
              Colors.brown[50]!,
              Colors.brown[100]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.5),
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
                    Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent[400],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Username Field
                    TextFormField(
                      maxLength: 40,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_2_outlined),
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
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
                      onSaved: (value) {
                        _name = value;
                      },
                    ),
                    SizedBox(height: 16),
                    // Email Field
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
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
                      onSaved: (value) {
                        _emailForSignUp = value;
                      },
                    ),
                    SizedBox(height: 16),
                    // Password Field
                    TextFormField(
                      maxLength: 15,
                      obscureText: !isObscuredTextActiveForPassword, // This hides the password input
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscuredTextActiveForPassword = !isObscuredTextActiveForPassword;
                            });
                          },
                          icon: isObscuredTextActiveForPassword
                              ? Icon(Icons.visibility_outlined)
                              : Icon(Icons.visibility_off_outlined),
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
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
                      onChanged: (value) {
                        setState(() {
                          _passwordForSignUp = value; // Update password on every change
                        });
                      },
                      onSaved: (value) {
                        _passwordForSignUp = value; // Save the password
                      },
                    ),
                    // Confirm Password Field
                    TextFormField(
                      maxLength: 15,
                      obscureText: !isObscuredTextActiveForConfirmPassword, // This hides the confirm password input
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscuredTextActiveForConfirmPassword =
                              !isObscuredTextActiveForConfirmPassword;
                            });
                          },
                          icon: isObscuredTextActiveForConfirmPassword
                              ? Icon(Icons.visibility_outlined)
                              : Icon(Icons.visibility_off_outlined),
                        ),
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _confirmPassword = value; // Update confirm password on every change
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordForSignUp) {
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
                                builder:(context) => HomePageBuilder()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Profile created successfully $_name...')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent, // Background color
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
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
                        Text('Already have an account? '),
                        InkWell(onTap: (){
                          setState(() {
                            isSignInOptionActive = !isSignInOptionActive;
                          },);
                        },
                          child:Text('Login>',style: TextStyle(fontWeight:FontWeight.bold,color: Colors.redAccent,fontSize: 16,decoration: TextDecoration.underline,decorationColor: Colors.red,decorationThickness: 1,),),)
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