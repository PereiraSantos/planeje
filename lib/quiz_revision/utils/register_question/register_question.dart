import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/utils/register_question/question_list.dart';

abstract class RegisterQuestionFactory {
  Future<bool> writeQuestion(List<QuestionList> questionList);
}

abstract class FindQuestion {
  Future<List<Question>?> getAllQuestion();
  Future<Question?> getQuestionById(int id);
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz);
}

class SaveQuestion implements RegisterQuestionFactory {
  QuestionDatabaseFactory questionDatabase;

  SaveQuestion(this.questionDatabase);

  @override
  Future<bool> writeQuestion(List<QuestionList> questionList) async {
    for (var item in questionList) {
      if (item.add) await questionDatabase.insertQuestion(item.question!);
      if (item.update) await questionDatabase.updateQuestion(item.question!);
    }
    return true;
  }
}

class GetQuestion implements FindQuestion {
  QuestionDatabaseFactory questionDatabase;

  GetQuestion(this.questionDatabase);
  @override
  Future<List<Question>?> getAllQuestion() async {
    return await questionDatabase.getAllQuestion();
  }

  @override
  Future<Question?> getQuestionById(int id) async {
    return await questionDatabase.getQuestionById(id);
  }

  @override
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz) async {
    return await questionDatabase.getQuestionByIdQuiz(idQuiz);
  }
}
