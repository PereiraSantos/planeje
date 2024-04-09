import 'dart:async';
import 'package:floor/floor.dart';

// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import '../annotation/datasource/database/dao/annotation_dao.dart';
import '../annotation/entities/annotation.dart';
import '../revision/datasource/database/date_revisiom_dao/date_revision_dao.dart';
import '../revision/datasource/database/revision_dao/revision_dao.dart';
import '../revision/entities/date_revision.dart';
import '../revision/entities/revision.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Revision, DateRevision, Annotation])
abstract class AppDatabase extends FloorDatabase {
  RevisionDao get revisionDao;
  DateRevisionDao get dateRevisionDao;
  AnnotationDao get annotationDao;
}
