import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walking_app/components/pieChart/pie_chart.dart';

import '../service/healthkit_sevice.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 37, 64),
      appBar: AppBar(
          title: const Text('目標設定'),
          backgroundColor: Color.fromARGB(255, 42, 54, 86)),
      body: Center(
        child: Container(
          width: size.width,
          height: size.height * 0.9,
          child: Consumer(builder: (context, watch, _) {
            final stepCount = 10001;
            final targetStepCount = 10000;
            return AnimationArc(
                stepCount: stepCount, targetStepCount: targetStepCount);
          }),
          // child: Consumer(
          //   builder: (context, ref, _) {
          //     final healthData = ref.watch(healthDataProvider);

          //   return healthData.when(
          //     data: (data) {
          //       // 歩数データを処理するコード
          //       return Text('Total steps: ${data.length}');
          //     },
          //     loading: () => CircularProgressIndicator(),
          //     error: (error, stackTrace) => Text('Error: $error'),
          //   );
          //   },
          // )
        ),
      ),
    );
  }
}
