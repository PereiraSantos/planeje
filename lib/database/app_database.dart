import 'dart:async';
import 'package:floor/floor.dart';
import 'package:planeje/quiz_revision/datasource/database/question_dao/question_dao.dart';
import 'package:planeje/quiz_revision/datasource/database/quiz_dao/quiz_dao.dart';

// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import '../annotation/datasource/database/dao/annotation_dao.dart';
import '../annotation/entities/annotation.dart';
import '../quiz_revision/entities/question.dart';
import '../quiz_revision/entities/quiz.dart';
import '../revision/datasource/database/date_revisiom_dao/date_revision_dao.dart';
import '../revision/datasource/database/revision_dao/revision_dao.dart';
import '../revision/entities/date_revision.dart';
import '../revision/entities/revision.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Revision, DateRevision, Annotation, Quiz, Question])
abstract class AppDatabase extends FloorDatabase {
  RevisionDao get revisionDao;
  DateRevisionDao get dateRevisionDao;
  AnnotationDao get annotationDao;
  QuizDao get quizDao;
  QuestionDao get questionDao;
}
