import 'annotation.dart';

class AnnotationRevision extends Annotation {
  final String? description;
  final bool? status;
  final String? date;
  final String? nextDate;

  AnnotationRevision({
    this.description,
    this.status,
    this.date,
    this.nextDate,
    super.id,
    super.text,
    super.dateText,
    super.idRevision,
  });

  static AnnotationRevision fromJson(Map<String, dynamic> json) => AnnotationRevision(
        description: json['description'] != null ? json['description'] as String? : null,
        status: json['status'] != null
            ? json['status'] == 0
                ? true
                : false
            : null,
        date: json['date'] != null ? json['date'] as String? : null,
        nextDate: json['next_date'] != null ? json['next_date'] as String? : null,
        id: json['id'] as int?,
        text: json['text'] as String?,
        dateText: json['date_text'] as String?,
        idRevision: json['id_revision'] != null ? json['id_revision'] as int? : null,
      );
}
