import 'package:flutter/material.dart';
import 'package:planeje/annotation/entities/annotation_revision.dart';
import 'package:planeje/category/entities/category.dart';

class FilterNotifier with ChangeNotifier {
  List<Category> _filters = [];
  List<AnnotationRevision>? _annotationsRevisions = [];

  List<AnnotationRevision>? get annotationsRevisions => _annotationsRevisions;

  void setAnnotation(List<AnnotationRevision> value) {
    _annotationsRevisions = value;
  }

  List<Category> get filters => _filters;

  void setFilter(List<Category> value) {
    _filters = value;
    update();
  }

  void update() => notifyListeners();
}
