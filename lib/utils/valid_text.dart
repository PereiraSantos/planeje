class ValidText {
  static bool validTextIsNull(String value) => value.isEmpty ? false : true;

  static bool validTextIsBig(String value) => value.length > 100 ? false : true;
}
