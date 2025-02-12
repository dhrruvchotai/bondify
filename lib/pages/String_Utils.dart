
const String FULLNAME = 'FullName';
const String PHONE = 'PhoneNumber';
const String EMAIL = 'Email';
const String DOB = 'DateOfBirth';
const String GENDER = 'Gender';
const String RELIGION = 'Religion';
const String CITY = 'City';
const String HOBBIES = 'Hobbies';
const String ISUSERFAV = "IsUserFav";

//FOR AUTH TABLE
const String USERNAME = 'username';
const String PASSWORD = 'password';
const String AUTH_EMAIL = 'email';

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printResultText(String text) {
  print('\x1B[31m$text\x1B[0m');
}
