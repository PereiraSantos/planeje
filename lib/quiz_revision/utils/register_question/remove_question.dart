import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/utils/register_question/question_list.dart';

abstract class DeleteQuestionFactory {
  Future<void> delete(List<QuestionList> questionList);
}

class RemoveQuestion implements DeleteQuestionFactory {
  QuestionDatabaseFactory questionDatabase;

  RemoveQuestion(this.questionDatabase);

  @override
  Future<bool> delete(List<QuestionList> questionList) async {
    for (var item in questionList) {
      if (item.delete) {
        item.question?.id != null
            ? await questionDatabase.disableQuestion(item.question!.id!)
            : await questionDatabase.disableQuestionByIdQuiz(item.question!.idQuiz!);
      }
    }
    return true;
  }
}
