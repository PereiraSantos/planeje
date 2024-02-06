// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RevisionDao? _revisionDaoInstance;

  AnnotationDao? _annotationDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `revision` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT, `status` INTEGER, `date` TEXT, `next_date` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `annotation` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `text` TEXT, `date_text` TEXT, `id_revision` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RevisionDao get revisionDao {
    return _revisionDaoInstance ??= _$RevisionDao(database, changeListener);
  }

  @override
  AnnotationDao get annotationDao {
    return _annotationDaoInstance ??= _$AnnotationDao(database, changeListener);
  }
}

class _$RevisionDao extends RevisionDao {
  _$RevisionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _revisionInsertionAdapter = InsertionAdapter(
            database,
            'revision',
            (Revision item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'status': item.status == null ? null : (item.status! ? 1 : 0),
                  'date': item.date,
                  'next_date': item.nextDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Revision> _revisionInsertionAdapter;

  @override
  Future<List<Revision>> findAllRevisions() async {
    return _queryAdapter.queryList('SELECT * FROM revision',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            description: row['description'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            date: row['date'] as String?,
            nextDate: row['next_date'] as String?));
  }

  @override
  Future<Revision?> findRevisionById(int id) async {
    return _queryAdapter.query('SELECT * FROM revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            description: row['description'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            date: row['date'] as String?,
            nextDate: row['next_date'] as String?),
        arguments: [id]);
  }

  @override
  Future<Revision?> deleteRevisionById(int id) async {
    return _queryAdapter.query('delete FROM revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            description: row['description'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            date: row['date'] as String?,
            nextDate: row['next_date'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<Revision>> findRevisionByDescription(String text) async {
    return _queryAdapter.queryList('SELECT * FROM revision WHERE text LIKE ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            description: row['description'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            date: row['date'] as String?,
            nextDate: row['next_date'] as String?),
        arguments: [text]);
  }

  @override
  Future<int?> updateRevision(
    String description,
    String nextDate,
    int id,
    bool status,
  ) async {
    return _queryAdapter.query(
        'update revision set description = ?1, next_date = ?2,status = ?4 WHERE id = ?3',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [description, nextDate, id, status ? 1 : 0]);
  }

  @override
  Future<Revision?> getNextRevision() async {
    return _queryAdapter.query(
        'SELECT * FROM revision where status = 0 order by next_date desc limit 1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            description: row['description'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            date: row['date'] as String?,
            nextDate: row['next_date'] as String?));
  }

  @override
  Future<List<Revision>?> getDelayedRevision() async {
    return _queryAdapter.queryList('SELECT * FROM revision where status = 0',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            description: row['description'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            date: row['date'] as String?,
            nextDate: row['next_date'] as String?));
  }

  @override
  Future<List<Revision>?> getCompletedRevision() async {
    return _queryAdapter.queryList('SELECT * FROM revision where status = 1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            description: row['description'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            date: row['date'] as String?,
            nextDate: row['next_date'] as String?));
  }

  @override
  Future<int> insertRevision(Revision revision) {
    return _revisionInsertionAdapter.insertAndReturnId(
        revision, OnConflictStrategy.abort);
  }
}

class _$AnnotationDao extends AnnotationDao {
  _$AnnotationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _annotationInsertionAdapter = InsertionAdapter(
            database,
            'annotation',
            (Annotation item) => <String, Object?>{
                  'id': item.id,
                  'text': item.text,
                  'date_text': item.dateText,
                  'id_revision': item.idRevision
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Annotation> _annotationInsertionAdapter;

  @override
  Future<List<Annotation>> findAllAnnotation() async {
    return _queryAdapter.queryList('select * from annotation',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?));
  }

  @override
  Future<Annotation?> findAnnotationById(int id) async {
    return _queryAdapter.query('SELECT * FROM annotation WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<Annotation>?> findAnnotationByIdRevision(int idRevision) async {
    return _queryAdapter.queryList(
        'SELECT * FROM annotation WHERE id_revision = ?1',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [idRevision]);
  }

  @override
  Future<Annotation?> updateAnnotation(
    String text,
    int id,
  ) async {
    return _queryAdapter.query('update annotation set text = ?1 WHERE id = ?2',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [text, id]);
  }

  @override
  Future<Annotation?> updateAnnotationRevision(
    int idRevision,
    int id,
  ) async {
    return _queryAdapter.query(
        'update annotation set id_revision = ?1 WHERE id = ?2',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [idRevision, id]);
  }

  @override
  Future<Annotation?> updateAnnotationData(
    String data,
    int id,
  ) async {
    return _queryAdapter.query(
        'update annotation set date_text = ?1 WHERE id = ?2',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [data, id]);
  }

  @override
  Future<Annotation?> updateAnnotationTime(
    String time,
    int id,
  ) async {
    return _queryAdapter.query('update annotation set text = ?1 WHERE id = ?2',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [time, id]);
  }

  @override
  Future<Annotation?> delete(int id) async {
    return _queryAdapter.query('delete from annotation where id = ?1',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [id]);
  }

  @override
  Future<int> insertAnnotation(Annotation annotationEntity) {
    return _annotationInsertionAdapter.insertAndReturnId(
        annotationEntity, OnConflictStrategy.abort);
  }
}
