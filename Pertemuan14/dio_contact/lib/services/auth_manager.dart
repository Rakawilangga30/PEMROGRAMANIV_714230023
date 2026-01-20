import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static const String _usernameKey = 'username';
  static const String _tokenKey = 'token';
  static const String _loginTimeKey = 'login_time';
  static const Duration maxDuration = Duration(hours: 4);

  // Cek status login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_usernameKey);
    final loginTime = prefs.getString(_loginTimeKey);

    if (username == null || loginTime == null) {
      return false;
    }

    // Cek apakah login sudah lebih dari 4 jam
    final savedTime = DateTime.parse(loginTime);
    final currentTime = DateTime.now();
    final difference = currentTime.difference(savedTime);

    if (difference > maxDuration) {
      // Jika sudah lebih dari 4 jam, logout otomatis
      await logout();
      return false;
    }

    return true;
  }

  // Simpan data login
  static Future<void> login(String username, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_loginTimeKey, DateTime.now().toIso8601String());
  }

  // Ambil username dari SharedPreferences
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  // Ambil token dari SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Logout - hapus semua data
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_tokenKey);
    await prefs.remove(_loginTimeKey);
  }
}
