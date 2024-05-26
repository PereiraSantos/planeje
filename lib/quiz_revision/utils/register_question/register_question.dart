import 'package:planeje/quiz_revision/datasource/repository/datasource_question_repository.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/utils/register_question/question_list.dart';

abstract class RegisterQuestion {
  Future<bool> writeQuestion(List<QuestionList> questionList);
}

abstract class FindQuestion {
  Future<List<Question>?> getAllQuestion();
  Future<Question?> getQuestionById(int id);
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz);
}

class SaveQuestion implements RegisterQuestion {
  DatasourceQuestionRepository datasourceQuestion;

  SaveQuestion(this.datasourceQuestion);

  @override
  Future<bool> writeQuestion(List<QuestionList> questionList) async {
    for (var item in questionList) {
      if (item.add) await datasourceQuestion.insertQuestion(item.question!);
      if (item.update) await datasourceQuestion.updateQuestion(item.question!);
    }
    return true;
  }
}

class GetQuestion implements FindQuestion {
  DatasourceQuestionRepository datasourceQuestion;

  GetQuestion(this.datasourceQuestion);
  @override
  Future<List<Question>?> getAllQuestion() async {
    return await datasourceQuestion.getAllQuestion();
  }

  @override
  Future<Question?> getQuestionById(int id) async {
    return await datasourceQuestion.getQuestionById(id);
  }

  @override
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz) async {
    return await datasourceQuestion.getQuestionByIdQuiz(idQuiz);
  }
}
