import 'package:floor/floor.dart';

@Entity(tableName: 'date_revision')
class DateRevision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id_date')
  final int? id;

  @ColumnInfo(name: 'date_revision')
  final String? dateRevision;

  @ColumnInfo(name: 'next_date_revision')
  final String? nextDate;

  @ColumnInfo(name: 'hour_init')
  final String? hourInit;

  @ColumnInfo(name: 'hour_end')
  final String? hourEnd;

  @ColumnInfo(name: 'id_revision')
  final int? idRevision;

  DateRevision({
    this.id,
    this.dateRevision,
    this.nextDate,
    this.hourInit,
    this.hourEnd,
    this.idRevision,
  });
}
