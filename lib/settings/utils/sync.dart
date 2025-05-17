import 'package:planeje/settings/utils/sync_notifier.dart';
import 'package:planeje/sync/annotation/annotation_sync.dart';
import 'package:planeje/sync/question/question_sync.dart';
import 'package:planeje/sync/quiz/quiz_aync.dart';
import 'package:planeje/sync/revision/revision_sync.dart';
import 'package:planeje/sync/revision_date/revision_date_sync.dart';
import 'package:planeje/sync/revision_quiz/revision_quiz_sync.dart';
import 'package:planeje/sync/revision_theme/revision_theme_sync.dart';

class Sync {
  final SyncNotifier syncNotifierPost = SyncNotifier();
  final SyncNotifier syncNotifierGet = SyncNotifier();

  Sync() {
    syncNotifierPost.start();
    syncNotifierGet.start();
  }

  Future<bool> receiveData() async {
    try {
      syncNotifierGet.loading();

      await Future.wait([
        RevisionSync().getRevision(),
        AnnotationSync().getAnnotation(),
        QuizAync().getQuiz(),
        QuestionSync().getQuestion(),
        RevisionDateSync().getRevisionDate(),
        RevisionQuizSync().getRevisionQuiz(),
        RevisionThemeSync().getRevisionTheme(),
      ]);
      syncNotifierGet.concluded();

      return true;
    } catch (e) {
      syncNotifierGet.erro();
      rethrow;
    }
  }

  Future<bool> postData() async {
    try {
      syncNotifierPost.loading();

      await Future.wait([
        RevisionSync().postRevision(),
        AnnotationSync().postAnnotation(),
        QuizAync().posQuiz(),
        QuestionSync().postQuestion(),
        RevisionDateSync().postRevisionDate(),
        RevisionQuizSync().postRevisionQuiz(),
        RevisionThemeSync().postRevisionTheme(),
      ]);
      syncNotifierPost.concluded();

      return true;
    } catch (e) {
      syncNotifierPost.erro();
      rethrow;
    }
  }
}
