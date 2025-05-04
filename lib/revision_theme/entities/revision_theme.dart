import 'package:floor/floor.dart';

@Entity(tableName: 'revision_theme')
class RevisionTheme {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'sync')
  bool? sync;

  RevisionTheme({this.id, this.sync, this.description});

  void setId(int? value) => id = value;
  void setDescription(String value) => description = value;
  void setSync({bool? value}) => sync = value ?? false;

  static RevisionTheme fromMapToObject(Map<String, dynamic> json) => RevisionTheme(id: json['id'], description: json['description']);

  static Map<String, dynamic> fromObjectToMap(RevisionTheme revisionTheme) => {"description": revisionTheme.description};
}
