import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/utils/register.dart';
import 'package:planeje/utils/type_message.dart';

abstract class RevisionThemeFactory extends RegisterFactory {
  RevisionTheme? revisionTheme;
  List<RevisionTheme>? revisionThemes;
}

class RegisterRevisioTheme implements RevisionThemeFactory {
  final RevisionThemeDatabaseFactory revisionThemeDatabase;

  RegisterRevisioTheme(this.revisionThemeDatabase, {this.revisionTheme, this.message, this.revisionThemes});

  @override
  StatusNotification? message;

  @override
  Future write() async {
    if (revisionTheme == null) throw ('Teve passar um objeto revisionTheme');
    return await revisionThemeDatabase.insertRevisionTheme(revisionTheme!);
  }

  @override
  Future writeList() async {
    if (revisionThemes == null) throw ('Teve passar a uma lista de revisionThemes');
    return await revisionThemeDatabase.insertRevisionThemeList(revisionThemes!);
  }

  @override
  RevisionTheme? revisionTheme;

  @override
  List<RevisionTheme>? revisionThemes;
}

class UpdateRevisionTheme implements RevisionThemeFactory {
  final RevisionThemeDatabaseFactory revisionThemeDatabase;

  UpdateRevisionTheme(this.revisionThemeDatabase, {this.revisionTheme, this.message, this.revisionThemes});
  @override
  StatusNotification? message;

  @override
  RevisionTheme? revisionTheme;

  @override
  List<RevisionTheme>? revisionThemes;

  @override
  Future write() async {
    if (revisionTheme == null) throw ('Teve passar um objeto revisionTheme');
    return await revisionThemeDatabase.updateRevisionTheme(revisionTheme!);
  }

  @override
  Future writeList() async {
    if (revisionThemes == null) throw ('Teve passar a uma lista de revisionThemes');
    return await revisionThemeDatabase.updateRevisionThemeList(revisionThemes!);
  }
}
