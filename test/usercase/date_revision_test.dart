import 'package:flutter_test/flutter_test.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/usercase/date_revision_usercase.dart';

void main() {
  DateRevisionUsercase dateRevisionUsercase = DateRevisionUsercase(DateRevisionDatabaseDataSource());
  test('Espero que retorne data da revisão', () {
    var dateRevision = dateRevisionUsercase.builddateRevision(
        daRevision: '01/01/2024',
        hourInit: '01/01/2024',
        hourEnd: '01/01/2024',
        nextDate: '01/01/2024',
        idRevision: 1);
    expect(dateRevision, isInstanceOf<DateRevision>());
  });
}
