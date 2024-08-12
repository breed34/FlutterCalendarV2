import 'package:calendar_v2/modules/user/user_service.dart';

class RegisterPresenter {
  final UserService _service = UserService();

  void register() {
    _service.register();
  }
}
