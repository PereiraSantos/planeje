import 'package:floor/floor.dart';

@Entity(tableName: 'annotation')
class Annotation {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'text')
  final String? text;

  @ColumnInfo(name: 'date_text')
  final String? dateText;

  @ColumnInfo(name: 'id_revision')
  final int? idRevision;

  Annotation({
    this.id,
    this.text,
    this.dateText,
    this.idRevision,
  });
}
