import '../../../datasource/database/database_datasource.dart';
import '../../../entities/annotation_revision.dart';
import '../../../usercase/annotation_usercase.dart';

class ListAnnotattionController {
  final AnnotationUsercase annotationUsercase = AnnotationUsercase(AnnotationDatabaseDatasource());

  Future<List<AnnotationRevision>> getAnnotation({String? value}) async {
    return await annotationUsercase.getAnnotationWidthRevision() ?? [];
  }

  Future<bool> onClickDelete(int id) async {
    var result = await annotationUsercase.delete(id);
    if (result != null) return true;
    return false;
  }
}
