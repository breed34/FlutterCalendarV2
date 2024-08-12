import 'package:calendar_v2/data_handler/data_handler.dart';

class UserService {
  final DataHandler _dataHandler = DataHandler();

  void login() {
    _dataHandler.login();
  }

  void register() {
    _dataHandler.register();
  }

  void logout() {
    _dataHandler.logout();
  }
}
