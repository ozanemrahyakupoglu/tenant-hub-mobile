import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_hub_mobile/core/network/dio_client.dart';
import 'package:tenant_hub_mobile/features/landlords/data/landlord_repository.dart';
import 'package:tenant_hub_mobile/features/landlords/domain/landlord_model.dart';
import 'package:tenant_hub_mobile/shared/models/page_response.dart';

final landlordRepositoryProvider = Provider<LandlordRepository>((ref) {
  return LandlordRepository(dio: ref.watch(dioProvider));
});

final landlordsProvider =
    StateNotifierProvider<LandlordsNotifier, AsyncValue<PageResponse<Landlord>>>(
        (ref) {
  return LandlordsNotifier(ref.watch(landlordRepositoryProvider));
});

class LandlordsNotifier
    extends StateNotifier<AsyncValue<PageResponse<Landlord>>> {
  final LandlordRepository _repository;
  int _page = 0;
  final int _size = 10;

  LandlordsNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchLandlords();
  }

  Future<void> fetchLandlords() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.getLandlords(
        page: _page,
        size: _size,
        sort: 'id,asc',
      );
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> setPage(int page) async {
    _page = page;
    await fetchLandlords();
  }

  Future<void> create(LandlordRequest request) async {
    await _repository.createLandlord(request);
    await fetchLandlords();
  }

  Future<void> update(int id, LandlordRequest request) async {
    await _repository.updateLandlord(id, request);
    await fetchLandlords();
  }

  Future<void> delete(int id) async {
    await _repository.deleteLandlord(id);
    await fetchLandlords();
  }
}
