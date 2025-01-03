import 'package:planeje/login/entities/user.dart';

abstract class UserDatabaseFactory {
  Future<bool> validUser(User user);
}

class UserDatabase implements UserDatabaseFactory {
  @override
  Future<bool> validUser(User user) async {
    if (user.login == '1' && user.password == '1') return true;
    return false;
  }
}
