import 'package:dio/dio.dart';
import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/find_list_quiz.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/register_quiz.dart';
import 'package:planeje/sync/list_info.dart';
import 'package:planeje/sync/quiz/quiz_controller.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';

class QuizAync {
  Future<bool> getQuiz() async {
    Response response = await Network(ConfigApi(), [Endpoint.quiz]).get();

    QuizController quizController = QuizController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        Quiz quiz = Quiz.fromMapToObject(item);

        Quiz? quizDatabase = await quizController.findQuizByIdExternal(quiz.idExternal!);

        if (quizDatabase != null) quiz.id = quizDatabase.id;

        quizController.quizInfos.add(ListInfo(lists: quiz, update: (quiz.id != null)));
      }

      await quizController.writeQuiz();
    }
    return true;
  }

  Future<bool> posQuiz() async {
    List<Quiz> lists = await GetQuiz(QuizDatabase()).findAllQuizSync() ?? [];

    if (lists.isNotEmpty) {
      for (Quiz item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.quiz]).post(Quiz.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await UpdateQuiz(QuizDatabase(), quiz: item).writeQuiz();
        }
      }
    }
    return true;
  }

  Future<bool> posQuizDisable() async {
    List<Quiz> lists = await GetQuiz(QuizDatabase()).findQuizDisable() ?? [];

    if (lists.isNotEmpty) {
      for (Quiz item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.quiz, Endpoint.update]).post(Quiz.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await UpdateQuiz(QuizDatabase(), quiz: item).writeQuiz();
        }
      }
    }
    return true;
  }
}
