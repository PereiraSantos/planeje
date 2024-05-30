import 'package:flutter/material.dart';
import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';
import 'package:planeje/quiz_revision/utils/register_question/register_question.dart';
import 'package:planeje/quiz_revision/utils/register_question/remove_question.dart';
import 'package:planeje/quiz_revision/utils/register_question/table_question.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/find_list_quiz.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/remove_quiz.dart';
import 'package:planeje/revision/pages/list_revision/page/list_revision.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/type_message.dart';

import '../../../../annotation/pages/list_annotation/page/list_annotation.dart';
import '../../../../dashboard/pages/home.dart';
import '../../../../usercase/transitions_builder.dart';
import '../../../../widgets/app_bar_widget.dart';
import '../../../datasource/database/quiz_database.dart';
import '../../../entities/question.dart';
import '../../../utils/register_quiz/register_quiz.dart';
import '../../register_quiz/page/register_quiz_page.dart';
import '../component/dialog_delete.dart';
import '../component/list_question.dart';

class ListQuiz extends StatefulWidget {
  const ListQuiz({super.key});

  @override
  State<ListQuiz> createState() => _ListQuizState();
}

class _ListQuizState extends State<ListQuiz> {
  void reloadPage() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBarWidget(
          callbackHome: () => Navigator.of(context).push(TransitionsBuilder.createRoute(const Home())),
          callbackReviser: () =>
              Navigator.of(context).push(TransitionsBuilder.createRoute(const ListRevision())),
          callbackAnnotation: () =>
              Navigator.of(context).push(TransitionsBuilder.createRoute(const ListAnnotation())),
          callBackQuiz: () => Navigator.of(context).push(TransitionsBuilder.createRoute(const ListQuiz())),
          callbackAdd: () async {
            var result = await Navigator.of(context).push(
              TransitionsBuilder.createRoute(
                RegisterQuizPage(
                  registerQuiz: SaveQuiz(QuizDatabase(), Quiz(), Message()),
                ),
              ),
            );

            if (result) reloadPage();
          },
          callbackFilter: () {
            reloadPage();
          },
          colorQuiz: Colors.black54,
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: GetQuiz(QuizDatabase()).getAllQuiz(),
          builder: (BuildContext context, AsyncSnapshot<List<Quiz>?> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          var result = await DialogDelete.build(context, snapshot.data![index]);

                          if (result && context.mounted) {
                            final TableQuestionNotifier tableQuestionNotifier = TableQuestionNotifier();
                            tableQuestionNotifier.deleteQuestionByIdQuiz(snapshot.data![index].id!);

                            await RemoveQuestion(QuestionDatabase()).delete(tableQuestionNotifier.questions);

                            await DeleteQuiz(QuizDatabase()).deleteQuiz(snapshot.data![index].id!);
                            if (!context.mounted) return;
                            MessageUser.message(context, 'Removido com sucesso');
                            reloadPage();
                          }
                        }
                        return null;
                      },
                      background: const Align(
                        alignment: Alignment(-0.9, 0),
                        child: Icon(Icons.delete, color: Colors.red, size: 30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: GestureDetector(
                          onTap: () async {
                            var result = await Navigator.of(context).push(
                              TransitionsBuilder.createRoute(
                                RegisterQuizPage(
                                  registerQuiz: UpdateQuiz(
                                    QuizDatabase(),
                                    (snapshot.data![index]),
                                    Message(TypeMessage.Atualizar),
                                  ),
                                ),
                              ),
                            );
                            if (result) reloadPage();
                          },
                          child: Card(
                            elevation: 8,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                  child: Text("Assunto: ${snapshot.data![index].topic ?? ''}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 05),
                                  child: Text(
                                    "Pergunta: ${snapshot.data![index].description}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                FutureBuilder(
                                  future: GetQuestion(QuestionDatabase())
                                      .getQuestionByIdQuiz(snapshot.data![index].id!),
                                  builder: (BuildContext context, AsyncSnapshot<List<Question>?> snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.isNotEmpty) {
                                        return ListQuestion(listQuestion: snapshot.data ?? []);
                                      }

                                      return const SizedBox();
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: const Text(
                    "Não há quiz!!!",
                    style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w300),
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
