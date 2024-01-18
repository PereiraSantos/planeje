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

  DateRevisionDao? _dateRevisionDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `revision` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `text` TEXT, `date_criation` TEXT, `description` TEXT, `revision` TEXT, `next_revision` TEXT, `status` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `date_revision` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `revision_id` INTEGER, `date` TEXT, `status` INTEGER, `hour` INTEGER, `minute` INTEGER)');

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
  DateRevisionDao get dateRevisionDao {
    return _dateRevisionDaoInstance ??=
        _$DateRevisionDao(database, changeListener);
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
                  'text': item.text,
                  'date_criation': item.dateCriation,
                  'description': item.description,
                  'revision': item.revision,
                  'next_revision': item.nextRevision,
                  'status': item.status == null ? null : (item.status! ? 1 : 0)
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
            text: row['text'] as String?,
            dateCriation: row['date_criation'] as String?,
            description: row['description'] as String?,
            revision: row['revision'] as String?,
            nextRevision: row['next_revision'] as String?,
            status:
                row['status'] == null ? null : (row['status'] as int) != 0));
  }

  @override
  Future<Revision?> findRevisionById(int id) async {
    return _queryAdapter.query('SELECT * FROM revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            text: row['text'] as String?,
            dateCriation: row['date_criation'] as String?,
            description: row['description'] as String?,
            revision: row['revision'] as String?,
            nextRevision: row['next_revision'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<Revision?> deleteRevisionById(int id) async {
    return _queryAdapter.query('delete FROM revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            text: row['text'] as String?,
            dateCriation: row['date_criation'] as String?,
            description: row['description'] as String?,
            revision: row['revision'] as String?,
            nextRevision: row['next_revision'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<List<Revision>> findRevisionByDescription(String text) async {
    return _queryAdapter.queryList('SELECT * FROM revision WHERE text LIKE ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            text: row['text'] as String?,
            dateCriation: row['date_criation'] as String?,
            description: row['description'] as String?,
            revision: row['revision'] as String?,
            nextRevision: row['next_revision'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0),
        arguments: [text]);
  }

  @override
  Future<int?> updateRevision(
    String description,
    int id,
    bool status,
  ) async {
    return _queryAdapter.query(
        'update revision set description = ?1, status = ?3 WHERE id = ?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [description, id, status ? 1 : 0]);
  }

  @override
  Future<int> insertRevision(Revision revision) {
    return _revisionInsertionAdapter.insertAndReturnId(
        revision, OnConflictStrategy.abort);
  }
}

class _$DateRevisionDao extends DateRevisionDao {
  _$DateRevisionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _dateRevisionInsertionAdapter = InsertionAdapter(
            database,
            'date_revision',
            (DateRevision item) => <String, Object?>{
                  'id': item.id,
                  'revision_id': item.revisionId,
                  'date': item.date,
                  'status': item.status == null ? null : (item.status! ? 1 : 0),
                  'hour': item.hour,
                  'minute': item.minute
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DateRevision> _dateRevisionInsertionAdapter;

  @override
  Future<List<DateRevision>> findAllDateRevisions() async {
    return _queryAdapter.queryList('SELECT * FROM date_revision',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id'] as int?,
            revisionId: row['revision_id'] as int?,
            date: row['date'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            hour: row['hour'] as int?,
            minute: row['minute'] as int?));
  }

  @override
  Future<List<DateRevision>> findDateRevisionById(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM date_revision WHERE revision_id = ?1 order by date asc',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id'] as int?,
            revisionId: row['revision_id'] as int?,
            date: row['date'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            hour: row['hour'] as int?,
            minute: row['minute'] as int?),
        arguments: [id]);
  }

  @override
  Future<DateRevision?> findDateRevisionByIdRevision(
    int id,
    String date,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM date_revision WHERE revision_id = ?1 and date = ?2',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id'] as int?,
            revisionId: row['revision_id'] as int?,
            date: row['date'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            hour: row['hour'] as int?,
            minute: row['minute'] as int?),
        arguments: [id, date]);
  }

  @override
  Future<DateRevision?> deleteDateRevisionById(int id) async {
    return _queryAdapter.query(
        'delete FROM date_revision WHERE revision_id = ?1',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id'] as int?,
            revisionId: row['revision_id'] as int?,
            date: row['date'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            hour: row['hour'] as int?,
            minute: row['minute'] as int?),
        arguments: [id]);
  }

  @override
  Future<DateRevision?> deleteDateRevisionByIdRevision(
    int id,
    String date,
  ) async {
    return _queryAdapter.query(
        'delete FROM date_revision WHERE revision_id = ?1 and date = ?2',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id'] as int?,
            revisionId: row['revision_id'] as int?,
            date: row['date'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            hour: row['hour'] as int?,
            minute: row['minute'] as int?),
        arguments: [id, date]);
  }

  @override
  Future<DateRevision?> updateDateRevisionById(
    bool status,
    int id,
  ) async {
    return _queryAdapter.query(
        'update  date_revision set status = ?1 WHERE id = ?2',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id'] as int?,
            revisionId: row['revision_id'] as int?,
            date: row['date'] as String?,
            status: row['status'] == null ? null : (row['status'] as int) != 0,
            hour: row['hour'] as int?,
            minute: row['minute'] as int?),
        arguments: [status ? 1 : 0, id]);
  }

  @override
  Future<int> insertDateRevision(DateRevision dateRevision) {
    return _dateRevisionInsertionAdapter.insertAndReturnId(
        dateRevision, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertDateRevisionList(List<DateRevision> dateRevision) async {
    await _dateRevisionInsertionAdapter.insertList(
        dateRevision, OnConflictStrategy.abort);
  }
}
