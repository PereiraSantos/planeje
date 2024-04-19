import '../entities/quiz.dart';

abstract class QuizRepository {
  Future<List<Quiz>?> getAllQuiz();
  Future<int> insertQuiz(Quiz quiz);
  Future<Quiz?> getQuizById(int id);
  Future<void> deleteQuiz(int id);
  Future<int> updateQuiz(Quiz quiz);
}
