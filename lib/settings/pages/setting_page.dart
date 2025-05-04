import 'package:flutter/material.dart';
import 'package:planeje/login/datasource/database/user_database.dart';
import 'package:planeje/login/entities/user.dart';
import 'package:planeje/login/pages/login_page.dart';
import 'package:planeje/login/utils/credentials.dart';
import 'package:planeje/settings/entities/settings.dart';
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
                TextButtonWidget(
                  label: 'Receber dados',
                  onClick: () async {
                    await RevisionSync().getRevision();
                    await AnnotationSync().getAnnotation();
                    await QuizAync().getQuiz();
                    await QuestionSync().getQuestion();
                    await RevisionDateSync().getRevisionDate();
                    await RevisionQuizSync().getRevisionQuiz();
                    await RevisionThemeSync().getRevisionTheme();

                    if (context.mounted) await MessageUser.message(context, 'Sincronização finalizada!!');
                  },
                  padding: const EdgeInsets.only(left: 0.0, right: 20.0, top: 5.0),
                ),
                TextButtonWidget(
                  label: 'Enviar dados',
                  onClick: () async {
                    await RevisionSync().postRevision();
                    await AnnotationSync().postAnnotation();
                    await QuizAync().posQuiz();
                    await QuestionSync().postQuestion();
                    await RevisionDateSync().postRevisionDate();
                    await RevisionQuizSync().postRevisionQuiz();
                    await RevisionThemeSync().postRevisionTheme();

                    if (context.mounted) await MessageUser.message(context, 'Sincronização finalizada!!');
                  },
                  padding: const EdgeInsets.only(left: 0.0, right: 20.0, top: 5.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
