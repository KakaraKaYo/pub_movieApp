import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class StyleSelectContainer extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
        child:  Column(
          children: [
            Row(
              children: [
                Text('上映形式',style: TextStyle(),),
              ],
            ),
            Wrap(
              children: [
                Container(
                  width: 80,
                  height: 50,
                  color: Colors.black,
                  child: Center(
                    child: Text('IMAX',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            )
          ],
      ),
    );
  }
}