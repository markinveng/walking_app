import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';

final healthDataProvider = FutureProvider<List<HealthDataPoint>>((ref) async {
  final health = HealthFactory();
  final now = DateTime.now();
  final start = DateTime(now.year, now.month, now.day);
  final end = now;

  final permissions = [
    HealthDataType.STEPS,
  ];

  try {
    // HealthKitのアクセス許可を要求
    bool authorized = await health.requestAuthorization(permissions);
    if (authorized) {
      // 歩数データを取得
      final results =
          await health.getHealthDataFromTypes(start, end, permissions);
      return results;
    } else {
      throw Exception('HealthKitのアクセスが許可されていません。');
    }
  } catch (e) {
    throw Exception('データの取得中にエラーが発生しました。: $e');
  }
});
