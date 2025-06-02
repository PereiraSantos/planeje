import 'package:planeje/annotation/datasource/database/annotation_database.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/utils/register.dart';
import 'package:planeje/utils/type_message.dart';

abstract class RegisterAnnotationFactory extends RegisterFactory {
  Annotation? annotation;
  List<Annotation>? annotations;
}

class InsertAnnotation implements RegisterAnnotationFactory {
  AnnotationDatabaseFactory annotationDatabase;

  InsertAnnotation(this.annotationDatabase, {this.annotation, this.message, this.annotations});

  @override
  Future<int?> write() async {
    if (annotation == null) throw ('Teve passar um objeto annotation');

    return await annotationDatabase.insertAnnotation(annotation!);
  }

  @override
  Annotation? annotation;

  @override
  StatusNotification? message;

  @override
  Future writeList() async {
    if (annotations == null) throw ('Teve passar a uma lista de annotations');
    return await annotationDatabase.insertAnnotationList(annotations!);
  }

  @override
  List<Annotation>? annotations;
}

class UpdateAnnotation implements RegisterAnnotationFactory {
  AnnotationDatabaseFactory annotationDatabase;

  UpdateAnnotation(this.annotationDatabase, {this.annotation, this.message, this.annotations});

  @override
  Future<int?> write() async {
    if (annotation == null) throw ('Teve passar um objeto annotation');
    return await annotationDatabase.updateAnnotation(annotation!);
  }

  @override
  Annotation? annotation;

  @override
  StatusNotification? message;

  @override
  Future writeList() async {
    if (annotations == null) throw ('Teve passar a uma lista de annotations');
    return await annotationDatabase.updateAnnotationList(annotations!);
  }

  @override
  List<Annotation>? annotations;
}
