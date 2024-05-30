import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'revision')
class Revision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'date_creational')
  String? dateCreational;

  Revision({
    this.id,
    this.description,
    this.dateCreational,
  });

  set setId(int? value) => id = value;
  set setDescription(String value) => description = value;
  set setDateCreational(String? value) =>
      dateCreational = value ?? FormatDate.formatDate(FormatDate.newDate());
}
