import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class User {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'login')
  String login;

  @ColumnInfo(name: 'password')
  String password;

  User(this.login, this.password);
}
