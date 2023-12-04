import 'package:dup_movielist/components/my_page/mylog_page/FilterDateSwitchRow.dart';
import 'package:flutter/material.dart';
import 'FiliterMovieSwitchRow.dart';

class FilterModalBottomSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.tune),
      iconSize: 35,
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            '表示設定',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            ),),

                          Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              '決定',
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Color.fromRGBO(52, 53, 81, 0.11),
                      width: MediaQuery.of(context).size.width,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*0.03),
                          FilterMovieSwitchRow(),
                          FilterDateSwitchRow(),

                          SizedBox(height: MediaQuery.of(context).size.height*0.02),
                          //FilterDateSwitchRow(),

                        ],
                      ),),

                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
