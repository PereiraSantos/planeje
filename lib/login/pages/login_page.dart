import 'package:flutter/material.dart';
import 'package:planeje/dashboard/pages/home.dart';
import 'package:planeje/login/datasource/database/user_database.dart';
import 'package:planeje/login/entities/user.dart';
import 'package:planeje/login/utils/credentials.dart';
import 'package:planeje/register/pages/register_page.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/widgets/checkbox_custom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.login,
    this.password,
    this.keepMeLoggedIn,
  });

  final String? login;
  final String? password;
  final bool? keepMeLoggedIn;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscureText = true;
  bool _keepMeLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _login.text = widget.login ?? '';
    _password.text = widget.password ?? '';
    _keepMeLoggedIn = widget.keepMeLoggedIn ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(width: 100, height: 100, child: Image.asset('assets/icon.png')),
                TextFormField(
                  controller: _login,
                  decoration: const InputDecoration(
                    hintText: 'Login',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Login obrigatório';
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _obscureText = !_obscureText),
                        icon: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      ),
                    ),
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Senha obrigatória';
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 15, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CheckBoxCustom(
                          onClick: (value) {
                            setState(() => _keepMeLoggedIn = value ?? false);
                          },
                          isChecked: _keepMeLoggedIn,
                          activeColor: _keepMeLoggedIn ? Colors.white : Colors.grey,
                          checkColor: Colors.green,
                        ),
                      ),
                      Expanded(flex: 8, child: const Text('Mantenha-me conectado')),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => RegisterPage())),
                            child: const Text('Cadastre-se')),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        FocusScope.of(context).requestFocus(FocusNode());
                        User user = User(_login.text, _password.text, _keepMeLoggedIn);
                        if (await Credentials(UserDatabase()).login(user) && context.mounted) {
                          Credentials(UserDatabase()).updateKeepLogged(_keepMeLoggedIn);

                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home()));
                        } else {
                          await MessageUser.message(context, 'Login incorreto!!!');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(221, 33, 149, 243)),
                        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      child: const Text('Entrar', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
                GestureDetector(onTap: () {}, child: const Text('Esqueci minha senha')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
