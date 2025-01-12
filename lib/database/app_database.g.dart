// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
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

  AnnotationDao? _annotationDaoInstance;

  QuizDao? _quizDaoInstance;

  QuestionDao? _questionDaoInstance;

  SettingDao? _settingDaoInstance;

  UserDao? _userDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `revision` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `description` TEXT, `date_creational` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `date_revision` (`id_date` INTEGER PRIMARY KEY AUTOINCREMENT, `date_revision` TEXT, `id_revision` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `annotation` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `text` TEXT, `date_text` TEXT, `id_revision` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `quiz` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `topic` TEXT, `description` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `question` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `id_quiz` INTEGER, `description` TEXT, `answer` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `setting` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `keystone` TEXT, `value` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`login` TEXT NOT NULL, `password` TEXT NOT NULL, PRIMARY KEY (`login`))');

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

  @override
  AnnotationDao get annotationDao {
    return _annotationDaoInstance ??= _$AnnotationDao(database, changeListener);
  }

  @override
  QuizDao get quizDao {
    return _quizDaoInstance ??= _$QuizDao(database, changeListener);
  }

  @override
  QuestionDao get questionDao {
    return _questionDaoInstance ??= _$QuestionDao(database, changeListener);
  }

  @override
  SettingDao get settingDao {
    return _settingDaoInstance ??= _$SettingDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
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
                  'title': item.title,
                  'description': item.description,
                  'date_creational': item.dateCreational
                }),
        _revisionUpdateAdapter = UpdateAdapter(
            database,
            'revision',
            ['id'],
            (Revision item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'date_creational': item.dateCreational
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Revision> _revisionInsertionAdapter;

  final UpdateAdapter<Revision> _revisionUpdateAdapter;

  @override
  Future<List<Revision>> findAllRevisions() async {
    return _queryAdapter.queryList('SELECT * FROM revision',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?));
  }

  @override
  Future<Revision?> findRevisionById(int id) async {
    return _queryAdapter.query('SELECT * FROM revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?),
        arguments: [id]);
  }

  @override
  Future<Revision?> deleteRevisionById(int id) async {
    return _queryAdapter.query('delete FROM revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<Revision>> findRevisionByDescription(String text) async {
    return _queryAdapter.queryList('SELECT * FROM revision WHERE text LIKE ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?),
        arguments: [text]);
  }

  @override
  Future<int> insertRevision(Revision revision) {
    return _revisionInsertionAdapter.insertAndReturnId(
        revision, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateRevision(Revision revision) {
    return _revisionUpdateAdapter.updateAndReturnChangedRows(
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
                  'id_date': item.id,
                  'date_revision': item.dateRevision,
                  'id_revision': item.idRevision
                }),
        _dateRevisionUpdateAdapter = UpdateAdapter(
            database,
            'date_revision',
            ['id_date'],
            (DateRevision item) => <String, Object?>{
                  'id_date': item.id,
                  'date_revision': item.dateRevision,
                  'id_revision': item.idRevision
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DateRevision> _dateRevisionInsertionAdapter;

  final UpdateAdapter<DateRevision> _dateRevisionUpdateAdapter;

  @override
  Future<List<DateRevision>> findAllRevisions() async {
    return _queryAdapter.queryList('SELECT * FROM date_revision',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            idRevision: row['id_revision'] as int?));
  }

  @override
  Future<DateRevision?> deleteDateRevisionById(int id) async {
    return _queryAdapter.query('delete FROM date_revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [id]);
  }

  @override
  Future<DateRevision?> deleteDateRevisionByIdRevision(int idRevision) async {
    return _queryAdapter.query(
        'delete FROM date_revision WHERE id_revision = ?1',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [idRevision]);
  }

  @override
  Future<void> updateHourInitRevision(
    String hourInit,
    int id,
  ) async {
    await _queryAdapter.queryNoReturn(
        'update date_revision set hour_init = ?1 where id_date = ?2',
        arguments: [hourInit, id]);
  }

  @override
  Future<void> updateHourEndRevision(
    String hourEnd,
    String dateRevision,
    String nextDateRevision,
    int id,
  ) async {
    await _queryAdapter.queryNoReturn(
        'update date_revision set date_revision = ?2, next_date_revision = ?3, hour_end = ?1 where id_date = ?4',
        arguments: [hourEnd, dateRevision, nextDateRevision, id]);
  }

  @override
  Future<void> updateStatus(
    bool status,
    int id,
  ) async {
    await _queryAdapter.queryNoReturn(
        'update date_revision set status = ?1 where id_date = ?2',
        arguments: [status ? 1 : 0, id]);
  }

  @override
  Future<DateRevision?> findDateRevisionById(int id) async {
    return _queryAdapter.query(
        'select * from date_revision  where id_date  = ?1',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [id]);
  }

  @override
  Future<int> insertDateRevision(DateRevision dateRevision) {
    return _dateRevisionInsertionAdapter.insertAndReturnId(
        dateRevision, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateDateRevision(DateRevision dateRevision) {
    return _dateRevisionUpdateAdapter.updateAndReturnChangedRows(
        dateRevision, OnConflictStrategy.abort);
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
                  'title': item.title,
                  'text': item.text,
                  'date_text': item.dateText,
                  'id_revision': item.idRevision
                }),
        _annotationUpdateAdapter = UpdateAdapter(
            database,
            'annotation',
            ['id'],
            (Annotation item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'text': item.text,
                  'date_text': item.dateText,
                  'id_revision': item.idRevision
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Annotation> _annotationInsertionAdapter;

  final UpdateAdapter<Annotation> _annotationUpdateAdapter;

  @override
  Future<void> delete(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from annotation where id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteByIdRevision(int idRevision) async {
    await _queryAdapter.queryNoReturn(
        'delete from annotation where id_revision = ?1',
        arguments: [idRevision]);
  }

  @override
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision) async {
    return _queryAdapter.queryList(
        'select * from  annotation where id_revision = ?1',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            title: row['title'] as String?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [idRevision]);
  }

  @override
  Future<int> insertAnnotation(Annotation annotationEntity) {
    return _annotationInsertionAdapter.insertAndReturnId(
        annotationEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateAnnotation(Annotation annotationEntity) {
    return _annotationUpdateAdapter.updateAndReturnChangedRows(
        annotationEntity, OnConflictStrategy.abort);
  }
}

class _$QuizDao extends QuizDao {
  _$QuizDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _quizInsertionAdapter = InsertionAdapter(
            database,
            'quiz',
            (Quiz item) => <String, Object?>{
                  'id': item.id,
                  'topic': item.topic,
                  'description': item.description
                }),
        _quizUpdateAdapter = UpdateAdapter(
            database,
            'quiz',
            ['id'],
            (Quiz item) => <String, Object?>{
                  'id': item.id,
                  'topic': item.topic,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Quiz> _quizInsertionAdapter;

  final UpdateAdapter<Quiz> _quizUpdateAdapter;

  @override
  Future<List<Quiz>?> getAllQuiz() async {
    return _queryAdapter.queryList('SELECT * FROM quiz',
        mapper: (Map<String, Object?> row) => Quiz(
            id: row['id'] as int?,
            topic: row['topic'] as String?,
            description: row['description'] as String?));
  }

  @override
  Future<List<Quiz>?> getAllQuizSearch(String text) async {
    return _queryAdapter.queryList('SELECT * FROM quiz where topic LIKE ?1',
        mapper: (Map<String, Object?> row) => Quiz(
            id: row['id'] as int?,
            topic: row['topic'] as String?,
            description: row['description'] as String?),
        arguments: [text]);
  }

  @override
  Future<Quiz?> getQuizById(int id) async {
    return _queryAdapter.query('SELECT * FROM quiz WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Quiz(
            id: row['id'] as int?,
            topic: row['topic'] as String?,
            description: row['description'] as String?),
        arguments: [id]);
  }

  @override
  Future<Quiz?> deleteQuiz(int id) async {
    return _queryAdapter.query('delete FROM quiz WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Quiz(
            id: row['id'] as int?,
            topic: row['topic'] as String?,
            description: row['description'] as String?),
        arguments: [id]);
  }

  @override
  Future<int> insertQuiz(Quiz quiz) {
    return _quizInsertionAdapter.insertAndReturnId(
        quiz, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateQuiz(Quiz quiz) {
    return _quizUpdateAdapter.updateAndReturnChangedRows(
        quiz, OnConflictStrategy.abort);
  }
}

class _$QuestionDao extends QuestionDao {
  _$QuestionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _questionInsertionAdapter = InsertionAdapter(
            database,
            'question',
            (Question item) => <String, Object?>{
                  'id': item.id,
                  'id_quiz': item.idQuiz,
                  'description': item.description,
                  'answer': item.answer == null ? null : (item.answer! ? 1 : 0)
                }),
        _questionUpdateAdapter = UpdateAdapter(
            database,
            'question',
            ['id'],
            (Question item) => <String, Object?>{
                  'id': item.id,
                  'id_quiz': item.idQuiz,
                  'description': item.description,
                  'answer': item.answer == null ? null : (item.answer! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Question> _questionInsertionAdapter;

  final UpdateAdapter<Question> _questionUpdateAdapter;

  @override
  Future<List<Question>?> getAllQuestion() async {
    return _queryAdapter.queryList('SELECT * FROM question',
        mapper: (Map<String, Object?> row) => Question(
            id: row['id'] as int?,
            idQuiz: row['id_quiz'] as int?,
            description: row['description'] as String?,
            answer:
                row['answer'] == null ? null : (row['answer'] as int) != 0));
  }

  @override
  Future<Question?> getQuestionById(int id) async {
    return _queryAdapter.query('SELECT * FROM question WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Question(
            id: row['id'] as int?,
            idQuiz: row['id_quiz'] as int?,
            description: row['description'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz) async {
    return _queryAdapter.queryList('SELECT * FROM question WHERE id_quiz = ?1',
        mapper: (Map<String, Object?> row) => Question(
            id: row['id'] as int?,
            idQuiz: row['id_quiz'] as int?,
            description: row['description'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0),
        arguments: [idQuiz]);
  }

  @override
  Future<void> deleteQuestion(int id) async {
    await _queryAdapter
        .queryNoReturn('delete FROM question WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteQuestionByIdQuiz(int idQuiz) async {
    await _queryAdapter.queryNoReturn('delete FROM question WHERE id_quiz = ?1',
        arguments: [idQuiz]);
  }

  @override
  Future<int> insertQuestion(Question question) {
    return _questionInsertionAdapter.insertAndReturnId(
        question, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateQuestion(Question question) {
    return _questionUpdateAdapter.updateAndReturnChangedRows(
        question, OnConflictStrategy.abort);
  }
}

class _$SettingDao extends SettingDao {
  _$SettingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _settingsInsertionAdapter = InsertionAdapter(
            database,
            'setting',
            (Settings item) => <String, Object?>{
                  'id': item.id,
                  'keystone': item.key,
                  'value': item.value
                }),
        _settingsUpdateAdapter = UpdateAdapter(
            database,
            'setting',
            ['id'],
            (Settings item) => <String, Object?>{
                  'id': item.id,
                  'keystone': item.key,
                  'value': item.value
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Settings> _settingsInsertionAdapter;

  final UpdateAdapter<Settings> _settingsUpdateAdapter;

  @override
  Future<Settings?> findSettingByKey(String key) async {
    return _queryAdapter.query('select * from setting where keystone = ?1',
        mapper: (Map<String, Object?> row) => Settings(
            id: row['id'] as int?,
            key: row['keystone'] as String?,
            value: row['value'] as String?),
        arguments: [key]);
  }

  @override
  Future<int> insertSetting(Settings settings) {
    return _settingsInsertionAdapter.insertAndReturnId(
        settings, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateSetting(Settings settings) {
    return _settingsUpdateAdapter.updateAndReturnChangedRows(
        settings, OnConflictStrategy.abort);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (User item) => <String, Object?>{
                  'login': item.login,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  @override
  Future<User?> findUserLoginPassword(
    String login,
    String password,
  ) async {
    return _queryAdapter.query(
        'select * from user where login = ?1 and password = ?2',
        mapper: (Map<String, Object?> row) =>
            User(row['login'] as String, row['password'] as String),
        arguments: [login, password]);
  }

  @override
  Future<int?> haveRegistration() async {
    return _queryAdapter.query('select count(login) from user',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }
}
