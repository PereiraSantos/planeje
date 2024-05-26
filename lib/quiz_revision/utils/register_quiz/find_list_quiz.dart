import 'package:planeje/quiz_revision/datasource/repository/datasource_quiz_repository.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';

abstract class FindListQuiz {
  Future<List<Quiz>?> getAllQuiz();
}

class GetQuiz implements FindListQuiz {
  DatasourceQuizRepository datasourceQuiz;

  GetQuiz(this.datasourceQuiz);

  @override
  Future<List<Quiz>?> getAllQuiz() async {
    return await datasourceQuiz.getAllQuiz();
  }
}
