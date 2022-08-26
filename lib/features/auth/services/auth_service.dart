import 'package:amazon_clone/models/user.dart';

class AuthService {
  //sign up user
  void signUpUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      User user = User(
        id: '',
        username: username,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );
    } catch (e) {}
  }
}
