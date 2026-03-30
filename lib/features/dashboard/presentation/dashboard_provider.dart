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

  const DashboardStats({
    required this.realEstates,
    required this.users,
    required this.rents,
    required this.payments,
    required this.rentedRealEstates,
    required this.vacantRealEstates,
  });
}

final dashboardStatsProvider = FutureProvider.autoDispose<DashboardStats>((ref) async {
  // Refresh provider when auth state changes (login/logout)
  ref.watch(authProvider);

  final dio = ref.watch(dioProvider);

  final response = await dio.get(ApiConstants.dashboardStats);

  return DashboardStats(
    realEstates: response.data['totalRealEstates'] as int,
    users: response.data['totalUsers'] as int,
    rents: response.data['totalRents'] as int,
    payments: response.data['totalPayments'] as int,
    rentedRealEstates: response.data['rentedRealEstates'] as int,
    vacantRealEstates: response.data['vacantRealEstates'] as int,
  );
});
