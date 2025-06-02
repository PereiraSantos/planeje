import 'package:planeje/quiz_revision/datasource/database/revision_quiz_database.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';
import 'package:planeje/quiz_revision/utils/revision_quiz/delete_revision_quiz.dart';
import 'package:planeje/quiz_revision/utils/revision_quiz/register_revision_quiz.dart';

class RevisionQuizController {
  List<RevisionQuiz> revisionQuizs = [];

  Future<bool> writeRevisionQuiz() async {
    if (revisionQuizs.isNotEmpty) await RegisterRevisionQuiz(RevisionQuizDatabase(), revisionQuizs: revisionQuizs).writeRevisionQuizList();

    return true;
  }

  Future<void> deteleTable() async => await DeleteRevisionQuiz(RevisionQuizDatabase()).deleteTable();
}
