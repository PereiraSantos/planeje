import 'package:planeje/login/datasource/database/user_database.dart';
import 'package:planeje/login/entities/user.dart';

class Credentials {
  UserDatabaseFactory userDatabaseFactory;
  Credentials(this.userDatabaseFactory);

  Future<bool> login(User user) async => userDatabaseFactory.validUser(user);
}
