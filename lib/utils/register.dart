import 'package:planeje/utils/type_message.dart';

abstract class RegisterFactory<T> {
  Future<T?> write();
  late StatusNotification message;
}
