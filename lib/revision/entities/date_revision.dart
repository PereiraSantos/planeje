import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'date_revision')
class DateRevision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id_date')
  int? id;

  @ColumnInfo(name: 'id_external')
  int? idExternal;

  @ColumnInfo(name: 'date_revision')
  String? dateRevision;

  @ColumnInfo(name: 'id_revision')
  int? idRevision;

  @ColumnInfo(name: 'sync')
  bool? sync;

  @ColumnInfo(name: 'disable')
  bool? disable;

  DateRevision({
    this.id,
    this.idExternal,
    this.dateRevision,
    this.idRevision,
    this.sync = true,
    this.disable = false,
  });

  void setId(int? value) => id = value;
  void setIdExternal(int? value) => idExternal = value;
  void setDate(String? value) => dateRevision = value ?? FormatDate.formatDate(DateTime.now());
  void setIdRevision(int? value) => idRevision = value;
  void setSync(bool? value) => sync = value ?? false;
  void setDisable(bool value) => disable = value;

  static DateRevision fromMapToObject(Map<String, dynamic> json) => DateRevision(
        idExternal: json['id'],
        dateRevision: json['dateRevision'],
        idRevision: json['idRevision'],
      );

  static Map<String, dynamic> fromObjectToMap(DateRevision dateRevision) => {
        "id": dateRevision.idExternal,
        "dateRevision": dateRevision.dateRevision,
        "idRevision": dateRevision.idRevision,
      };
}
