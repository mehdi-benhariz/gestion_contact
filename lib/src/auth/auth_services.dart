import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _userKey = 'user';

  Future<bool> login(String username, String password) async {
    return true;
    await Future.delayed(const Duration(seconds: 1));
    if (username == 'mehdi' && password == '123admin') return true;

    return username.isNotEmpty && password.isNotEmpty;
  }

  Future<void> _storeUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, username);
  }

  Future<String?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
