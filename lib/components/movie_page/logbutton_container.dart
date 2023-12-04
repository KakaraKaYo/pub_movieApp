import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../Page/log_page/score_tag_log_page.dart';
import '../../Page/log_page/text_review_page.dart';
import '../../Page/log_page/theater_search_page.dart';
import '../../db/database_helper.dart';
import '../log_page/calendar.dart';
import '../log_page/review_slider.dart';
import '../log_page/screen_select_cotainer.dart';
import '../log_page/seat_select_container.dart';
import '../log_page/time_drumroll.dart';
import '../log_page/watched_day_container.dart';
import '../log_page/watchstyle_container.dart';



// 映画IDを管理するためのStateProvider
final movieIdProvider = StateProvider<int?>((ref) => null);


class LogButtonContainer extends ConsumerWidget {
  final int movieId;
  const LogButtonContainer({super.key, required this.movieId});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            InkWell(
              onTap: () {

                ref.read(movieIdProvider.notifier).state = movieId;

                // selectedDateProviderとisCalendarVisibleProviderを初期値にリセット
                ref.read(selectedDateProvider.notifier).state = DateTime.now();
                ref.read(hourPickerProvider.notifier).state = -1; // 初期値にリセット
                ref.read(minutePickerProvider.notifier).state = -1; // 初期値にリセット
                ref.read(currentStateProvider.notifier).state = ContainerState.none; // 初期値にリセット
                ref.read(sliderValueProvider.notifier).state = -0.1;
                ref.read(selectedChipsProvider.notifier).state = [];
                ref.read(radioButtonProvider.notifier).state = null;

                ref.read(selectedTheaterProvider.notifier).state = null;
                ref.read(selectedScreenProvider.notifier).state = null;
                ref.read(selectedSeatProvider.notifier).state = null;
                ref.read(textReviewProvider.notifier).state = '';


                //ref.read(tappedProvider.notifier).state = false;
                context.push('/log-first/$movieId',extra: ());
              },

              child: Container(
                width: 90,
                height: 60,
                color: const Color.fromRGBO(217, 217, 217, 1),
                child:const  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Icon(Icons.visibility_outlined,color: Color.fromRGBO(22, 22, 22, 1),),
                        Text("watched"),
                  ]
                ),
              ),
            ),
            ),

            const SizedBox(width: 20,),


            InkWell(
              onTap: () async{
                Map<String, dynamic> row = {
                  DatabaseHelper.wantColumnId: movieId,
                  DatabaseHelper.wantColumnMovieId: movieId,
                  DatabaseHelper.wantColumnUpdatedAt: DateTime.now().toString(),
                  DatabaseHelper.wantColumnCreatedAt: DateTime.now().toString(),
                  DatabaseHelper.wantColumnVersionNo: 1,
                  DatabaseHelper.wantColumnIsDeleted: 0,
                };

                int newRowId = await DatabaseHelper.instance.insertWant(row);
                print('新しいレコードが追加されました。ID: $newRowId');

                // SnackBar を表示
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("wantに追加したよ。"),
                    duration: Duration(seconds: 2),  // 表示する時間
                  ),
                );
              },
              child: Container(
                width: 90,
                height: 60,
                color: Color.fromRGBO(217, 217, 217, 1),
                child:const  Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Icon(Icons.bookmarks_outlined,color: Color.fromRGBO(22, 22, 22, 1),),
                        Text("want"),
                      ]
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }
}
