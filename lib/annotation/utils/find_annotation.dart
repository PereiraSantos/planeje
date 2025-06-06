import 'package:planeje/annotation/datasource/database/annotation_database.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/entities/annotation_revision.dart';

abstract class FindAnnotationFactory {
  Future<List<AnnotationRevision>?> getAnnotationWidthRevision(String text);
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision);
  Future<List<Annotation>?> getAnnotationAll();
  Future<List<Annotation>?> findAnnotationSync();
  Future<List<Annotation>?> findAnnotationDisable();
  Future<void> deleteTable();
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
  Future<List<Annotation>?> findAnnotationDisable() async {
    return await annotationDatabase.findAnnotationDisable();
  }

  @override
  Future<void> deleteTable() async {
    return await annotationDatabase.deleteTable();
  }
}
