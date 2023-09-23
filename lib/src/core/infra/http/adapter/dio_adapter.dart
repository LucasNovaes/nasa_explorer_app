import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nasa_explorer_app/src/core/failure/failure_type.dart';

import '../../../failure/failure.dart';
import '../client/http_client.dart';
import '../error/http_error.dart';

class DioAdapter implements HttpClient {
  final Dio dio;
  final List<Interceptor>? interceptors;

  DioAdapter({
    required this.dio,
    this.interceptors,
  }) {
    _addCustomInterceptors();
    _addLogInterceptor();
  }

  void _addLogInterceptor() {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
        logPrint: (object) {
          log(object.toString());
        },
      ),
    );
  }

  void _addCustomInterceptors() {
    final List<Interceptor>? listInterceptors = interceptors;
    if (listInterceptors != null && listInterceptors.isNotEmpty) {
      dio.interceptors.addAll(listInterceptors);
    }
  }

  @override
  Future<List?> request({
    required String url,
    required String method,
    Map<String, dynamic>? queryParameters,
    Map? body,
    Map? headers,
    bool userDefaultHeaders = true,
  }) async {
    final defaultHeaders = userDefaultHeaders
        ? {
            'content-type': 'application/json',
            'accept': 'application/json',
          }
        : {};

    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    final options = Options(headers: Map<String, dynamic>.from(defaultHeaders));

    late Response response;

    try {
      switch (method) {
        case 'post':
          response = await dio.post(url,
              options: options, queryParameters: queryParameters ?? {});
          break;
        case 'get':
          response = await dio.get(url,
              queryParameters: queryParameters ?? {}, options: options);
          break;
        case 'put':
          response =
              await dio.put(url, data: queryParameters ?? {}, options: options);
          break;
        case 'patch':
          response = await dio.patch(url,
              data: queryParameters ?? {}, options: options);
          break;
        case 'delete':
          response = await dio.delete(url,
              data: queryParameters ?? {}, options: options);
          break;
        default:
          throw HttpError.serverError;
      }
    } on DioException catch (error) {
      if (error.error is Failure) {
        throw error.error!;
      } else if (error.response != null) {
        return _handleResponse(error.response!);
      }
    } catch (error) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  List<dynamic> _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 202:
      case 201:
        return _getResponseData(response);

      case 204:
        return [];
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      case 405:
        throw HttpError.methodNotAllowed;
      case 409:
        throw HttpError.conflict;
      case 422:
        if (response.data != null) {
          throw Map<String, dynamic>.from(response.data);
        }
        throw HttpError.unprocessableEntity;
      case 500:
        if (response.data == null) {
          throw HttpError.serverError;
        }
        throw response.data;
      default:
        throw HttpError.serverError;
    }
  }

  _getResponseData(Response response) {
    if (response.data != null) {
      return response.data;
    } else {
      throw Failure('Error HTTP Response',
          exception: response, type: FailureType.unexpected);
    }
  }
}
