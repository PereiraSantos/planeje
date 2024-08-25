import 'dart:async';
import 'package:floor/floor.dart';
import 'package:planeje/annotation/datasource/dao/annotation_dao.dart';
import 'package:planeje/category/datasource/dao/category_dao.dart';
import 'package:planeje/category/entities/category.dart';
import 'package:planeje/learn/datasource/dao/learn_dao.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/quiz_revision/datasource/dao/question_dao.dart';
import 'package:planeje/quiz_revision/datasource/dao/quiz_dao.dart';
import 'package:planeje/revision/datasource/dao/date_revision_dao.dart';
import 'package:planeje/revision/datasource/dao/revision_dao.dart';
import 'package:planeje/utils/cache/cache.dart';
import 'package:planeje/utils/cache/cache_dao.dart';

// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import '../annotation/entities/annotation.dart';
import '../quiz_revision/entities/question.dart';
import '../quiz_revision/entities/quiz.dart';

import '../revision/entities/date_revision.dart';
import '../revision/entities/revision.dart';

part 'app_database.g.dart';

@Database(version: 2, entities: [
  Revision,
  DateRevision,
  Annotation,
  Quiz,
  Question,
  Learn,
  Category,
  Cache,
])
abstract class AppDatabase extends FloorDatabase {
  RevisionDao get revisionDao;
  DateRevisionDao get dateRevisionDao;
  AnnotationDao get annotationDao;
  QuizDao get quizDao;
  QuestionDao get questionDao;
  LearnDao get learnDao;
  CategoryDao get categoryDao;
  CacheDao get cacheDao;
}

final migration1to2 = Migration(1, 2, (database) async {
  await database.execute(
      'CREATE TABLE IF NOT EXISTS `category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT)');
  await database.execute('ALTER TABLE annotation ADD COLUMN id_category INTEGER');
});

final migration2to3 = Migration(2, 3, (database) async {
  await database.execute('CREATE TABLE IF NOT EXISTS `cache` (`id` INTEGER PRIMARY KEY, `hash` TEXT)');
});

final migration3to4 = Migration(3, 4, (database) async {
  await database.execute('ALTER TABLE date_revision ADD status INTEGER)');
});

Future<AppDatabase> getInstance() async {
  return await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .addMigrations([migration1to2, migration2to3, migration3to4]).build();
}
