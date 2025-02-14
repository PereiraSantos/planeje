import 'package:planeje/login/entities/user.dart';

class UserGlobal {
   static final UserGlobal _userGlobal = UserGlobal._internal();
  
  factory UserGlobal() {
    return _userGlobal;
  }
  
  UserGlobal._internal();

   User? _user;

  set user(User user) => _user = user;
  User? getUser() => _user;
}