import 'package:flutter/animation.dart';

class PieChartAnimationLogic {
  late AnimationController _animationController;
  late Animation<int> _pieChartAnimation;
  late double _durationValue;

  PieChartAnimationLogic(TickerProvider tickerProvider) {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: tickerProvider,
    )..addListener(() {
        _animationController.forward();
      });

    _pieChartAnimation = _animationController
        .drive(CurveTween(curve: Curves.easeInOut))
        .drive(Tween(begin: 0, end: 1));

    _durationValue = _animationController.value;
  }

  get animationController => _animationController;
  get pieChartAnimation => _pieChartAnimation;
  get durationValue => _durationValue;

  void start() {
    _animationController
        .forward()
        .whenComplete(() => _animationController.reset());
  }

  // @override
  // void initializeStart() {
  //    _animationController.addListener(() {
  //     setState(() {});
  //   });
  // }

  void dispose() {
    _animationController.dispose();
  }
}
