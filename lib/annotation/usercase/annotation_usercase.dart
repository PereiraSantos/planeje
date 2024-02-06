import 'package:planeje/annotation/entities/annotation.dart';

import '../datasource/database/database_datasource.dart';
import '../entities/annotation_revision.dart';
import '../repository/annotiation_repository.dart';

class AnnotationUsercase implements AnnotationRepository {
  final AnnotationDatabaseDatasource annotationDatabaseDatasource;

  AnnotationUsercase(this.annotationDatabaseDatasource);

  @override
  Future<Annotation?> delete(int id) async {
    return annotationDatabaseDatasource.delete(id);
  }

  @override
  Future<List<Annotation>?> findAllAnnotation() async {
    return annotationDatabaseDatasource.findAllAnnotation();
  }

  @override
  Future<Annotation?> findAnnotationById(int id) async {
    return annotationDatabaseDatasource.findAnnotationById(id);
  }

  @override
  Future<int?> insertAnnotation(Annotation annotationEntity) async {
    return annotationDatabaseDatasource.insertAnnotation(annotationEntity);
  }

  @override
  Future<Annotation?> updateAnnotation(String text, int id) async {
    return annotationDatabaseDatasource.updateAnnotation(text, id);
  }

  @override
  Future<Annotation?> updateAnnotationData(String data, int id) async {
    return annotationDatabaseDatasource.updateAnnotationData(data, id);
  }

  @override
  Future<Annotation?> updateAnnotationTime(String time, int id) async {
    return annotationDatabaseDatasource.updateAnnotationTime(time, id);
  }

  @override
  Future<Annotation?> updateAnnotationRevision(int idRevision, int id) async {
    return annotationDatabaseDatasource.updateAnnotationRevision(idRevision, id);
  }

  @override
  Future<List<AnnotationRevision>?> getAnnotationWidthRevision() async {
    return annotationDatabaseDatasource.getAnnotationWidthRevision();
  }

  @override
  Future<List<Annotation>?> findAnnotationByIdRevision(int idRevision) async {
    return annotationDatabaseDatasource.findAnnotationByIdRevision(idRevision);
  }
}
