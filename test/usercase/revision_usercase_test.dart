import 'package:flutter_test/flutter_test.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/usercase/revision_usercase.dart';
import 'package:planeje/utils/format_date.dart';

void main() {
  RevisionUsercase revisionUsercase = RevisionUsercase(RevisionDatabaseDataSource());

  test("Epero que retorne um objeto reviser", () {
    var actual = revisionUsercase.buildRevision(
      description: "teste",
      dateCriational: FormatDate.formatDate(DateTime.now()),
    );

    expect(actual, isInstanceOf<Revision>());
  });
}
