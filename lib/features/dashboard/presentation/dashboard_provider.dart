import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_hub_mobile/core/network/dio_client.dart';
import 'package:tenant_hub_mobile/core/constants/api_constants.dart';
import 'package:tenant_hub_mobile/features/auth/presentation/auth_provider.dart';

class DashboardStats {
  final int realEstates;
  final int users;
  final int rents;
  final int payments;
  final int rentedRealEstates;
  final int vacantRealEstates;
  final int tenants;
  final int landlords;

  const DashboardStats({
    required this.realEstates,
    required this.users,
    required this.rents,
    required this.payments,
    required this.rentedRealEstates,
    required this.vacantRealEstates,
    required this.tenants,
    required this.landlords,
  });
}

final dashboardStatsProvider = FutureProvider.autoDispose<DashboardStats>((ref) async {
  // Use select to watch only the user value, not the loading state.
  // Without select, authProvider.loading (set at login start) also triggers this
  // provider before the token is saved → 403. With select, only null→user
  // transition triggers a rebuild (null→null is equal, so loading state is ignored).
  final user = ref.watch(authProvider.select((s) => s.valueOrNull));

  if (user == null) {
    throw Exception('Not authenticated');
  }

  final dio = ref.watch(dioProvider);

  final response = await dio.get(ApiConstants.dashboardStats);

  return DashboardStats(
    realEstates: response.data['totalRealEstates'] as int,
    users: response.data['totalUsers'] as int,
    rents: response.data['totalRents'] as int,
    payments: response.data['totalPayments'] as int,
    rentedRealEstates: response.data['rentedRealEstates'] as int,
    vacantRealEstates: response.data['vacantRealEstates'] as int,
    tenants: (response.data['totalTenants'] as int?) ?? 0,
    landlords: (response.data['totalLandlords'] as int?) ?? 0,
  );
});
