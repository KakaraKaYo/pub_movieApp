import 'package:dotted_border/dotted_border.dart';
import 'package:dup_movielist/components/common/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../components/log_page/review_slider.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';

// Reviewクラスの定義

final bottomBarControllerProvider = Provider<BottomBarWithSheetController>((ref) {
  return BottomBarWithSheetController(initialIndex: 0);
});

final selectedChipsProvider = StateProvider<List<String>>((ref) => []);



class ScoreTagLogPage extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("レビュー",style: TextStyle(color: Colors.black,fontSize: 16),),
        centerTitle: true,
        leading:  IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          color: const Color.fromRGBO(34, 34, 34, 1),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          TextButton(onPressed:(){
            context.push('/text-review');
          },
              style: TextButton.styleFrom(
                  primary: Colors.black, // テキストの色
                  splashFactory: NoSplash.splashFactory// エフェクトを削除
              ),
              child:const Text("次へ",
                style: TextStyle(
                  decoration:TextDecoration.underline ,
                ),))],
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0), // 線の高さを設定
          child: Divider(
            height: 1.0,
            thickness: 1.0,
            color: Color.fromRGBO(210, 210, 210, 1), // 線の色を設定
          ),
        ),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Column(
              children:[
                ReviewSlider(),//評価数を記録するWidget
                CustomDivider(),
              ]
          ),
          Expanded(
            child:InkWell(
              onTap: (){
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    // ここにモーダルシートの中身を記述
                    return ChipModalSheet();
                  },
                  barrierColor: Colors.transparent, // 背景色を透明に設定
                );

              }
              ,
            child:Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
              child:Consumer(
                builder: (context, ref, child) {
                  final selectedChips = ref.watch(selectedChipsProvider);
                  if (selectedChips.isEmpty) {
                    // selectedChipsが空の場合に表示するウィジェット
                    return NoChipDisplay();
                  } else {
                    // selectedChipsに内容がある場合にSelectedChipsDisplayを表示
                    return Container(
                        child: SelectedChipsDisplay(),
                    );
                  }
                },
              ),
            ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}


class NoChipDisplay extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
        children:[DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        padding: const EdgeInsets.all(6),
        dashPattern: [8, 4],
        strokeWidth: 1,
        color: Colors.black,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: const Center(
            child: Text("画面をタップしてタグを追加しよう"),
          ),
        ),
    ),]);
  }
}


class FruitsChips extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 8.0, // チップ間の水平スペース
      runSpacing: 4.0, // チップ間の垂直スペース
      children: [
        _buildChip('いちじく', ref),
        _buildChip('りんご', ref),
        _buildChip('ぶどう', ref),
        _buildChip('グレープフルーツ', ref),
        _buildChip('れもん', ref),
        _buildChip('もも', ref),
        _buildChip('マスカット', ref),
        _buildChip('メロン', ref),
        _buildChip('いちご', ref),
        _buildChip('スイカ', ref),
        // 他のチップを追加する場合はここに追加します
      ],
    );
  }

  Widget _buildChip(String label, WidgetRef ref) {
    var currentChips = ref.watch(selectedChipsProvider);
    bool isSelected = currentChips.contains(label);

    return GestureDetector(
      onTap: isSelected ? null : () {
        var updatedChips = ref.read(selectedChipsProvider.notifier).state;
        if (!updatedChips.contains(label)) {
          updatedChips.add(label);
          ref.read(selectedChipsProvider.notifier).state = List.from(updatedChips);
        }
      },
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? Colors.grey : Colors.lightBlueAccent, // 選択済みの場合はグレーに
        labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white),
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}


class AnimalChips extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 8.0, // チップ間の水平スペース
      runSpacing: 4.0, // チップ間の垂直スペース
      children: [
        _buildChip('犬', ref),
        _buildChip('ねこ', ref),
        _buildChip('チンパンジー', ref),
        _buildChip('コアラ', ref),
        _buildChip('かば', ref),
        _buildChip('バファロー', ref),
        _buildChip('リス', ref),
        _buildChip('象', ref),
        _buildChip('アルパカ', ref),
        _buildChip('アルマジロ', ref),
        // 他のチップを追加する場合はここに追加します
      ],
    );
  }

  Widget _buildChip(String label, WidgetRef ref) {
    var currentChips = ref.watch(selectedChipsProvider);
    bool isSelected = currentChips.contains(label);

    return GestureDetector(
      onTap: isSelected ? null : () {
        var updatedChips = ref.read(selectedChipsProvider.notifier).state;
        if (!updatedChips.contains(label)) {
          updatedChips.add(label);
          ref.read(selectedChipsProvider.notifier).state = List.from(updatedChips);
        }
      },
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? Colors.grey : Colors.lightBlueAccent, // 選択済みの場合はグレーに
        labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white),
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}

class SelectedChipsDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedChips = ref.watch(selectedChipsProvider);
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.centerLeft, // 左端からの配置に設定
        child: Wrap(
          spacing: 8.0, // チップ間の水平スペース
          runSpacing: 4.0, // チップ間の垂直スペース
          children: selectedChips.map((chipText) {
            return GestureDetector(
              onTap: () {
                var updatedChips = List<String>.from(selectedChips);
                updatedChips.remove(chipText);
                ref.read(selectedChipsProvider.notifier).state = updatedChips;
              },
              child: Chip(
                label: Text(chipText),
                backgroundColor: Colors.lightBlueAccent, // チップの背景色
                labelStyle: TextStyle(color: Colors.white), // テキストの色
                padding: EdgeInsets.all(8.0), // チップ内のパディング
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}


class ChipModalSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        color: Colors.white,
        child: Column(
          children: [
            CustomDivider(),
            const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.camera)),
                Tab(icon: Icon(Icons.music_note)),
                Tab(icon: Icon(Icons.people)),
                Tab(icon: Icon(Icons.pan_tool)),
              ],
            ),
            CustomDivider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                child: TabBarView(
                  children: [
                    FruitsChips(), // チップ選択ウィジェット
                    AnimalChips(),
                    Center(child: Text('通知の内容')),
                    Center(child: Text('プロフィールの内容')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}