import '../../../datasource/database/question_database.dart';
import '../../../datasource/database/quiz_database.dart';

import '../../../entities/quiz.dart';
import '../../../usercase/question_usercase/question_usercase.dart';
import '../../../usercase/quiz_usercase/quiz_usercase.dart';

class ListQuizController {
  QuizUsercase quizUsercase = QuizUsercase(QuizDatabase());
  QuestionUsercase questionUsercase = QuestionUsercase(QuestionDatabase());

  Future<List<Quiz>?> getAllQuiz() async {
    return await quizUsercase.getAllQuiz();
  }

  Future<bool> onClickDelete(int id) async {
    var result = await quizUsercase.deleteQuiz(id);
    await questionUsercase.deleteQuestionByIdQuiz(id);
    if (result != null) return true;
    return false;
  }
}
