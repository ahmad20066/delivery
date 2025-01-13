import 'package:deliveryapp/common/constants/end_points.dart';
import 'package:deliveryapp/common/providers/local/cache_provider.dart';
import 'package:deliveryapp/common/providers/remote/api_provider.dart';
import 'package:deliveryapp/data/models/app_response.dart';
import 'package:dio/dio.dart';

class ApiRepo {
  Future<AppResponse> getStores() async {
    try {
      final response = await ApiProvider.get(
          url: EndPoints.storesUrl, token: CacheProvider.getAppToken());
      return AppResponse(success: true, data: response.data['data']);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> getFavorites() async {
    try {
      final response = await ApiProvider.get(
          url: EndPoints.wishlist, token: CacheProvider.getAppToken());
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> getCart() async {
    try {
      final response = await ApiProvider.get(
          url: EndPoints.cart, token: CacheProvider.getAppToken());
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> addToCart(List<Map<String, dynamic>> map) async {
    try {
      final response = await ApiProvider.post(
          url: EndPoints.addToCart,
          token: CacheProvider.getAppToken(),
          body: {'items': map});
      return AppResponse(success: true, data: response.data['data']);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> toggleFavorite(int id) async {
    try {
      final response = await ApiProvider.post(
          url: EndPoints.wishlist,
          token: CacheProvider.getAppToken(),
          body: {'product_id': id});
      return AppResponse(success: true, data: response.data['data']);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> deleteFavorite(int id) async {
    try {
      final response = await ApiProvider.delete(
        url: "${EndPoints.wishlist}/$id",
        token: CacheProvider.getAppToken(),
      );
      print("***********");
      print(response.data);
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> deleteCartItem(int id) async {
    try {
      final response = await ApiProvider.post(
          url: "${EndPoints.removeCart}",
          token: CacheProvider.getAppToken(),
          body: {
            "items": [
              {"product_id": id}
            ]
          });
      print("***********");
      print(response.data);
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> clearCart(List<Map<String, dynamic>> items) async {
    try {
      final response = await ApiProvider.post(
        url: "${EndPoints.removeCart}",
        token: CacheProvider.getAppToken(),
        body: {"items": items},
      );
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(
        success: false,
        errorMessage: e.message ?? e.toString(),
      );
    }
  }

  Future<AppResponse> getProfile() async {
    try {
      final response = await ApiProvider.get(
          url: EndPoints.profile, token: CacheProvider.getAppToken());
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> getOrders() async {
    try {
      final response = await ApiProvider.get(
          url: EndPoints.myOrders, token: CacheProvider.getAppToken());
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> checkout(List<Map<String, dynamic>> map) async {
    try {
      final response = await ApiProvider.post(
          url: "${EndPoints.orders}",
          token: CacheProvider.getAppToken(),
          body: {"items": map});
      print("***********");
      print(response.data);
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> getDriverOrders() async {
    try {
      final response = await ApiProvider.get(
          url: EndPoints.orders, token: CacheProvider.getAppToken());
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }

  Future<AppResponse> changeStatus(int id, String status) async {
    try {
      final response = await ApiProvider.post(
          url: "${EndPoints.changeStatus}",
          token: CacheProvider.getAppToken(),
          body: {"order_id": id, 'status': status});
      print("***********");
      print(response.data);
      return AppResponse(success: true, data: response.data);
    } on DioException catch (e) {
      return AppResponse(
          success: false, errorMessage: e.message ?? e.toString());
    }
  }
}
