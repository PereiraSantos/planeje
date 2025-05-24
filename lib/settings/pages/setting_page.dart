import 'package:flutter/material.dart';
import 'package:planeje/login/datasource/database/user_database.dart';
import 'package:planeje/login/entities/user.dart';
import 'package:planeje/login/pages/login_page.dart';
import 'package:planeje/login/utils/credentials.dart';

import 'package:planeje/settings/utils/sync.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/widgets/bottom_sheet/bottom_sheet_widget.dart';

import 'package:planeje/widgets/text_button_widget.dart';

// ignore: must_be_immutable
class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController realize = TextEditingController();
  final TextEditingController next = TextEditingController();
  final Sync sync = Sync();

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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 5.0),
                      child: Text('Enviar dados'),
                    ),
                    ListenableBuilder(
                      listenable: sync.syncNotifierPost,
                      builder: (context, child) => sync.syncNotifierPost.status.build(context),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 5.0),
                      child: Text('Receber dados'),
                    ),
                    ListenableBuilder(
                      listenable: sync.syncNotifierGet,
                      builder: (context, child) => sync.syncNotifierGet.status.build(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: BottomSheetWidget(
        children: [
          TextButtonWidget.sync(() async {
            try {
              await sync.postData();

              await sync.receiveData();

              if (context.mounted) await MessageUser.message(context, 'Sincronização finalizada!!!');
            } catch (e) {
              if (context.mounted) await MessageUser.message(context, 'Erro ao sincronização!!!');
            }
          }),
          TextButtonWidget(
            label: 'DESLOGAR',
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
          ),
        ],
      ),
    );
  }
}
