import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'annotation')
class Annotation {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'text')
  String? text;

  @ColumnInfo(name: 'date_text')
  String? dateText;

  @ColumnInfo(name: 'id_revision')
  int? idRevision;

  Annotation({
    this.id,
    this.text,
    this.dateText,
    this.idRevision,
  });

  void setId(int? value) => id = value;
  void setText(String value) => text = value;
  void setDateText(String? date) => dateText = date ?? FormatDate.formatDate(FormatDate.newDate());
  void setIdRevision(int? value) => idRevision = value;
}
