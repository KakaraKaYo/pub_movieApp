import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

/*
moviedetails_pageのYouTube動画リストを個性するcomponent
 */


//youtubeの設定
final youtubePlayerControllerProvider = Provider.family<YoutubePlayerController, String>(
      (ref, videoId) => YoutubePlayerController.fromVideoId(
    videoId: videoId,
    params: const YoutubePlayerParams(
      showControls: true,
      showFullscreenButton: true,
    ),
  ),
);


class GalleryRow extends ConsumerWidget {
  final List<dynamic>? videos;
  final List<dynamic>? images;
  const GalleryRow({Key? key, required this.videos, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> galleryItems = [];
    int maxItems = 15; // 最大アイテム数
    int maxIndex = max(videos?.length ?? 0, images?.length ?? 0); // 動画と画像の最大インデックスを計算

    for (int i = 0; i < maxIndex && galleryItems.length < maxItems; i++) {
      // 動画の追加
      if (i < videos!.length) {
        final video = videos![i];
        final _controller = ref.watch(youtubePlayerControllerProvider(video['key']));
        galleryItems.add(
          Padding(
            padding: const EdgeInsets.only(right: 10), // 右に隙間を設定
            child: YoutubeVideoContainer(controller: _controller, videoTitle: video['name']),
          ),
        );
      }

      // 画像の追加
      if (i < images!.length) {
        final image = images![i];
        final imageUrl = 'https://image.tmdb.org/t/p/original${image['file_path']}';
        galleryItems.add(
          Padding(
            padding: const EdgeInsets.only(right: 10), // 右に隙間を設定
            child: Container(
              width: 220,
              height: 123.6, // 画像の高さを動画の高さに合わせる
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover, // 画像をコンテナのサイズに合わせて調整
            ),
              ]
            ),
            ),
          ),
        );
      }
    }

    return Column(
      children: [
        const SizedBox(height: 40),
        const Row(
          children: [
            Text(
              "ギャラリー",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: galleryItems,
          ),
        ),
      ],
    );
  }

  int max(int a, int b) => (a > b) ? a : b; // 最大値を返すヘルパー関数
}


// YoutubeVideoContainerクラスを内部クラスとして定義
class YoutubeVideoContainer extends StatelessWidget {
  final YoutubePlayerController controller;
  final String videoTitle;

  const YoutubeVideoContainer({Key? key, required this.controller, required this.videoTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 123.6, // 動画の高さをアスペクト比に基づいて設定
            width: 220,
            child: YoutubePlayerScaffold(
            controller: controller,
            //aspectRatio: 16 / 9,
            builder: (context, player) => player,
          ),
          ),
          Text(videoTitle, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}