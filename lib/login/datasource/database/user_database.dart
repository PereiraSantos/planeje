import 'package:planeje/database/app_database.dart';
import 'package:planeje/login/entities/user.dart';

abstract class UserDatabaseFactory {
  Future<User?> validUser(User user);
  Future<void> insertUser(User user);
  Future<int?> haveRegistration();
  Future<int?> updateKeepLogged(User user);
  Future<User?> findLoggedIn();
}

class UserDatabase implements UserDatabaseFactory {
  @override
  Future<User?> validUser(User user) async {
    final database = await getInstance();
    return await database.userDao.findUserLoginPassword(user.login, user.password);
  }

  @override
  Future<void> insertUser(User user) async {
    final database = await getInstance();
    return await database.userDao.insertUser(user);
  }

  @override
  Future<int?> haveRegistration() async {
    final database = await getInstance();
    return await database.userDao.haveRegistration();
  }
  
  @override
  Future<int?> updateKeepLogged(User user) async {
    final database = await getInstance();
    return await database.userDao.updateKeepLogged(user.keepLogged, user.loggedIn, user.login, user.password);
  }
  
  @override
  Future<User?> findLoggedIn() async {
    final database = await getInstance();
    return await database.userDao.findLoggedIn();
  }
}
