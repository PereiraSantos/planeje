import 'package:flutter/material.dart';
import 'package:planeje/login/datasource/database/user_database.dart';
import 'package:planeje/login/entities/user.dart';
import 'package:planeje/login/pages/login_page.dart';
import 'package:planeje/login/utils/credentials.dart';
import 'package:planeje/settings/entities/settings.dart';
import 'package:planeje/settings/utils/setting_notifier.dart';
import 'package:planeje/sync/annotation/annotation_sync.dart';
import 'package:planeje/sync/question/question_sync.dart';
import 'package:planeje/sync/quiz/quiz_aync.dart';
import 'package:planeje/sync/revision_date/revision_date_sync.dart';
import 'package:planeje/sync/revision_quiz/revision_quiz_sync.dart';
import 'package:planeje/sync/revision/revision_sync.dart';
import 'package:planeje/sync/revision_theme/revision_theme_sync.dart';
import 'package:planeje/utils/message_user.dart';

import 'package:planeje/widgets/text_button_widget.dart';

// ignore: must_be_immutable
class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController realize = TextEditingController();
  final TextEditingController next = TextEditingController();
  Settings settingsRealize = Settings();
  Settings settingsNext = Settings();
  final SettingNotifier _settingNotifierPost = SettingNotifier();
  final SettingNotifier _settingNotifierGet = SettingNotifier();

  Widget _loading(SettingNotifier settingNotifier) {
    return ListenableBuilder(
      listenable: settingNotifier,
      builder: (context, child) {
        if (settingNotifier.status.name == 'loading') {
          return Container(width: 30, height: 20, padding: EdgeInsets.only(right: 10), child: CircularProgressIndicator(strokeWidth: 1));
        }
        if (settingNotifier.status.name == 'concluded') {
          return Container(padding: EdgeInsets.only(right: 10), child: Icon(Icons.check, color: Colors.green, size: 18));
        }

        if (settingNotifier.status.name == 'erro') {
          return Container(padding: EdgeInsets.only(right: 10), child: Icon(Icons.error, color: Colors.red, size: 18));
        }

        return Container(padding: EdgeInsets.only(right: 10), child: Icon(Icons.check, color: Colors.grey, size: 18));
      },
    );
  }

  _initSatus() {
    _settingNotifierPost.init();
    _settingNotifierGet.init();
  }

  @override
  Widget build(BuildContext context) {
    _initSatus();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButtonWidget(
                      label: 'Receber dados',
                      onClick: () async {
                        try {
                          _settingNotifierGet.loading();

                          await Future.wait([
                            RevisionSync().getRevision(),
                            AnnotationSync().getAnnotation(),
                            QuizAync().getQuiz(),
                            QuestionSync().getQuestion(),
                            RevisionDateSync().getRevisionDate(),
                            RevisionQuizSync().getRevisionQuiz(),
                            RevisionThemeSync().getRevisionTheme(),
                          ]);

                          if (context.mounted) {
                            _settingNotifierGet.concluded();
                            await MessageUser.message(context, 'Sincronização finalizada!!');
                          }
                        } catch (e) {
                          _settingNotifierGet.erro();
                        }
                      },
                      padding: const EdgeInsets.only(left: 0.0, right: 20.0, top: 5.0),
                    ),
                    _loading(_settingNotifierGet),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButtonWidget(
                      label: 'Enviar dados',
                      onClick: () async {
                        try {
                          _settingNotifierPost.loading();

                          await Future.wait([
                            RevisionSync().postRevision(),
                            AnnotationSync().postAnnotation(),
                            QuizAync().posQuiz(),
                            QuestionSync().postQuestion(),
                            RevisionDateSync().postRevisionDate(),
                            RevisionQuizSync().postRevisionQuiz(),
                            RevisionThemeSync().postRevisionTheme(),
                          ]);

                          if (context.mounted) {
                            _settingNotifierPost.concluded();
                            await MessageUser.message(context, 'Sincronização finalizada!!');
                          }
                        } catch (e) {
                          _settingNotifierPost.erro();
                        }
                      },
                      padding: const EdgeInsets.only(left: 0.0, right: 20.0, top: 5.0),
                    ),
                    _loading(_settingNotifierPost),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
