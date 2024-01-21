import '../entities/annotation.dart';

abstract class AnnotationRepository {
  Future<List<Annotation>?> findAllAnnotation();
  Future<Annotation?> findAnnotationById(int id);
  Future<int?> insertAnnotation(Annotation annotationEntity);
  Future<Annotation?> updateAnnotation(String text, int id);
  Future<Annotation?> updateAnnotationData(String data, int id);
  Future<Annotation?> updateAnnotationTime(String time, int id);
  Future<Annotation?> delete(int id);
}
