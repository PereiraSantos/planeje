import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';

import 'package:planeje/revision/entities/date_revision.dart';

abstract class DateFactory {
  Future<int?> writeDateRevision();
  late DateRevision date;
}

class RegisterDateRevision implements DateFactory {
  DateRevisionDatabaseFactory dateRevisionDatabase;

  RegisterDateRevision(this.dateRevisionDatabase, this.date);

  @override
  Future<int?> writeDateRevision() async {
    return await dateRevisionDatabase.insertDateRevision(date);
  }

  @override
  DateRevision date;
}

class UpdateDateRevision implements DateFactory {
  DateRevisionDatabaseFactory dateRevisionDatabase;

  UpdateDateRevision(this.dateRevisionDatabase, this.date);

  @override
  Future<int?> writeDateRevision() async {
    return await dateRevisionDatabase.updateDateRevision(date);
  }

  @override
  DateRevision date;
}
