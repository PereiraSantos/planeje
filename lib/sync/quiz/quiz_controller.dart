import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/find_list_quiz.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/register_quiz.dart';
import 'package:planeje/sync/list_info.dart';

class QuizController {
  List<ListInfo> quizInfos = [];

  Future<bool> writeRevision() async {
    List<ListInfo> listInfoUpdate = [...quizInfos.where((item) => item.update)];

    quizInfos.removeWhere((item) => item.update);

    if (listInfoUpdate.isNotEmpty) {
      await UpdateQuiz(QuizDatabase(), quizs: listInfoUpdate.map<Quiz>((e) => e.lists).toList()).writeQuizList();
    }

    if (quizInfos.isNotEmpty) {
      await SaveQuiz(QuizDatabase(), quizs: quizInfos.map<Quiz>((e) => e.lists).toList()).writeQuizList();
    }

    return true;
  }

  Future<Quiz?> findQuizByIdExternal(int idExternal) async {
    return await GetQuiz(QuizDatabase()).findQuizByIdExternal(idExternal);
  }
}
