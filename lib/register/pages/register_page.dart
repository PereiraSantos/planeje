import 'package:flutter/material.dart';
import 'package:planeje/login/datasource/database/user_database.dart';
import 'package:planeje/login/entities/user.dart';
import 'package:planeje/login/pages/login_page.dart';
import 'package:planeje/login/utils/credentials.dart';
import 'package:planeje/utils/message_user.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _login,
                  decoration: const InputDecoration(
                    hintText: 'Login',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Campo obrigatório';
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(
                      hintText: 'Senha',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Campo obrigatório';
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const LoginPage())),
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(221, 33, 149, 243)),
                              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            child: const Text('Voltar', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                if (!_formKey.currentState!.validate()) return;
                                FocusScope.of(context).requestFocus(FocusNode());

                                await Credentials(UserDatabase()).insertUser(User(_login.text, _password.text, false, false));

                                if (context.mounted) {
                                  MessageUser.message(context, 'Cadastro realizado!!!');
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()));
                                }
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                MessageUser.message(context, 'Erro ao cadastrar!!!');
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(221, 33, 149, 243)),
                              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            child: const Text('Registrar', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
