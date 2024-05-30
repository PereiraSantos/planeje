import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';

import 'package:planeje/revision/entities/date_revision.dart';

abstract class IDate {
  Future<int?> writeDateRevision();
  late DateRevision date;
}

class RegisterDateRevision implements IDate {
  DateRevisionDataSourceRepository databaseData;

  RegisterDateRevision(this.databaseData, this.date);

  @override
  Future<int?> writeDateRevision() async {
    return await databaseData.insertDateRevision(date);
  }

  @override
  DateRevision date;
}

class UpdateDateRevision implements IDate {
  DateRevisionDataSourceRepository databaseData;

  UpdateDateRevision(this.databaseData, this.date);

  @override
  Future<int?> writeDateRevision() async {
    return await databaseData.updateDateRevision(date);
  }

  @override
  DateRevision date;
}
