import 'dart:convert';
import 'package:reparaciones_moka/core/auth/user_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionStorage {
  static const _sessionKey = 'user_session';

  Future<void> saveSession(UserSession session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, jsonEncode(session.toJson()));
  }

  Future<UserSession?> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final dataEncoded = prefs.getString(_sessionKey);
    if (dataEncoded == null) return null;
    final Map<String, dynamic> data = jsonDecode(dataEncoded);
    return UserSession.fromJson(data);
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
}
