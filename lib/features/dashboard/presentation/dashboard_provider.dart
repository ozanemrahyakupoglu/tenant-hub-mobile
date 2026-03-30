import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tenant_hub_mobile/core/network/dio_client.dart';
import 'package:tenant_hub_mobile/core/constants/api_constants.dart';

class DashboardStats {
  final int realEstates;
  final int users;
  final int rents;
  final int payments;

  const DashboardStats({
    required this.realEstates,
    required this.users,
    required this.rents,
    required this.payments,
  });
}

final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.get(ApiConstants.dashboardStats);

  return DashboardStats(
    realEstates: response.data['totalRealEstates'] as int,
    users: response.data['totalUsers'] as int,
    rents: response.data['totalRents'] as int,
    payments: response.data['totalPayments'] as int,
  );
});
