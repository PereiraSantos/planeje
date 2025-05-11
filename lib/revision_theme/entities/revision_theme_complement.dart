import 'package:planeje/revision_theme/entities/revision_theme.dart';

class RevisionThemeComplement extends RevisionTheme {
  String? revisionDescription;
  String? dateRevision;
  String? title;

  RevisionThemeComplement(
    this.revisionDescription,
    this.dateRevision,
    this.title,
    int id,
    String description,
    int? idExternal,
    bool sync,
  ) : super(id: id, description: description, idExternal: idExternal, sync: sync);

  static RevisionThemeComplement mapFromObject(Map<String, dynamic> element) => RevisionThemeComplement(
        element['revisionDescription'],
        element['dateRevision'],
        element['title'],
        element['id'],
        element['description'],
        element['id_external'],
        element['sync'] == 1,
      );
}
