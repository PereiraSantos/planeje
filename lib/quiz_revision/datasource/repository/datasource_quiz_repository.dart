import '../../entities/quiz.dart';

abstract class DatasourceQuizRepository {
  Future<List<Quiz>?> getAllQuiz();
  Future<int> insertQuiz(Quiz quiz);
  Future<Quiz?> getQuizById(int id);
  Future<Quiz?> deleteQuiz(int id);
  Future<int> updateQuiz(Quiz quiz);
}
