import 'package:flutter/material.dart';

class MovieTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width*0.55,
      decoration: BoxDecoration(),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        color: const Color(0xFFE1EEF6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                    Text(
                      'TOHO CINEMAS 立川',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                SizedBox(height: MediaQuery.of(context).size.height*0.008),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                      '2023/06/14 (水) ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                      Text(
                        '16:15〜 120分',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]
                  ),

                SizedBox(height: MediaQuery.of(context).size.height*0.007),
                Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown, // 子ウィジェットを縮小して親のサイズに合わせる
                        child: Text(
                          'スパイダーマン：アクロス・ザ・スパイダーバース',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*0.007),


                 Container(
                      width: 280,
                      height: 68,
                      child:Column(
                        children: [
                          Container(
                            width: 280,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Color(0xE824292F),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                'シアター5',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFE1EEF6),
                                ),
                              ),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.01),
                                  Text(
                                    'IMAX 2D',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFFE1EEF6),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          Container(
                            width: 280,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Color(0xFFE1EEF6),
                              border: Border.all(
                                color: Color(0xFF222222),
                              ),
                            ),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                'h-12',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ]),),

                        ],
                    ),
                  ),

                SizedBox(height: MediaQuery.of(context).size.height*0.005),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(
                      '¥2,400-',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.02),
                  ],
                )
          ],
        ),
    ),

    );
  }
}
