import 'package:planeje/quiz_revision/entities/quiz.dart';
import 'package:planeje/quiz_revision/repository/quiz_repository.dart';
import '../../datasource/repository/datasource_quiz_repository.dart';

class QuizUsercase implements QuizRepository {
  final DatasourceQuizRepository _datasourceQuizRepository;

  QuizUsercase(this._datasourceQuizRepository);

  @override
  Future<Quiz?> deleteQuiz(int id) async {
    return await _datasourceQuizRepository.deleteQuiz(id);
  }

  @override
  Future<List<Quiz>?> getAllQuiz() async {
    return await _datasourceQuizRepository.getAllQuiz();
  }

  @override
  Future<Quiz?> getQuizById(int id) async {
    return await _datasourceQuizRepository.getQuizById(id);
  }

  @override
  Future<int> insertQuiz(Quiz quiz) async {
    return await _datasourceQuizRepository.insertQuiz(quiz);
  }

  @override
  Future<int> updateQuiz(Quiz quiz) async {
    return await _datasourceQuizRepository.updateQuiz(quiz);
  }
}
