import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'revision')
class Revision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'title')
  String? title;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'date_creational')
  String? dateCreational;

  Revision({
    this.id,
    this.title,
    this.description,
    this.dateCreational,
  });

  void setId(int? value) => id = value;
  void setTitle(String value) => title = value;
  void setDescription(String value) => description = value;
  void setDateCreational(String? value) => dateCreational = value ?? FormatDate.formatDate(FormatDate.newDate());
}
