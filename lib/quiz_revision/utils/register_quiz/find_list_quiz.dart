import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';

abstract class FindListQuiz {
  Future<List<Quiz>?> getAllQuiz(String text);
}

class GetQuiz implements FindListQuiz {
  DatasourceQuizRepository datasourceQuiz;

  GetQuiz(this.datasourceQuiz);

  @override
  Future<List<Quiz>?> getAllQuiz(String text) async {
    return await datasourceQuiz.getAllQuiz(text);
  }
}
