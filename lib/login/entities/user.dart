import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class User {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'login')
  String login;

  @ColumnInfo(name: 'password')
  String password;

  @ColumnInfo(name: 'keep_logged')
  bool keepLogged;

  @ColumnInfo(name: 'logged_in')
  bool loggedIn;

  User(this.login, this.password, this.keepLogged, this.loggedIn);
}
