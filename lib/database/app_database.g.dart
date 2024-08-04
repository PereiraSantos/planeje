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

  AnnotationDao? _annotationDaoInstance;

  QuizDao? _quizDaoInstance;

  QuestionDao? _questionDaoInstance;

  LearnDao? _learnDaoInstance;

  CategoryDao? _categoryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `revision` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT, `date_creational` TEXT, `id_learn` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `date_revision` (`id_date` INTEGER PRIMARY KEY AUTOINCREMENT, `date_revision` TEXT, `next_date_revision` TEXT, `hour_init` TEXT, `hour_end` TEXT, `id_revision` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `annotation` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `text` TEXT, `date_text` TEXT, `id_revision` INTEGER, `id_category` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `quiz` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `topic` TEXT, `description` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `question` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `id_quiz` INTEGER, `description` TEXT, `answer` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `learn` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT)');

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
  LearnDao get learnDao {
    return _learnDaoInstance ??= _$LearnDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
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
                  'date_creational': item.dateCreational,
                  'id_learn': item.idLearn
                }),
        _revisionUpdateAdapter = UpdateAdapter(
            database,
            'revision',
            ['id'],
            (Revision item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'date_creational': item.dateCreational,
                  'id_learn': item.idLearn
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
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?,
            idLearn: row['id_learn'] as int?));
  }

  @override
  Future<Revision?> findRevisionById(int id) async {
    return _queryAdapter.query('SELECT * FROM revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?,
            idLearn: row['id_learn'] as int?),
        arguments: [id]);
  }

  @override
  Future<Revision?> deleteRevisionById(int id) async {
    return _queryAdapter.query('delete FROM revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?,
            idLearn: row['id_learn'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<Revision>> findRevisionByDescription(String text) async {
    return _queryAdapter.queryList('SELECT * FROM revision WHERE text LIKE ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?,
            idLearn: row['id_learn'] as int?),
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
                  'next_date_revision': item.nextDate,
                  'hour_init': item.hourInit,
                  'hour_end': item.hourEnd,
                  'id_revision': item.idRevision
                }),
        _dateRevisionUpdateAdapter = UpdateAdapter(
            database,
            'date_revision',
            ['id_date'],
            (DateRevision item) => <String, Object?>{
                  'id_date': item.id,
                  'date_revision': item.dateRevision,
                  'next_date_revision': item.nextDate,
                  'hour_init': item.hourInit,
                  'hour_end': item.hourEnd,
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
            nextDate: row['next_date_revision'] as String?,
            hourInit: row['hour_init'] as String?,
            hourEnd: row['hour_end'] as String?,
            idRevision: row['id_revision'] as int?));
  }

  @override
  Future<DateRevision?> findDateRevisionById(int id) async {
    return _queryAdapter.query('SELECT * FROM date_revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            nextDate: row['next_date_revision'] as String?,
            hourInit: row['hour_init'] as String?,
            hourEnd: row['hour_end'] as String?,
            idRevision: row['id_revision'] as int?),
        arguments: [id]);
  }

  @override
  Future<DateRevision?> deleteDateRevisionById(int id) async {
    return _queryAdapter.query('delete FROM date_revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            nextDate: row['next_date_revision'] as String?,
            hourInit: row['hour_init'] as String?,
            hourEnd: row['hour_end'] as String?,
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
                  'id_revision': item.idRevision,
                  'id_category': item.idCategory
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
                  'id_revision': item.idRevision,
                  'id_category': item.idCategory
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Annotation> _annotationInsertionAdapter;

  final UpdateAdapter<Annotation> _annotationUpdateAdapter;

  @override
  Future<Annotation?> delete(int id) async {
    return _queryAdapter.query('delete from annotation where id = ?1',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            title: row['title'] as String?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?,
            idCategory: row['id_category'] as int?),
        arguments: [id]);
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
            idRevision: row['id_revision'] as int?,
            idCategory: row['id_category'] as int?),
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

class _$LearnDao extends LearnDao {
  _$LearnDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _learnInsertionAdapter = InsertionAdapter(
            database,
            'learn',
            (Learn item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description
                }),
        _learnUpdateAdapter = UpdateAdapter(
            database,
            'learn',
            ['id'],
            (Learn item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Learn> _learnInsertionAdapter;

  final UpdateAdapter<Learn> _learnUpdateAdapter;

  @override
  Future<List<Learn>?> getAllLearn() async {
    return _queryAdapter.queryList('SELECT * FROM learn',
        mapper: (Map<String, Object?> row) => Learn(
            id: row['id'] as int?, description: row['description'] as String?));
  }

  @override
  Future<List<Learn>?> getLearn(String text) async {
    return _queryAdapter.queryList(
        'SELECT * FROM learn where description LIKE ?1',
        mapper: (Map<String, Object?> row) => Learn(
            id: row['id'] as int?, description: row['description'] as String?),
        arguments: [text]);
  }

  @override
  Future<Learn?> getLearnId(int id) async {
    return _queryAdapter.query('SELECT * FROM learn WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Learn(
            id: row['id'] as int?, description: row['description'] as String?),
        arguments: [id]);
  }

  @override
  Future<Learn?> deleteLearnById(int id) async {
    return _queryAdapter.query('delete FROM learn WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Learn(
            id: row['id'] as int?, description: row['description'] as String?),
        arguments: [id]);
  }

  @override
  Future<int> insertLearn(Learn learn) {
    return _learnInsertionAdapter.insertAndReturnId(
        learn, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateLearn(Learn learn) {
    return _learnUpdateAdapter.updateAndReturnChangedRows(
        learn, OnConflictStrategy.abort);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'category',
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description
                }),
        _categoryUpdateAdapter = UpdateAdapter(
            database,
            'category',
            ['id'],
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  final UpdateAdapter<Category> _categoryUpdateAdapter;

  @override
  Future<List<Category>?> getAllCategory() async {
    return _queryAdapter.queryList('SELECT * FROM category',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?, description: row['description'] as String?));
  }

  @override
  Future<List<Category>?> getCategory(String text) async {
    return _queryAdapter.queryList(
        'SELECT * FROM category where description LIKE ?1',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?, description: row['description'] as String?),
        arguments: [text]);
  }

  @override
  Future<Category?> getCategoryId(int id) async {
    return _queryAdapter.query('SELECT * FROM category WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?, description: row['description'] as String?),
        arguments: [id]);
  }

  @override
  Future<Category?> deleteCategoryById(int id) async {
    return _queryAdapter.query('delete FROM category WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?, description: row['description'] as String?),
        arguments: [id]);
  }

  @override
  Future<int> insertCategory(Category category) {
    return _categoryInsertionAdapter.insertAndReturnId(
        category, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateCategory(Category category) {
    return _categoryUpdateAdapter.updateAndReturnChangedRows(
        category, OnConflictStrategy.abort);
  }
}
