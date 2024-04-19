import '../../entities/question.dart';

abstract class DatasourceQuestionRepository {
  Future<List<Question>?> getAllQuestion();
  Future<List<int>> insertQuestionList(List<Question> question);
  Future<int> insertQuestion(Question question);
  Future<Question?> getQuestionById(int id);
  Future<void> deleteQuestion(int id);
  Future<void> deleteQuestionByIdQuiz(int idQuiz);
  Future<int> updateQuestion(Question question);
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz);
}
