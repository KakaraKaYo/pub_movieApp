import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewBar extends StatefulWidget {
  final double review;
  final ValueChanged<double> onRatingUpdate;


  ReviewBar({required this.review, required this.onRatingUpdate});

  @override
  _ReviewBarState createState() => _ReviewBarState();
}

class _ReviewBarState extends State<ReviewBar> {
  bool _isRatingDisplayed = false;
  bool _isButtonVisible = true;

  @override
  Widget build(BuildContext context) {
    // 「review」を小数点第２位で四捨五入し割る２にしてテキストウィジェットで表示させる処理
    String reviewText = (widget.review / 2).toStringAsFixed(1);
    double reviewPoints;

    try {
      reviewPoints = double.parse(reviewText);
    } catch (e) {
      // エラーハンドリング: 変換エラーが発生した場合にここが実行されます
      print("Error: $e");
      reviewPoints = 0.0; // エラー時のデフォルト値として0.0を設定
    }

    return Column(
      children:[
        SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // レーティングバー表示部分
          _isRatingDisplayed
              ? RatingBarIndicator(
            rating: reviewPoints, // これが表示するレーティング値です。
            itemBuilder: (context, index) =>  const Icon(
              Icons.star_sharp,
              color: Colors.yellow,
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal, // 星を縦方向に並べます
          )

          // 非表示時のスター(アウトライン)部分
              :  Row(
            children: List.generate(
              5,
                  (index) => const Icon(
                Icons.star_border_outlined,
                size: 20,
                color: Color.fromRGBO(222, 222, 222, 1),
              ),
            ),
          ),
          // スターとテキストのスペース
          const SizedBox(width: 4),
          // レビュー値表示部分
          _isRatingDisplayed
              ? Text(
            reviewText,
            style: const TextStyle(
              fontSize: 14,
            ),
          )
              : const SizedBox.shrink(),
          // 表示ボタン部分
          _isButtonVisible
              ? TextButton(
            child: const Text.rich(
              TextSpan(
                text: '表示',
                style: TextStyle(
                  color: Color.fromRGBO(123, 123, 123, 1),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            onPressed: () {
              setState(() {
                _isRatingDisplayed = true;
                _isButtonVisible = false;
              });
            },
          )
              : const SizedBox.shrink(),
        ],
      ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
