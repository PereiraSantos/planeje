import 'package:dio/dio.dart';

class ConfigApi {
  final _dio = Dio();
  final String _host = 'http://192.168.1.102';
  final int _port = 8080;

  Dio get dio => _dio;

  int get port => _port;

  String get host => _host;
}
