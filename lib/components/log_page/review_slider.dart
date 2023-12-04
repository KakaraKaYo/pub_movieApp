import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
鑑賞日記録のためのカレンダーWidget
 */

final sliderValueProvider = StateProvider<double>((ref) => -0.1);

class ReviewSlider extends ConsumerWidget {
  const ReviewSlider({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final sliderValue = ref.watch(sliderValueProvider);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Text(sliderValue >= 0 ? '評価　${sliderValue.toStringAsFixed(1)}' : '未評価'),
            Expanded(
              child: Slider(
                value: sliderValue,
                inactiveColor: const Color.fromRGBO(207, 207, 207, 1),
                activeColor: const Color.fromRGBO(49, 49, 49, 1),
                thumbColor: const Color.fromRGBO(49, 49, 49, 1),
                min: -0.1,
                max: 5,
                divisions: 51, // 0.1刻みで50個の区切りがある
                onChanged: (value) {
                  // -0.1 は未評価を意味し、それ以外は通常の値として扱う
                  ref.read(sliderValueProvider.notifier).state = (value == -0.1 ? -0.1 : value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
