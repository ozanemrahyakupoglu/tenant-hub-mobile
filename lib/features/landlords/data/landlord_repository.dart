import 'package:dio/dio.dart';
import 'package:tenant_hub_mobile/core/constants/api_constants.dart';
import 'package:tenant_hub_mobile/core/network/dio_client.dart';
import 'package:tenant_hub_mobile/features/landlords/domain/landlord_model.dart';
import 'package:tenant_hub_mobile/shared/models/page_response.dart';

class LandlordRepository {
  final Dio _dio;

  LandlordRepository({required Dio dio}) : _dio = dio;

  Future<PageResponse<Landlord>> getLandlords({
    int page = 0,
    int size = 10,
    String? sort,
  }) async {
    try {
      final params = <String, dynamic>{'page': page, 'size': size};
      if (sort != null) params['sort'] = sort;

      final response =
          await _dio.get(ApiConstants.landlords, queryParameters: params);
      return PageResponse.fromJson(response.data, Landlord.fromJson);
    } on DioException catch (e) {
      throw DioClient.handleError(e);
    }
  }

  Future<Landlord> createLandlord(LandlordRequest request) async {
    try {
      final response =
          await _dio.post(ApiConstants.landlords, data: request.toJson());
      return Landlord.fromJson(response.data);
    } on DioException catch (e) {
      throw DioClient.handleError(e);
    }
  }

  Future<Landlord> updateLandlord(int id, LandlordRequest request) async {
    try {
      final response = await _dio.put(
        '${ApiConstants.landlords}/$id',
        data: request.toJson(),
      );
      return Landlord.fromJson(response.data);
    } on DioException catch (e) {
      throw DioClient.handleError(e);
    }
  }

  Future<void> deleteLandlord(int id) async {
    try {
      await _dio.delete('${ApiConstants.landlords}/$id');
    } on DioException catch (e) {
      throw DioClient.handleError(e);
    }
  }
}
