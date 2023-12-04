import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewBar extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onRatingUpdate;

  ReviewBar({this.rating = 0.0, required this.onRatingUpdate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "評価",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              rating.toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RatingBar.builder(
                onRatingUpdate: onRatingUpdate,
                itemBuilder: (context, index) => Icon(
                  Icons.star_rounded,
                  color: Colors.yellow,
                ),
                initialRating: rating,
                unratedColor: Theme.of(context).disabledColor,
                itemCount: 5,
                itemSize: 40,
                glowColor: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
