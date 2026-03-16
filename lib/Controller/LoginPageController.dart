import 'package:shared_preferences/shared_preferences.dart';

class Logincontroller {
  String email = "";
  String password = "";
  bool isLoggedIn = false;
  bool isOnboardingSeen = false;
  String? accountType;

  Future<void> setSharedPrefData(Map<String, dynamic> obj) async {
    SharedPreferences sharedPreferencesobj =
        await SharedPreferences.getInstance();
    await sharedPreferencesobj.setString('email', obj['email']);
    await sharedPreferencesobj.setString('password', obj['password']);
    await sharedPreferencesobj.setBool('isLoggedIn', obj['loginflag']);
    await sharedPreferencesobj.setBool('seenOnboarding', obj['seenOnboarding']);
    if (obj['accountType'] != null) {
      await sharedPreferencesobj.setString('accountType', obj['accountType']);
    }
  }

 
  Future<void> getSharedPrefData() async {
    SharedPreferences sharedPreferencesobj =
        await SharedPreferences.getInstance();

    email = sharedPreferencesobj.getString("email") ?? "";
    password = sharedPreferencesobj.getString("password") ?? "";
    isLoggedIn = sharedPreferencesobj.getBool("isLoggedIn") ?? false;
    isOnboardingSeen = sharedPreferencesobj.getBool("seenOnboarding") ?? false;
    accountType = sharedPreferencesobj.getString('accountType');
  }

  Future<void> clearSharedPref() async {
  SharedPreferences sharedPreferencesobj =
      await SharedPreferences.getInstance();
  await sharedPreferencesobj.clear();
  await sharedPreferencesobj.setBool('seenOnboarding', true);

  email = "";
  password = "";
  isLoggedIn = false;
  isOnboardingSeen = true;
  accountType = null;
}

}
