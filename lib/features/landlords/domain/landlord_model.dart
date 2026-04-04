import 'package:freezed_annotation/freezed_annotation.dart';

part 'landlord_model.freezed.dart';
part 'landlord_model.g.dart';

@freezed
class Landlord with _$Landlord {
  const factory Landlord({
    required int id,
    required int usersId,
    String? usersFullName,
    String? status,
  }) = _Landlord;

  factory Landlord.fromJson(Map<String, dynamic> json) =>
      _$LandlordFromJson(json);
}

@freezed
class LandlordRequest with _$LandlordRequest {
  const factory LandlordRequest({
    required int usersId,
  }) = _LandlordRequest;

  factory LandlordRequest.fromJson(Map<String, dynamic> json) =>
      _$LandlordRequestFromJson(json);
}
