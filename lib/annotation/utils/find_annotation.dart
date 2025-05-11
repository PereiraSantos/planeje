import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/entities/annotation_revision.dart';

abstract class FindAnnotationFactory {
  Future<List<AnnotationRevision>?> getAnnotationWidthRevision(String text);
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision);
  Future<List<Annotation>?> getAnnotationAll();
  Future<List<Annotation>?> findAnnotationSync();
  Future<Annotation?> findAnnotationByIdExternal(int idExternal);
}

class GetAnnotation implements FindAnnotationFactory {
  AnnotationDatabaseFactory annotationDatabase;

  GetAnnotation(this.annotationDatabase);

  @override
  Future<List<AnnotationRevision>?> getAnnotationWidthRevision(String text) async {
    return await annotationDatabase.getAnnotationWidthRevision(text);
  }

  @override
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision) async {
    return await annotationDatabase.getAnnotationWidthIdRevision(idRevision);
  }

  @override
  Future<List<Annotation>?> getAnnotationAll() async {
    return await annotationDatabase.getAnnotationAll();
  }

  @override
  Future<List<Annotation>?> findAnnotationSync() async {
    return await annotationDatabase.findAnnotationSync();
  }

  @override
  Future<Annotation?> findAnnotationByIdExternal(int idExternal) async {
    return await annotationDatabase.findAnnotationByIdExternal(idExternal);
  }
}
