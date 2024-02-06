import '../../entities/annotation.dart';
import '../../entities/annotation_revision.dart';

abstract class AnnotationDataSourceRepository {
  Future<List<Annotation>?> findAllAnnotation();
  Future<Annotation?> findAnnotationById(int id);
  Future<int?> insertAnnotation(Annotation annotationEntity);
  Future<Annotation?> updateAnnotation(String text, int id);
  Future<Annotation?> updateAnnotationData(String data, int id);
  Future<Annotation?> updateAnnotationTime(String time, int id);
  Future<Annotation?> delete(int id);
  Future<Annotation?> updateAnnotationRevision(int idRevision, int id);
  Future<List<AnnotationRevision>?> getAnnotationWidthRevision();
  Future<List<Annotation>?> findAnnotationByIdRevision(int idRevision);
}
