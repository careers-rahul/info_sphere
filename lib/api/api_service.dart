import 'package:info_sphere/utils/imports.dart';

class ApiService {
  static Future<Object> getData(Dio dio, String url, {Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );
      print(url);
      print(response.statusCode.toString());
      print(response.data);

      if (response.statusCode == HttpStatus.ok) {
        var res = SuccessResponse.fromJson(response.data);
        return Success(
          status: res.status,
          totalResults: res.totalResults,
          data: res.data,
        );
      } else {
        var res = ErrorResponse.fromJson(response.data);
        return Error(
          code: res.code,
          message: res.message,
          status: res.status,
        );
      }
    } on DioException {
      return ErrorResponse(code: httpErrorCode, message: httpError);
    } catch (e) {
      return ErrorResponse(code: e.toString(), message: somethingWentWrong);
    }
  }
}
