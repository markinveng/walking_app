import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walking_app/model/pie_chart_animtion_logic.dart';

class TopScreenViewModel {
  late PieChartAnimationLogic _pieChartAnimationLogic;

  void setRef(WidgetRef ref, TickerProvider tickerProvider) {
    _pieChartAnimationLogic = PieChartAnimationLogic(tickerProvider);
  }

  get durationValue => _pieChartAnimationLogic.durationValue;
  get pieChartAnimationLogic => _pieChartAnimationLogic;

  void animationInitStart() {
    _pieChartAnimationLogic.start();
  }
}
