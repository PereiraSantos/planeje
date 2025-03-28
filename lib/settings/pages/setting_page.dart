import 'package:flutter/material.dart';
import 'package:planeje/login/datasource/database/user_database.dart';
import 'package:planeje/login/entities/user.dart';
import 'package:planeje/login/pages/login_page.dart';
import 'package:planeje/login/utils/credentials.dart';
import 'package:planeje/settings/entities/settings.dart';
import 'package:planeje/widgets/text_button_widget.dart';

// ignore: must_be_immutable
class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController realize = TextEditingController();
  final TextEditingController next = TextEditingController();
  Settings settingsRealize = Settings();
  Settings settingsNext = Settings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: const Text(
          'Configuração',
          style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /*  Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(left: 15),
                  child: const Text(
                    'Revisão na dashboard a realizar e próximas',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                FutureBuilderCustom().future(
                  future: FindSetting(SettingDatabaseDataSource()).findSettingByKey('realize'),
                  child: (Settings? setting) {
                    realize.text = setting?.value ?? '';
                    if (setting != null) {
                      settingsRealize.setId = setting.id!;
                      settingsRealize.setKey = setting.key!;
                      settingsRealize.setValue = setting.value!;
                    }

                    return TextFormFieldWidget(
                      controller: realize,
                      maxLine: 1,
                      hintText: 'Quantidade a realizar',
                      keyboardType: TextInputType.number,
                      textArea: true,
                      onChange: (value) => settingsRealize.setValue = value ?? '',
                    );
                  },
                ),
                FutureBuilderCustom().future(
                  future: FindSetting(SettingDatabaseDataSource()).findSettingByKey('next'),
                  child: (Settings? setting) {
                    next.text = setting?.value ?? '';
                    if (setting != null) {
                      settingsNext.setId = setting.id!;
                      settingsNext.setKey = setting.key!;
                      settingsNext.setValue = setting.value!;
                    }

                    return TextFormFieldWidget(
                      controller: next,
                      maxLine: 1,
                      hintText: 'Quantidade próximas',
                      keyboardType: TextInputType.number,
                      textArea: true,
                      onChange: (value) => settingsNext.setValue = value ?? '',
                    );
                  },
                ),*/

                TextButtonWidget(
                  label: 'Sair',
                  onClick: () async {
                    User? user = await Credentials(UserDatabase()).findUserById();

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(
                          login: user?.login,
                          password: user?.password,
                          keepMeLoggedIn: user?.keepLogged,
                        ),
                      ),
                    );
                  },
                  padding: const EdgeInsets.only(left: 0.0, right: 20.0, top: 5.0),
                ),
              ],
            ),
          ),
        ),
      ),
      /* bottomSheet: BottomSheetWidget(
        children: [
          TextButtonWidget.cancel(() => Navigator.pop(context, false)),
          TextButtonWidget.save(
            () async {
              try {
                if (!formKey.currentState!.validate()) return;

                var resultRealize = await UpdateSetting(
                  SettingDatabaseDataSource(),
                  settingsRealize,
                  StatusNotification(),
                ).write();

                var resultNext = await UpdateSetting(
                  SettingDatabaseDataSource(),
                  settingsNext,
                  StatusNotification(),
                ).write();

                if (resultRealize != null && resultNext != null && context.mounted) {
                  MessageUser.message(context, StatusNotification(TypeMessage.Atualizar).message);
                  Navigator.pop(context, true);
                }
              } catch (e) {
                if (!context.mounted) return;
                MessageUser.message(context, 'Erro ao registrar!!!');
              }
            },
          ),
        ],
      ),*/
    );
  }
}
