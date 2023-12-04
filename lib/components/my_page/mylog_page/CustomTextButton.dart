import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String Buttontext;

  const CustomTextButton({required this.Buttontext});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              width: 140,
              child: Align(
                alignment: AlignmentDirectional(1, 0),
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  child: Text(
                    Buttontext,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
