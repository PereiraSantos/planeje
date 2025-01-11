import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'date_revision')
class DateRevision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id_date')
  int? id;

  @ColumnInfo(name: 'date_revision')
  String? dateRevision;

  @ColumnInfo(name: 'id_revision')
  int? idRevision;

  DateRevision({
    this.id,
    this.dateRevision,
    this.idRevision,
  });

  void setId(int? value) => id = value;
  void setDate(String? value) => dateRevision = value ?? FormatDate.formatDate(DateTime.now());
  void setIdRevision(int? value) => idRevision = value;
}
