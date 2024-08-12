import 'package:calendar_v2/modules/user/user_service.dart';

class LoginPresenter {
  final UserService _service = UserService();

  void login() {
    _service.login();
  }
}
