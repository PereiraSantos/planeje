import 'package:flutter_test/flutter_test.dart';
import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/entities/revision_theme_complement.dart';
import 'package:planeje/revision_theme/utils/insert_revision_theme.dart';
import 'package:planeje/revision_theme/utils/update_revision_theme.dart';

void main() {
  group('Teste de registro tema de revisão', () {
    test('Espero que registre', () async {
      InsertRevisioTheme insertRevisioTheme = InsertRevisioTheme(NockRevisionThemeDatabase());
      insertRevisioTheme.revisionTheme = RevisionTheme(description: 'Flutter');

      int result = await insertRevisioTheme.write();

      expect(1, result);
    });
    test('Espero que registre list', () async {
      InsertRevisioTheme insertRevisioTheme = InsertRevisioTheme(NockRevisionThemeDatabase());
      insertRevisioTheme.revisionThemes = [RevisionTheme(description: 'Flutter'), RevisionTheme(description: 'Poo')];

      List<int> result = await insertRevisioTheme.writeList();

      expect([1, 2], result);
    });
    test('Espero que faça update', () async {
      UpdateRevisionTheme updateRevisioTheme = UpdateRevisionTheme(NockRevisionThemeDatabase());

      updateRevisioTheme.revisionTheme = RevisionTheme(id: 1, description: 'Flutter');

      int? result = await updateRevisioTheme.write();

      expect(1, result);
    });
  });
}

class NockRevisionThemeDatabase implements RevisionThemeDatabaseFactory {
  @override
  Future<void> deleteTable() {
    // TODO: implement deleteTable
    throw UnimplementedError();
  }

  @override
  Future<RevisionTheme?> disableRevisionThemeById(int id) {
    // TODO: implement disableRevisionThemeById
    throw UnimplementedError();
  }

  @override
  Future<List<RevisionTheme>> findAllRevisionTheme() {
    // TODO: implement findAllRevisionTheme
    throw UnimplementedError();
  }

  @override
  Future<List<RevisionTheme>?> findAllRevisionThemeSync() {
    // TODO: implement findAllRevisionThemeSync
    throw UnimplementedError();
  }

  @override
  Future<List<RevisionThemeComplement>> findRevisionThemeByDescription(String text) {
    // TODO: implement findRevisionThemeByDescription
    throw UnimplementedError();
  }

  @override
  Future<RevisionTheme?> findRevisionThemeById(int id) {
    // TODO: implement findRevisionThemeById
    throw UnimplementedError();
  }

  @override
  Future<List<RevisionTheme>?> findRevisionThemeDisable() {
    // TODO: implement findRevisionThemeDisable
    throw UnimplementedError();
  }

  @override
  Future<int> insertRevisionTheme(RevisionTheme revisionTheme) async {
    return 1;
  }

  @override
  Future<List<int>> insertRevisionThemeList(List<RevisionTheme> revisionThemes) async {
    return [1, 2];
  }

  @override
  Future<int?> updateRevisionTheme(RevisionTheme revisionTheme) async {
    return 1;
  }
}
