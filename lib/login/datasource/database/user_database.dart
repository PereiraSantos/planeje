import 'package:planeje/database/app_database.dart';
import 'package:planeje/login/entities/user.dart';

abstract class UserDatabaseFactory {
  Future<User?> validUser(User user);
  Future<void> insertUser(User user);
  Future<int?> haveRegistration();
}

class UserDatabase implements UserDatabaseFactory {
  @override
  Future<User?> validUser(User user) async {
    final database = await getInstance();
    return database.userDao.findUserLoginPassword(user.login, user.password);
  }

  @override
  Future<void> insertUser(User user) async {
    final database = await getInstance();
    return database.userDao.insertUser(user);
  }

  @override
  Future<int?> haveRegistration() async {
    final database = await getInstance();
    return database.userDao.haveRegistration();
  }
}
