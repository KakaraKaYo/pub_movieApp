import 'package:flutter/material.dart';

class MovieInfoContainer extends StatelessWidget {
  final String title;
  const MovieInfoContainer({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Row(
            //mainAxisAlignment: MainAxisSize.max,
            children: [
              Container(
                width: 140,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFD8D6D6),
                ), // Added comma here
                child: Align(
                  alignment: AlignmentDirectional(1, 0),
                  child: Text(''),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TextContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            height: 20,
            decoration: BoxDecoration(
              color: Color(0xFFD8D6D6),
            ), // Added comma here
            child: Align(
              alignment: AlignmentDirectional(1, 0),
              child: Text(''),
            ),
          )
        ],
      ),
    );
  }
}
