import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/utils/register_question/register_question.dart';
import 'package:planeje/sync/list_info.dart';

class QuestionController {
  List<ListInfo> annotationInfos = [];

  Future<bool> writeRevision() async {
    List<ListInfo> listInfoUpdate = [...annotationInfos.where((item) => item.update)];

    annotationInfos.removeWhere((item) => item.update);

    if (listInfoUpdate.isNotEmpty) {
      await UpdateQuestion(QuestionDatabase(), questions: listInfoUpdate.map<Question>((e) => e.lists).toList()).writeQuestionList();
    }

    if (annotationInfos.isNotEmpty) {
      await SaveQuestion(QuestionDatabase(), questions: annotationInfos.map<Question>((e) => e.lists).toList()).writeQuestionList();
    }

    return true;
  }

  Future<Question?> findQuestionByIdExternal(int idExternal) async {
    return await GetQuestion(QuestionDatabase()).findQuestionByIdExternal(idExternal);
  }
}
