import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walking_app/ViewModel/top_screen_view_model.dart';

import '../components/pie_chart.dart';
import '../../service/healthkit_sevice.dart';

class TopScreen extends ConsumerStatefulWidget {
  final TopScreenViewModel viewModel;
  TopScreen(
    this.viewModel, {
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<TopScreen> createState() => _TopScreen();
}

class _TopScreen extends ConsumerState<TopScreen>
    with TickerProviderStateMixin {
  late TopScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
    _viewModel.setRef(ref, this);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _viewModel.animationInitStart();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 37, 64),
      body: Center(
        child: SizedBox(
          width: size.width,
          height: size.height * 0.9,
          child: Consumer(
            builder: (context, ref, _) {
              final healthData = ref.watch(healthDataProvider);
              final stepCount = ref.watch(healthDataProvider);
              final targetStepCount = 10000;
              return healthData.when(
                data: (data) {
                  return AnimationArc(
                    stepCount: 5000,
                    targetStepCount: targetStepCount,
                    //durationValueが変化しないので、一旦1.0にする
                    //durationValue: _viewModel.durationValue,
                    durationValue: 1.0,
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
              );
            },
          ),
        ),
      ),
    );
    ;
  }
}
