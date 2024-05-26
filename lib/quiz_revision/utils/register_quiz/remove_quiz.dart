import 'package:planeje/quiz_revision/datasource/repository/datasource_quiz_repository.dart';

abstract class RemoveQuiz {
  Future<void> deleteQuiz(int id);
}

class DeleteQuiz implements RemoveQuiz {
  DatasourceQuizRepository datasourceQuiz;

  DeleteQuiz(this.datasourceQuiz);
  @override
  Future<void> deleteQuiz(int id) async {
    await datasourceQuiz.deleteQuiz(id);
  }
}
