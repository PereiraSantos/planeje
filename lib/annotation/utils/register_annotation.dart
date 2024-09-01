import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/utils/register.dart';
import 'package:planeje/utils/type_message.dart';

abstract class RegisterAnnotationFactory extends RegisterFactory {
  late Annotation annotation;
}

class InsertAnnotation implements RegisterAnnotationFactory {
  AnnotationDatabaseFactory annotationDatabase;

  InsertAnnotation(this.annotationDatabase, this.annotation, this.message);

  @override
  Future<int?> write() async {
    return await annotationDatabase.insertAnnotation(annotation);
  }

  @override
  Annotation annotation;

  @override
  StatusNotification message;
}

class UpdateAnnotation implements RegisterAnnotationFactory {
  AnnotationDatabaseFactory annotationDatabase;

  UpdateAnnotation(this.annotationDatabase, this.annotation, this.message);

  @override
  Future<int?> write() async {
    return await annotationDatabase.updateAnnotation(annotation);
  }

  @override
  Annotation annotation;

  @override
  StatusNotification message;
}
