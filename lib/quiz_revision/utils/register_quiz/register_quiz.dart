import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/utils/type_message.dart';

import '../../entities/quiz.dart';

abstract class RegisterQuizFactory {
  Future<int?> writeQuiz();
  late Quiz quiz;
  late Message message;
}

class SaveQuiz implements RegisterQuizFactory {
  QuizDatabaseFactory quizDatabase;

  SaveQuiz(this.quizDatabase, this.quiz, this.message);

  @override
  Future<int?> writeQuiz() async {
    return await quizDatabase.insertQuiz(quiz);
  }

  @override
  Quiz quiz;

  @override
  Message message;
}

class UpdateQuiz implements RegisterQuizFactory {
  QuizDatabaseFactory datasourceQuiz;

  UpdateQuiz(this.datasourceQuiz, this.quiz, this.message);

  @override
  Future<int?> writeQuiz() async {
    return await datasourceQuiz.updateQuiz(quiz);
  }

  @override
  Quiz quiz;

  @override
  Message message;
}
