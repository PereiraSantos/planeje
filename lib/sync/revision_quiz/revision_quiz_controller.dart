import 'package:planeje/quiz_revision/datasource/database/revision_quiz_database.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';
import 'package:planeje/quiz_revision/utils/revision_quiz/register_revision_quiz.dart';
import 'package:planeje/quiz_revision/utils/revision_quiz/revision_quiz.dart';
import 'package:planeje/sync/list_info.dart';

class RevisionQuizController {
  List<ListInfo> revisionQuizInfos = [];

  Future<bool> writeRevisionQuiz() async {
    List<ListInfo> listInfoUpdate = [...revisionQuizInfos.where((item) => item.update)];

    revisionQuizInfos.removeWhere((item) => item.update);

    if (listInfoUpdate.isNotEmpty) {
      await UpdateRevisionQuiz(
        RevisionQuizDatabase(),
        revisionQuizs: listInfoUpdate.map<RevisionQuiz>((e) => e.lists).toList(),
      ).writeRevisionQuizList();
    }

    if (revisionQuizInfos.isNotEmpty) {
      await RegisterRevisionQuiz(
        RevisionQuizDatabase(),
        revisionQuizs: revisionQuizInfos.map<RevisionQuiz>((e) => e.lists).toList(),
      ).writeRevisionQuizList();
    }

    return true;
  }

  Future<RevisionQuiz?> findRevisionQuizByIdExternal(int idExternal) async {
    return await GetRevisionQuiz(RevisionQuizDatabase()).findRevisionQuizByIdExternal(idExternal);
  }
}
