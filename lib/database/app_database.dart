import 'dart:async';
import 'package:floor/floor.dart';
import 'package:planeje/annotation/datasource/dao/annotation_dao.dart';
import 'package:planeje/learn/datasource/dao/learn_dao.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/quiz_revision/datasource/dao/question_dao.dart';
import 'package:planeje/quiz_revision/datasource/dao/quiz_dao.dart';
import 'package:planeje/revision/datasource/dao/date_revision_dao.dart';
import 'package:planeje/revision/datasource/dao/revision_dao.dart';
import 'package:planeje/settings/datasource/dao/setting_dao.dart';
import 'package:planeje/suggestion/datasource/dao/suggestion_dao.dart';
import 'package:planeje/suggestion/entities/suggestion.dart';
import 'package:planeje/utils/cache/cache.dart';
import 'package:planeje/utils/cache/cache_dao.dart';

// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import '../annotation/entities/annotation.dart';
import '../quiz_revision/entities/question.dart';
import '../quiz_revision/entities/quiz.dart';

import '../revision/entities/date_revision.dart';
import '../revision/entities/revision.dart';
import '../settings/entities/settings.dart';

part 'app_database.g.dart';

final migration1to2 = Migration(1, 2, (database) async {
  await database.execute(
      'CREATE TABLE IF NOT EXISTS `category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT)');
  await database.execute('ALTER TABLE annotation ADD COLUMN id_category INTEGER');
});

final migration2to3 = Migration(2, 3, (database) async {
  await database.execute('CREATE TABLE IF NOT EXISTS `cache` (`id` INTEGER PRIMARY KEY, `hash` TEXT)');
});

final migration3to4 = Migration(3, 4, (database) async {
  await database.execute('ALTER TABLE date_revision ADD status INTEGER');
  await database.execute('ALTER TABLE date_revision ADD day INTEGER');
});

final migration4to5 = Migration(4, 5, (database) async {
  await database.execute(
      'CREATE TABLE IF NOT EXISTS `setting` (`id` INTEGER PRIMARY KEY, `keystone` TEXT, `value` TEXT)');
});

final migration5to6 = Migration(5, 6, (database) async {
  await database.execute(
      'CREATE TABLE IF NOT EXISTS `suggestion` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT, `id_learn` INTEGER,  `sortition` INTEGER)');
});

@Database(version: 6, entities: [
  Revision,
  DateRevision,
  Annotation,
  Quiz,
  Question,
  Learn,
  Cache,
  Settings,
  Suggestion,
])
abstract class AppDatabase extends FloorDatabase {
  RevisionDao get revisionDao;
  DateRevisionDao get dateRevisionDao;
  AnnotationDao get annotationDao;
  QuizDao get quizDao;
  QuestionDao get questionDao;
  LearnDao get learnDao;
  CacheDao get cacheDao;
  SettingDao get settingDao;
  SuggestionDao get suggestionDao;
}

Future<AppDatabase> getInstance() async {
  return await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .addMigrations([migration1to2, migration2to3, migration3to4, migration4to5, migration5to6]).build();
}
