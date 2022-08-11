import 'package:dio/dio.dart';

import 'client_http_interface.dart';

class DioClientHttp implements IClientHttp {
  final Dio _dio;

  DioClientHttp(this._dio);

  final _interceptors = <DioInterceptor>[];

  @override
  void setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  @override
  void setHeaders(Map<String, String> header) {
    _dio.options.headers = header;
  }

  @override
  Future<BaseResponse> get(String path) async {
    final response = await _dio.get(path);
    return _responseAdapter(response);
  }

  @override
  Future<BaseResponse> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    final response = await _dio.post(path, data: data);
    return _responseAdapter(response);
  }

  @override
  Future<BaseResponse> delete(String path) async {
    final response = await _dio.delete(path);
    return _responseAdapter(response);
  }

  @override
  Future<BaseResponse> put(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    final response = await _dio.put(path, data: data);
    return _responseAdapter(response);
  }

  @override
  Future<BaseResponse> upload(
    String path, {
    List<int>? data,
  }) async {
    final response = await _dio.post(path, data: data);
    return _responseAdapter(response);
  }

  @override
  void addInterceptor(covariant DioInterceptor interceptor) {
    _interceptors.add(interceptor);
  }

  @override
  void removeInterceptor(covariant DioInterceptor interceptor) {
    _interceptors.remove(interceptor);
  }

  BaseResponse _responseAdapter(Response response) {
    return BaseResponse(
      response.data,
      BaseRequest(
        url: response.requestOptions.path,
        method: response.requestOptions.method,
        headers: response.requestOptions.headers.cast(),
        data: response.requestOptions.data,
      ),
    );
  }
}

class DioInterceptor
    extends BaseInterceptor<RequestOptions, Response, DioError> {
  @override
  Future<DioError> onError(DioError error) async {
    return error;
  }

  @override
  Future<RequestOptions> onRequest(
    RequestOptions request,
  ) async {
    return request;
  }

  @override
  Future<Response> onResponse(
    Response response,
  ) async {
    return response;
  }
}
