import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'revision_quiz')
class RevisionQuiz {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'id_external')
  int? idExternal;

  @ColumnInfo(name: 'date_revision')
  String? dateRevision;

  @ColumnInfo(name: 'answer')
  bool? answer;

  @ColumnInfo(name: 'id_quiz')
  int? idQuiz;

  @ColumnInfo(name: 'sync')
  bool? sync;

  RevisionQuiz({
    this.id,
    this.idExternal,
    this.dateRevision,
    this.answer,
    this.idQuiz,
    this.sync = true,
  });

  void setId(int? value) => id = value;
  void setIdExternal(int? value) => idExternal = value;
  void setDate({String? value}) => dateRevision = value ?? FormatDate.formatDateTime(DateTime.now());
  void setAnswer(bool? value) => answer = value;
  void setIdQuiz(int? value) => idQuiz = value;
  void setSync({bool? value}) => sync = value ?? false;

  static RevisionQuiz fromMapToObject(Map<String, dynamic> json) => RevisionQuiz(
        idExternal: json['id'],
        dateRevision: json['dateRevision'],
        answer: json['answer'] == 1,
        idQuiz: json['idQuiz'],
      );

  static Map<String, dynamic> fromObjectToMap(RevisionQuiz revisionQuiz) => {
        "idExternal": revisionQuiz.idExternal,
        "answer": (revisionQuiz.answer ?? false) ? 1 : 0,
        "dateRevision": revisionQuiz.dateRevision,
        "idQuiz": revisionQuiz.idQuiz,
      };
}
