import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _userKey = 'user';
  static SharedPreferences? _prefs;

  AuthService() {
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> login(String username, String password) async {
    await SharedPreferences.getInstance();
    await _storeUser(username);
    return true;
    await Future.delayed(const Duration(seconds: 1));
    if (username == 'mehdi' && password == '123admin') return true;

    return username.isNotEmpty && password.isNotEmpty;
  }

  Future<void> _storeUser(String username) async {
    await _prefs?.setString(_userKey, username);
  }

  Future<String?> getStoredUser() async {
    return _prefs?.getString(_userKey);
  }

  Future<void> logout() async {
    await _prefs?.remove(_userKey);
  }

  Future<bool> isUserLoggedIn() async {
    return _prefs!.containsKey(_userKey);
  }
}
