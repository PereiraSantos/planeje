import 'package:planeje/quiz_revision/datasource/database/revision_quiz_database.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';

abstract class RegisterRevisionQuizFactory {
  Future<int?> writeRevisionQuiz();
  Future<void> writeRevisionQuizList();
  List<RevisionQuiz>? revisionQuizs;
  RevisionQuiz? revisionQuiz;
}

class RegisterRevisionQuiz implements RegisterRevisionQuizFactory {
  RevisionQuizDatabaseFactory revisionQuizDatabaseFactory;

  RegisterRevisionQuiz(this.revisionQuizDatabaseFactory, {this.revisionQuiz, this.revisionQuizs});

  @override
  List<RevisionQuiz>? revisionQuizs;

  @override
  Future<void> writeRevisionQuizList() async {
    if (revisionQuizs == null) throw ('Teve passar a uma lista de revisionQuizs');
    return await revisionQuizDatabaseFactory.insertRevisionQuizList(revisionQuizs!);
  }

  @override
  RevisionQuiz? revisionQuiz;

  @override
  Future<int?> writeRevisionQuiz() async {
    if (revisionQuiz == null) throw ('Teve passar um objeto revisionQuiz');
    return await revisionQuizDatabaseFactory.insertRevisionQuiz(revisionQuiz!);
  }
}

class UpdateRevisionQuiz implements RegisterRevisionQuizFactory {
  RevisionQuizDatabaseFactory revisionQuizDatabaseFactory;

  UpdateRevisionQuiz(this.revisionQuizDatabaseFactory, {this.revisionQuiz, this.revisionQuizs});

  @override
  List<RevisionQuiz>? revisionQuizs;

  @override
  Future<void> writeRevisionQuizList() async {
    if (revisionQuizs == null) throw ('Teve passar a uma lista de revisionQuizs');
    return await revisionQuizDatabaseFactory.updateRevisionQuizList(revisionQuizs!);
  }

  @override
  RevisionQuiz? revisionQuiz;

  @override
  Future<int?> writeRevisionQuiz() async {
    if (revisionQuiz == null) throw ('Teve passar um objeto revisionQuiz');
    return await revisionQuizDatabaseFactory.updateRevisionQuiz(revisionQuiz!);
  }
}
