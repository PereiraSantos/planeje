import 'package:flutter_test/flutter_test.dart';
import 'package:planeje/revision/entities/revision.dart';

import 'package:planeje/revision/usercase/build_revision.dart';

void main() {
  test("Epero que retorne um objeto reviser", () {
    BuildRevision revision = BuildRevision();
    var actual = revision.build(description: "teste", nextDate: '10/01/24', timeEnd: '', timeInit: '');
    expect(actual, isInstanceOf<Revision>());
  });
}
