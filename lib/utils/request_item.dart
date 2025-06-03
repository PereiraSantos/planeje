class RequestItem {
  Map<String, dynamic> convert(dynamic item) {
    return {
      "id": item.id,
      "disable": item.disable ? 1 : 0,
    };
  }
}
