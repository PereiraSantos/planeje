import 'package:planeje/quiz_revision/entities/question.dart';

import '../../../database/app_database.dart';

abstract class DatasourceQuestionRepository {
  Future<List<Question>?> getAllQuestion();
  Future<int> insertQuestion(Question question);
  Future<Question?> getQuestionById(int id);
  Future<void> deleteQuestion(int id);
  Future<void> deleteQuestionByIdQuiz(int idQuiz);
  Future<int> updateQuestion(Question question);
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz);
}

class QuestionDatabase implements DatasourceQuestionRepository {
  @override
  Future<void> deleteQuestion(int id) async {
    final database = await getInstance();
    return await database.questionDao.deleteQuestion(id);
  }

  @override
  Future<List<Question>?> getAllQuestion() async {
    final database = await getInstance();
    return await database.questionDao.getAllQuestion();
  }

  @override
  Future<Question?> getQuestionById(int id) async {
    final database = await getInstance();
    return await database.questionDao.getQuestionById(id);
  }

  @override
  Future<int> updateQuestion(Question question) async {
    final database = await getInstance();
    return await database.questionDao.updateQuestion(question);
  }

  @override
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz) async {
    final database = await getInstance();
    return await database.questionDao.getQuestionByIdQuiz(idQuiz);
  }

  @override
  Future<int> insertQuestion(Question question) async {
    final database = await getInstance();
    return await database.questionDao.insertQuestion(question);
  }

  @override
  Future<void> deleteQuestionByIdQuiz(int idQuiz) async {
    final database = await getInstance();
    return await database.questionDao.deleteQuestionByIdQuiz(idQuiz);
  }
}
