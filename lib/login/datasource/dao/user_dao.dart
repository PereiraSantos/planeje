import 'package:floor/floor.dart';
import 'package:planeje/login/entities/user.dart';

@dao
abstract class UserDao {
  @insert
  Future<void> insertUser(User user);

  @Query('select * from user where login = :login and password = :password')
  Future<User?> findUserLoginPassword(String login, String password);

  @Query('select * from user where logged_in = 1')
  Future<User?> findLoggedIn();

  @Query('select count(login) from user')
  Future<int?> haveRegistration();

  @Query('update user set keep_logged = :keepLogged, logged_in = :loggedIn where login = :login and password = :password')
  Future<int?> updateKeepLogged(bool keepLogged, bool loggedIn, String login, String password);

}
