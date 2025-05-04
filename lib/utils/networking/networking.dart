import 'package:dio/dio.dart';

abstract class NetworkingFactory<T> {
  Future<Response<T>> post(Map data);
  Future<Response<T>> get();
  Future<Response<T>> put();
  Future<Response<T>> delete();
}
