import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'annotation')
class Annotation {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'id_external')
  int? idExternal;

  @ColumnInfo(name: 'title')
  String? title;

  @ColumnInfo(name: 'text')
  String? text;

  @ColumnInfo(name: 'date_text')
  String? dateText;

  @ColumnInfo(name: 'id_revision')
  int? idRevision;

  @ColumnInfo(name: 'sync')
  bool? sync;

  @ColumnInfo(name: 'disable')
  bool? disable;

  Annotation({
    this.id,
    this.idExternal,
    this.title,
    this.text,
    this.dateText,
    this.idRevision,
    this.sync = true,
    this.disable = false,
  });

  void setId(int? value) => id = value;
  void setIdExternal(int? value) => idExternal = value;
  void setTitle(String value) => title = value;
  void setText(String value) => text = value;
  void setDateText(String? date) => dateText = date ?? FormatDate.formatDate(FormatDate.newDate());
  void setIdRevision(int? value) => idRevision = value;
  void setSync({bool? value}) => sync = value ?? false;
  void setDisable(bool value) => disable = value;

  static Annotation fromMapToObject(Map<String, dynamic> json) => Annotation(
        idExternal: json['id'],
        title: json['title'],
        text: json['text'],
        dateText: json['dateText'],
        idRevision: json['idRevision'],
      );

  static Map<String, dynamic> fromObjectToMap(Annotation annotation) => {
        "id": annotation.idExternal,
        "title": annotation.title,
        "text": annotation.text,
        "dateText": annotation.dateText,
        "idRevision": annotation.idRevision,
      };
}
