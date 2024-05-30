import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';

abstract class FindQuestionList {
  Future<List<Question>?> listQuestionByIdQuiz(int idQuiz);
}

class GetQuestion implements FindQuestionList {
  DatasourceQuestionRepository datasourceQuestion;

  GetQuestion(this.datasourceQuestion);
  @override
  Future<List<Question>?> listQuestionByIdQuiz(int idQuiz) async {
    return await datasourceQuestion.getQuestionByIdQuiz(idQuiz);
  }
}
