import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/utils/type_message.dart';

import '../../entities/quiz.dart';

abstract class RegisterQuizFactory {
  Future<int?> writeQuiz();
  Quiz? quiz;
  Future<void> writeQuizList();
  List<Quiz>? quizs;
  StatusNotification? message;
}

class SaveQuiz implements RegisterQuizFactory {
  QuizDatabaseFactory quizDatabase;

  SaveQuiz(this.quizDatabase, {this.quiz, this.message, this.quizs});

  @override
  Future<int?> writeQuiz() async {
    if (quiz == null) throw ('Teve passar um objeto quiz');
    return await quizDatabase.insertQuiz(quiz!);
  }

  @override
  Quiz? quiz;

  @override
  StatusNotification? message;

  @override
  List<Quiz>? quizs;

  @override
  Future<List<int>> writeQuizList() async {
    if (quizs == null) throw ('Teve passar a uma lista de quizs');
    return await quizDatabase.insertQuizList(quizs!);
  }
}

class UpdateQuiz implements RegisterQuizFactory {
  QuizDatabaseFactory datasourceQuiz;

  UpdateQuiz(this.datasourceQuiz, {this.quiz, this.message, this.quizs});

  @override
  Future<int?> writeQuiz() async {
    if (quiz == null) throw ('Teve passar um objeto quiz');
    return await datasourceQuiz.updateQuiz(quiz!);
  }

  @override
  Quiz? quiz;

  @override
  StatusNotification? message;

  @override
  List<Quiz>? quizs;

  @override
  Future<void> writeQuizList() async {
    if (quizs == null) throw ('Teve passar a uma lista de quizs');
    return await datasourceQuiz.updateQuizList(quizs!);
  }
}
