import 'package:dio/dio.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/networking.dart';

class Network implements NetworkingFactory {
  final List<Endpoint> endpoints;
  final ConfigApi configApi;

  Network(this.configApi, this.endpoints);

  @override
  Future<Response> delete() async {
    return await configApi.dio.delete(_path());
  }

  @override
  Future<Response> get() async {
    return await configApi.dio.get(_path());
  }

  @override
  Future<Response> post(Map data) async {
    return await configApi.dio.post(_path(), data: data);
  }

  @override
  Future<Response> put() async {
    return await configApi.dio.put(_path());
  }

  String _path() => '${configApi.host}:${configApi.port}${_endpoint()}';

  String _endpoint() => endpoints.map((e) => '/${e.name}').join();
}
