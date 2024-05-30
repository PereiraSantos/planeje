import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/utils/register_question/question_list.dart';

abstract class DeleteQuestion {
  Future<void> delete(List<QuestionList> questionList);
}

class RemoveQuestion implements DeleteQuestion {
  DatasourceQuestionRepository datasourceQuestion;

  RemoveQuestion(this.datasourceQuestion);

  @override
  Future<bool> delete(List<QuestionList> questionList) async {
    for (var item in questionList) {
      if (item.delete) await datasourceQuestion.deleteQuestion(item.question!.id!);
    }
    return true;
  }
}
