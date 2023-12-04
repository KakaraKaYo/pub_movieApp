import 'package:flutter/material.dart';

class TagIcon extends StatelessWidget {
  final String text;
  final Color tagColor;
  final Color textColor;

  const TagIcon({
    required this.text,
    required this.tagColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 3, 3),
      child: Material(
        color: Colors.transparent,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Container(
          width: 68,
          height: 30,
          decoration: BoxDecoration(
            color: tagColor,
            borderRadius: BorderRadius.circular(32),
          ),
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
