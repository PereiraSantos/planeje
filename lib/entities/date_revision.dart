import 'package:floor/floor.dart';

@Entity(tableName: 'date_revision')
class DateRevision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'revision_id')
  int? revisionId;

  @ColumnInfo(name: 'date')
  String? date;

  @ColumnInfo(name: 'status')
  bool? status;

  @ColumnInfo(name: 'hour')
  int? hour;

  @ColumnInfo(name: 'minute')
  int? minute;

  DateRevision({
    this.id,
    this.revisionId,
    this.date,
    this.status = false,
    this.hour,
    this.minute,
  });
}
