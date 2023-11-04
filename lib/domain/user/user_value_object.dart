@freezed
// user.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_value_object.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required  String name,
    required  int todayStepCount,
    required  int todayStepCountGoal,
    required  int weekStepCount,
    required  int weekStepCountGoal,
    required  int monthStepCount,
    required  int monthStepCountGoal,
  }) = _User;
}
