import 'package:dio/dio.dart';
import 'dart:async';

class HttpServices {
  var dio = Dio();
  // Response response;

  HttpServices() {
    dio.options.baseUrl = 'https://cdn-api.co-vin.in/api';
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError error, ErrorInterceptorHandler handler) {
          print(error.message);
          return handler.next(error);
        },
        onRequest: (RequestOptions request, RequestInterceptorHandler handler) {
          print('${request.method} ${request.path}');
          return handler.next(request);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          print(response.data);
          return handler.next(response);
        },
      ),
    );
  }

  Future<Response> getRequest() async {
    Response response;
    try {
      response = await dio.request(
        '/api/users/2',
        options: Options(
          method: 'GET',
        ),
      );
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    print(response.data);
    return response;
  }

  Future<Response> getTxnId(String mobNo) async {
    Response response;

    try {
      response = await dio.post(
        '/v2/auth/public/generateOTP',
        data: {"mobile": mobNo},
      );
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    print(response.data);
    return response;
  }
}
