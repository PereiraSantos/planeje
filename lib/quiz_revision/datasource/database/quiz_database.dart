import 'package:planeje/quiz_revision/entities/quiz.dart';

import '../../../database/app_database.dart';
import '../repository/datasource_quiz_repository.dart';

class QuizDatabase implements DatasourceQuizRepository {
  Future<AppDatabase> getInstance() async {
    return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  @override
  Future<Quiz?> deleteQuiz(int id) async {
    final database = await getInstance();
    return await database.quizDao.deleteQuiz(id);
  }

  @override
  Future<List<Quiz>?> getAllQuiz() async {
    final database = await getInstance();
    return await database.quizDao.getAllQuiz();
  }

  @override
  Future<Quiz?> getQuizById(int id) async {
    final database = await getInstance();
    return await database.quizDao.getQuizById(id);
  }

  @override
  Future<int> insertQuiz(Quiz quiz) async {
    final database = await getInstance();
    return await database.quizDao.insertQuiz(quiz);
  }

  @override
  Future<int> updateQuiz(Quiz quiz) async {
    final database = await getInstance();
    return await database.quizDao.updateQuiz(quiz);
  }
}
