import 'package:flutter/material.dart';
import 'package:planeje/annotation/entities/annotation_revision.dart';
import 'package:planeje/category/entities/category.dart';

class FilterNotifier with ChangeNotifier {
  List<Category> _filter = [];
  List<AnnotationRevision>? _annotation = [];

  List<AnnotationRevision>? get annotation => _annotation;

  void setAnnotation(List<AnnotationRevision> value) {
    _annotation = value;
  }

  List<Category> get filter => _filter;

  void setFilter(List<Category> value) {
    _filter = value;
    update();
  }

  void update() => notifyListeners();
}
