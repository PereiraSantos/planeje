import 'dart:async';
import 'package:flutter/material.dart';
import 'package:planeje/dashboard/pages/home.dart';
import 'package:planeje/login/datasource/database/user_database.dart';
import 'package:planeje/login/entities/user.dart';
import 'package:planeje/login/entities/user_global.dart';
import 'package:planeje/login/pages/login_page.dart';
import 'package:planeje/login/utils/credentials.dart';
import 'package:planeje/register/pages/register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    haveRegistration();
  }

  Future<void> haveRegistration() async {
    int isRegistration = await Credentials(UserDatabase()).haveRegistration() ?? 0;
    if(isRegistration > 0){
      User? user = await Credentials(UserDatabase()).findLoggedIn();
      if (user != null && user.keepLogged && user.loggedIn){
        UserGlobal().user = user;
        _goTo(Home());
      } else {
        _goTo(LoginPage());
      }
    } else {
      _goTo(RegisterPage());
    }
  }

  _goTo(dynamic page) {
    Timer(const Duration(seconds: 1), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => page)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/icon.png'),
      ),
    );
  }
}
