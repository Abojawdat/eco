import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../state/login_state.dart';
import '../services/token_storge.dart'; // <-- make sure you import this

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final response = await http.post(
        Uri.parse('http://ackg0kcow88s8kks0kokko0s.168.231.110.172.sslip.io/api/Auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final token = data['data']['token']; // ✅ Extract the token

          // ✅ Save the token in SharedPreferences
          await TokenStorage.saveToken(token);

          emit(LoginLoaded()); // Optionally you can pass user info here too
        } else {
          emit(LoginError('Login failed: ${data['message'] ?? 'Unknown error'}'));
        }
      } else {
        final error = jsonDecode(response.body);
        emit(LoginError(error['message'] ?? 'Login failed'));
      }
    } catch (e) {
      emit(LoginError('Login failed: ${e.toString()}'));
    }
  }
}
