import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';

abstract class FindQuestionListFactory {
  Future<List<Question>?> listQuestionByIdQuiz(int idQuiz);
  Future<List<Question>?> findQuestionDisable();
}

class GetQuestion implements FindQuestionListFactory {
  QuestionDatabaseFactory questionDatabase;

  GetQuestion(this.questionDatabase);
  @override
  Future<List<Question>?> listQuestionByIdQuiz(int idQuiz) async {
    return await questionDatabase.getQuestionByIdQuiz(idQuiz);
  }

  @override
  Future<List<Question>?> findQuestionDisable() async {
    return await questionDatabase.findQuestionDisable();
  }
}
