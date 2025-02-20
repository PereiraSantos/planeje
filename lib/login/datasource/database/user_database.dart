import 'package:planeje/database/app_database.dart';
import 'package:planeje/login/entities/user.dart';

abstract class UserDatabaseFactory {
  Future<User?> validUser(User user);
  Future<void> insertUser(User user);
  Future<int?> haveRegistration();
  Future<int?> updateKeepLogged(bool keepLogged);
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
  Future<int?> updateKeepLogged(bool keepLogged) async {
    final database = await getInstance();
    return await database.userDao.updateKeepLogged(keepLogged);
  }
  
}
