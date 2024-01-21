import 'package:floor/floor.dart';

import '../../../entities/annotation.dart';

@dao
abstract class AnnotationDao {
  @Query('select * from annotation')
  Future<List<Annotation>> findAllAnnotation();

  @Query('SELECT * FROM annotation WHERE id = :id')
  Future<Annotation?> findAnnotationById(int id);

  @insert
  Future<int?> insertAnnotation(Annotation annotationEntity);

  @Query('update annotation set text = :text WHERE id = :id')
  Future<Annotation?> updateAnnotation(String text, int id);

  @Query('update annotation set date_text = :data WHERE id = :id')
  Future<Annotation?> updateAnnotationData(String data, int id);

  @Query('update annotation set text = :time WHERE id = :id')
  Future<Annotation?> updateAnnotationTime(String time, int id);

  @Query('delete from annotation where id = :id')
  Future<Annotation?> delete(int id);
}
