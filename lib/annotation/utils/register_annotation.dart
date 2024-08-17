import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/utils/type_message.dart';

abstract class RegisterAnnotationFactory {
  Future<int?> writeAnnotation();
  late Annotation annotation;
  late Message message;
}

class InsertAnnotation implements RegisterAnnotationFactory {
  AnnotationDatabaseFactory annotationDatabase;

  InsertAnnotation(this.annotationDatabase, this.annotation, this.message);

  @override
  Future<int?> writeAnnotation() async {
    return await annotationDatabase.insertAnnotation(annotation);
  }

  @override
  Annotation annotation;

  @override
  Message message;
}

class UpdateAnnotation implements RegisterAnnotationFactory {
  AnnotationDatabaseFactory annotationDatabase;

  UpdateAnnotation(this.annotationDatabase, this.annotation, this.message);

  @override
  Future<int?> writeAnnotation() async {
    return await annotationDatabase.updateAnnotation(annotation);
  }

  @override
  Annotation annotation;

  @override
  Message message;
}
