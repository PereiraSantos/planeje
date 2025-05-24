import 'package:floor/floor.dart';

@Entity(tableName: 'revision_theme')
class RevisionTheme {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'id_external')
  int? idExternal;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'sync')
  bool? sync;

  @ColumnInfo(name: 'disable')
  bool? disable;

  RevisionTheme({this.id, this.idExternal, this.description, this.sync = true, this.disable = false});

  void setId(int? value) => id = value;
  void setIdExternal(int? value) => idExternal = value;
  void setDescription(String value) => description = value;
  void setSync({bool? value}) => sync = value ?? false;
  void setDisable(bool value) => disable = value;

  static RevisionTheme fromMapToObject(Map<String, dynamic> json) => RevisionTheme(
        idExternal: json['id'],
        description: json['description'],
      );

  static Map<String, dynamic> fromObjectToMap(RevisionTheme revisionTheme) => {
        "id": revisionTheme.idExternal,
        "description": revisionTheme.description,
      };
}
