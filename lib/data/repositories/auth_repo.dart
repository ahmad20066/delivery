import 'package:deliveryapp/common/constants/end_points.dart';
import 'package:deliveryapp/common/providers/remote/api_provider.dart';
import 'package:deliveryapp/data/models/app_response.dart';
import 'package:deliveryapp/data/models/user_model.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  Future<AppResponse> login(Map<String, dynamic> loginBody) async {
    try {
      var appResponse =
          await ApiProvider.post(url: EndPoints.loginUrl, body: loginBody);

      return AppResponse(
          success: true, data: appResponse.data, errorMessage: null);
    } on DioException catch (e) {
      return AppResponse(
          success: false, data: null, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> register(UserModel user) async {
    try {
      final data = FormData.fromMap(await user.toMap());
      var appResponse =
          await ApiProvider.post(url: EndPoints.registerUrl, body: data);

      return AppResponse(
          success: true, data: appResponse.data, errorMessage: null);
    } on DioException catch (e) {
      return AppResponse(
          success: false, data: null, errorMessage: e.message ?? e.toString());
    }
  }
}
