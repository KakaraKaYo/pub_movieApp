import 'package:flutter/material.dart';

class OverviewContainer extends StatefulWidget {
  final String overview;

  OverviewContainer({required this.overview});

  @override
  _OverviewContainerState createState() => _OverviewContainerState();
}

class _OverviewContainerState extends State<OverviewContainer> {
  bool _isExpanded = false;

  bool isTextOverflowing(String text, BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
      maxLines: 4,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 30); // 30 is total horizontal padding

    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    bool _isTextOverFlowing = isTextOverflowing(widget.overview, context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 15,),
          Text(
              widget.overview,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              maxLines: _isExpanded ? null : 3,
              softWrap: true,
            ),
          if (_isTextOverFlowing)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  child: Text.rich(
                    TextSpan(
                      text: _isExpanded ? '閉じる' : '続きを読む',
                      style: const TextStyle(
                        color: Color.fromRGBO(123, 123, 123, 1),
                        decoration: TextDecoration.underline,  // アンダーラインを追加
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),

              ],
            ),
        ],
    );
  }
}
