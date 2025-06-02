import 'package:planeje/quiz_revision/entities/question.dart';

import '../../../database/app_database.dart';

abstract class QuestionDatabaseFactory {
  Future<List<Question>?> getAllQuestion();
  Future<List<Question>?> findAllQuestionSync();
  Future<int> insertQuestion(Question question);
  Future<List<int>> insertQuestionList(List<Question> questions);
  Future<Question?> getQuestionById(int id);
  Future<void> disableQuestion(int id);
  Future<void> disableQuestionByIdQuiz(int idQuiz);
  Future<int> updateQuestion(Question question);
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz);
  Future<void> updateQuestionList(List<Question> question);
  Future<List<Question>?> findQuestionDisable();
  Future<void> deleteTable();
}

class QuestionDatabase implements QuestionDatabaseFactory {
  @override
  Future<void> disableQuestion(int id) async {
    final database = await getInstance();
    return await database.questionDao.disableQuestion(id);
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
  Future<void> disableQuestionByIdQuiz(int idQuiz) async {
    final database = await getInstance();
    return await database.questionDao.disableQuestionByIdQuiz(idQuiz);
  }

  @override
  Future<List<int>> insertQuestionList(List<Question> questions) async {
    final database = await getInstance();
    return await database.questionDao.insertQuestionList(questions);
  }

  @override
  Future<List<Question>?> findAllQuestionSync() async {
    final database = await getInstance();
    return await database.questionDao.findAllQuestionSync();
  }

  @override
  Future<void> updateQuestionList(List<Question> question) async {
    final database = await getInstance();
    return await database.questionDao.updateQuestionList(question);
  }

  @override
  Future<List<Question>?> findQuestionDisable() async {
    final database = await getInstance();
    return await database.questionDao.findQuestionDisable();
  }

  @override
  Future<void> deleteTable() async {
    final database = await getInstance();
    return await database.questionDao.deleteTable();
  }
}
