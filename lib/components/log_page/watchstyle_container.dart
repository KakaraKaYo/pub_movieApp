import 'package:dup_movielist/components/log_page/screen_select_cotainer.dart';
import 'package:dup_movielist/components/log_page/seat_select_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../Page/log_page/theater_search_page.dart';

final radioButtonProvider = StateProvider<String?>((ref) => null);

class WatchStyleContainer extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //選択されている鑑賞方法を監視
    String? groupValue = ref.watch(radioButtonProvider);

    final selectedTheater = ref.watch(selectedTheaterProvider);
    final selectedScreen = ref.watch(selectedScreenProvider);
    final selectedSeat = ref.watch(selectedSeatProvider);


    // 映画館が選択されているかどうかをチェック
    bool isTheaterSelected = groupValue == '映画館';
    bool isPreviewTheaterSelected = groupValue == '試写会';



    return Column(
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
        child:Row(
          children: [
            Text('鑑賞方法')
          ],
        ),
        ),
        _buildRadioListTile(ref, '映画館', '映画館', groupValue),
        Visibility(
          visible: isTheaterSelected,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(65, 0, 0, 0),
            child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        context.push('/theater-searching');
                      },
                      child: Text(
                        (selectedTheater != null || selectedScreen != null || selectedSeat != null)
                            ? '${selectedTheater ?? ""}${selectedScreen != null ? "｜$selectedScreen" : ""}${selectedSeat != null ? "｜$selectedSeat" : ""}｜IMAX2D'
                            : '詳細情報',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(132, 132, 132, 1),
                            decoration: TextDecoration.underline
                        ),
                      ),
                  ),
                ]
            ),
          ),
        ),
        _buildRadioListTile(ref, '動画配信サービス', '動画配信サービス', groupValue),
        _buildRadioListTile(ref, 'DVD/Blue-ray', 'DVD/Blue-ray', groupValue),
        _buildRadioListTile(ref, '試写会', '試写会', groupValue),
        Visibility(
          visible: isPreviewTheaterSelected,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(65, 0, 0, 0),
            child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        context.push('/theater-searching');
                      },
                      child: Text(
                        (selectedTheater != null || selectedScreen != null || selectedSeat != null)
                            ? '${selectedTheater ?? ""}${selectedScreen != null ? "｜$selectedScreen" : ""}${selectedSeat != null ? "｜$selectedSeat" : ""}｜IMAX2D'
                            : '詳細情報',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(132, 132, 132, 1),
                            decoration: TextDecoration.underline
                        ),
                      ),
                  ),
                ]
            ),
          ),
        ),
        _buildRadioListTile(ref, 'TV', 'TV', groupValue),
        _buildRadioListTile(ref, '飛行機', '飛行機', groupValue),
        _buildRadioListTile(ref, 'その他', 'その他', groupValue),
      ],
    );
  }

  Widget _buildRadioListTile(WidgetRef ref, String title, String value, String? groupValue) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: groupValue,
      activeColor: const Color.fromRGBO(0, 0, 0, 1),
      onChanged: (String? newValue) {
        if (newValue != null) {
          ref.read(radioButtonProvider.notifier).state = newValue;
        }
      },
    );
  }
}
