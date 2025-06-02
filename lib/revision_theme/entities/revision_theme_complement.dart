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
    bool sync,
  ) : super(id: id, description: description, sync: sync);

  static RevisionThemeComplement mapFromObject(Map<String, dynamic> element) => RevisionThemeComplement(
        element['revisionDescription'],
        element['dateRevision'],
        element['title'],
        element['id'],
        element['description'],
        element['sync'] == 1,
      );
}
