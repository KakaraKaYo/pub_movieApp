import 'package:flutter/material.dart';

class ThumbnailCard extends StatelessWidget {
  final String posterUrl;

  ThumbnailCard({required this.posterUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.height * 0.3,
          height: MediaQuery.of(context).size.height * 0.45,
          child: Image.network(
            posterUrl,
            fit: BoxFit.cover,
          ),
        ),
    );
  }
}
