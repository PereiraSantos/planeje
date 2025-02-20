import 'package:planeje/login/datasource/database/user_database.dart';
import 'package:planeje/login/entities/user.dart';

class Credentials {
  UserDatabaseFactory userDatabaseFactory;
  Credentials(this.userDatabaseFactory);

  Future<bool> login(User user) async {
    User? userTemp = await userDatabaseFactory.validUser(user);
    return userTemp != null && user.login == userTemp.login && user.password == userTemp.password;
  }

  Future<void> insertUser(User user) async {
    return await userDatabaseFactory.insertUser(user);
  }

  Future<User?> findUserById() async {
    return await userDatabaseFactory.findUserById();
  }

  Future<int?> updateKeepLogged(bool keepLogged) async {
    return await userDatabaseFactory.updateKeepLogged(keepLogged);
  }
}
