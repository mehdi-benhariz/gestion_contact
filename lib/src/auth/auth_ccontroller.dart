import 'package:contact_gesion/src/auth/auth_services.dart';

class AuthController {
  final AuthService _authService;

  AuthController(this._authService);

  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) return false;

    return await _authService.login(username, password);
  }

  Future<String?> getStoredUser() async {
    return await _authService.getStoredUser();
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
