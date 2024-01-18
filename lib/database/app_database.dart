import 'dart:async';
import 'package:floor/floor.dart';
import 'package:planeje/entities/date_revision.dart';
import 'package:planeje/entities/revision.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/date_revision_dao.dart';
import '../dao/revision_dao.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Revision, DateRevision])
abstract class AppDatabase extends FloorDatabase {
  RevisionDao get revisionDao;
  DateRevisionDao get dateRevisionDao;
}
