import 'package:floor/floor.dart';

@Entity(tableName: 'revision')
class Revision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'text')
  final String? text;

  @ColumnInfo(name: 'date_criation')
  final String? dateCriation;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'revision')
  final String? revision;

  @ColumnInfo(name: 'next_revision')
  final String? nextRevision;

  @ColumnInfo(name: 'status')
  final bool? status;

  Revision({
    this.id,
    this.text,
    this.dateCriation,
    this.description,
    this.revision,
    this.nextRevision,
    this.status = false,
  });
}
