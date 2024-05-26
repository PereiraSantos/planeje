import 'package:planeje/quiz_revision/datasource/repository/datasource_quiz_repository.dart';

import '../../entities/quiz.dart';

abstract class RegisterQuiz {
  Future<int?> writeQuiz();
  late Quiz quiz;
}

class SaveQuiz implements RegisterQuiz {
  DatasourceQuizRepository datasourceQuiz;

  SaveQuiz({
    required this.datasourceQuiz,
    required this.quiz,
  });

  @override
  Future<int?> writeQuiz() async {
    return await datasourceQuiz.insertQuiz(quiz);
  }

  @override
  Quiz quiz;
}

class UpdateQuiz implements RegisterQuiz {
  DatasourceQuizRepository datasourceQuiz;

  UpdateQuiz({
    required this.datasourceQuiz,
    required this.quiz,
  });

  @override
  Future<int?> writeQuiz() async {
    return await datasourceQuiz.updateQuiz(quiz);
  }

  @override
  Quiz quiz;
}
