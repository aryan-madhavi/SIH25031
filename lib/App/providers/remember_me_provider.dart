// Remember me state (bool + saved creds)
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberMeState {
  final bool rememberMe;
  final String email;
  final String password;

  RememberMeState({
    this.rememberMe = false,
    this.email = '',
    this.password = '',
  });

  RememberMeState copyWith({
    bool? rememberMe,
    String? email,
    String? password,
  }) {
    return RememberMeState(
      rememberMe: rememberMe ?? this.rememberMe,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class RememberMeNotifier extends StateNotifier<RememberMeState> {
  RememberMeNotifier() : super(RememberMeState()) {
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email') ?? '';
    final savedPassword = prefs.getString('saved_password') ?? '';
    final savedRememberMe = prefs.getBool('saved_rememberMe') ?? false;

    state = RememberMeState(
      rememberMe: savedRememberMe,
      email: savedEmail,
      password: savedPassword,
    );
  }

  Future<void> toggleRememberMe(
    bool value,
    String email,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    state = state.copyWith(rememberMe: value, email: email, password: password);

    if (value) {
      await prefs.setBool('saved_rememberMe', true);
      await prefs.setString('saved_email', email);
      await prefs.setString('saved_password', password);
    } else {
      await prefs.clear();
    }
  }
}

final rememberMeProvider =
    StateNotifierProvider<RememberMeNotifier, RememberMeState>(
      (ref) => RememberMeNotifier(),
    );
