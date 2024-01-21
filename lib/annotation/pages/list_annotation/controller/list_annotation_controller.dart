import '../../../datasource/database/database_datasource.dart';
import '../../../entities/annotation.dart';
import '../../../usercase/annotation_usercase.dart';

class ListAnnotattionController {
  final AnnotationUsercase annotationUsercase = AnnotationUsercase(AnnotationDatabaseDatasource());

  Future<List<Annotation>> getAnnotation({String? value}) async {
    return await annotationUsercase.findAllAnnotation() ?? [];
  }

  Future<bool> onClickDelete(int id) async {
    var result = await annotationUsercase.delete(id);
    if (result != null) return true;
    return false;
  }
}
