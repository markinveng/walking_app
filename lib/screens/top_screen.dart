import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/pieChart/pie_chart.dart';
import '../service/healthkit_sevice.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                  //final stepCount = healthData.
                  // 歩数データを処理するコード
                  print(data.length);
                  return const AnimationArc(
                    stepCount: 5000,
                    targetStepCount: 10000,
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
