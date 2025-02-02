import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:intl/intl.dart';
import 'AboutUs.dart';
import 'DisplayAllProfiles.dart';
import 'DisplayFavProfiles.dart';
import 'RegistrationPage.dart';
import 'User.dart';

class AddProfile extends StatefulWidget {
  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {

  User users = User();
  int _selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _religion = TextEditingController();
  String? _gender;
  String? _city;
  int? _pickedYear;
  List<String> _hobbies = [];
  final List<String> _hobbiesOptions = ['Playing', 'Singing', 'Dancing', 'Reading'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.7),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Add Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent[400],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Full Name Field
                    TextFormField(
                      controller: _fullName,
                      maxLength: 50,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_2_outlined),
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Phone Number Field
                    TextFormField(
                      controller: _phoneNumber,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_outlined),
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Email Field
                    TextFormField(
                      controller: _email,
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

                    ),
                    SizedBox(height: 16),
                    // Date of Birth Field
                    TextFormField(
                      readOnly: true,
                      controller: _dobController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _pickedYear = pickedDate.year;
                            _dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                          });
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select your date of birth';
                        }
                        if((DateTime.now().year - _pickedYear!) < 18){
                          return 'Age must me above 18 years!!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Gender Field
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return Column(
                          children: [
                            InputDecorator(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.wc_outlined),
                                labelText: 'Gender',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                errorText: state.errorText,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 18,),
                                  Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Male',
                                        groupValue: _gender,
                                        onChanged: (value) {
                                          setState(() {
                                            _gender = value;
                                            state.didChange(value);
                                          });
                                        },
                                      ),
                                      Text('Male',style: TextStyle(fontSize: 17,)),
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                  SizedBox(width: 18,),
                                  Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Female',
                                        groupValue: _gender,
                                        onChanged: (value) {
                                          setState(() {
                                            _gender = value;
                                            state.didChange(value);
                                          });
                                        },
                                      ),
                                      Text('Female',style: TextStyle(fontSize: 17),),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                          ],
                        );
                      },
                      validator: (value) {
                        if (_gender == null) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Religion Field
                    TextFormField(
                      controller: _religion,
                      maxLength: 30,
                      decoration: InputDecoration(
                        labelText: 'Religion',
                        prefixIcon: LineIcon.placeOfWorship(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your religion';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    //city field dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_city_rounded),
                        labelText: 'City',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: [  "Ahmedabad",
                        "Surat",
                        "Vadodara",
                        "Rajkot",
                        "Bhavnagar",
                        "Jamnagar",
                        "Junagadh",
                        "Gandhinagar",
                        "Anand",
                        "Morbi",
                        "Nadiad",
                        "Mehsana",
                        "Bharuch",
                        "Navsari",
                        "Porbandar",
                        "Vapi",
                        "Valsad",
                        "Palanpur",
                        "Gondal",
                        "Godhra",
                        "Veraval",
                        "Patan",
                        "Kalol",
                        "Dahod",
                        "Botad",
                        "Amreli",
                        "Surendranagar",
                        "Himatnagar",
                        "Modasa",
                        "Mahesana",
                        "Dwarka",
                        "Mandvi",
                        "Ankleshwar",
                        "Deesa",
                        "Bhuj",
                        "Kadi",
                        "Visnagar",
                        "Dholka",
                        "Sanand",
                        "Wadhwan",
                        "Unjha",
                        "Halol",
                        "Chhota Udaipur",
                        "Lunawada",
                        "Savarkundla",
                        "Mahuva",
                        "Manavadar",
                        "Viramgam",
                        "Bodeli",
                        "Jetpur",
                        "Dhoraji",
                        "Jasdan",
                        "Khambhat",
                        "Keshod",
                        "Talaja",
                        "Mangrol",
                        "Bagasara",
                        "Umreth",
                        "Sihor",
                        "Petlad",
                        "Gadhada",
                        "Bhanvad",
                        "Vijapur",
                        "Radhanpur",
                        "Kutch",
                        "Kapadvanj",
                        "Tharad",
                        "Bayad",
                        "Idar",
                        "Mansa",
                        "Dabhoi",
                        "Karjan",
                        "Songadh",
                        "Bilkha",
                        "Okha",
                        "Jhalod",
                        "Mangrol (Junagadh)"]
                          .map((city) => DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      ))
                          .toList(),
                      onChanged: (value) {
                        _city = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your city';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Hobbies Field
                    FormField(
                      builder: (FormFieldState state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InputDecorator(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.sports_soccer_outlined),
                                labelText: 'Hobbies',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                errorText: state.errorText,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: CheckboxListTile(
                                          title: Text('Playing', style: TextStyle(fontSize: 17)),
                                          value: _hobbies.contains('Playing'),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == true) {
                                                _hobbies.add('Playing');
                                              } else {
                                                _hobbies.remove('Playing');
                                              }
                                            });
                                          },
                                          controlAffinity: ListTileControlAffinity.leading, // Places the checkbox on the left
                                          contentPadding: EdgeInsets.zero, // Removes extra padding
                                        ),
                                      ),
                                      Expanded(
                                        child: CheckboxListTile(
                                          title: Text('Singing', style: TextStyle(fontSize: 17)),
                                          value: _hobbies.contains('Singing'),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == true) {
                                                _hobbies.add('Singing');
                                              } else {
                                                _hobbies.remove('Singing');
                                              }
                                            });
                                          },
                                          controlAffinity: ListTileControlAffinity.leading,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CheckboxListTile(
                                          title: Text('Dancing', style: TextStyle(fontSize: 17)),
                                          value: _hobbies.contains('Dancing'),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == true) {
                                                _hobbies.add('Dancing');
                                              } else {
                                                _hobbies.remove('Dancing');
                                              }
                                            });
                                          },
                                          controlAffinity: ListTileControlAffinity.leading,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                      Expanded(
                                        child: CheckboxListTile(
                                          title: Text('Reading', style: TextStyle(fontSize: 17)),
                                          value: _hobbies.contains('Reading'),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == true) {
                                                _hobbies.add('Reading');
                                              } else {
                                                _hobbies.remove('Reading');
                                              }
                                            });
                                          },
                                          controlAffinity: ListTileControlAffinity.leading,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      validator: (value) {
                        if (_hobbies.isEmpty) {
                          return 'Please select at least one hobby';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Submit Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              users.addUserInList(fullname: _fullName.text, phone: _phoneNumber.text, email: _email.text, dob: _dobController.text, gender: _gender, religion: _religion.text, city: _city,hobbies: _hobbies,isUserFav: false);
                              _fullName.clear();
                              _phoneNumber.clear();
                              _email.clear();
                              _dobController.clear();
                              _religion.clear();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Profile submitted successfully!')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
