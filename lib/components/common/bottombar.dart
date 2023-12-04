import 'package:flutter/material.dart';


/*
カスタムしたBottomNavigationBar
 */

class BottomBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const BottomBar({super.key, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_creation_outlined),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.laptop_chromebook_sharp),
          label: 'screen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'mypage',
        ),

      ],

      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      //type: BottomNavigationBarType.shifting,//選択したものが動くようにしている
      selectedItemColor: Color.fromRGBO(22, 22, 22, 1),//選択中のアイコンカラー
      unselectedItemColor: Colors.grey[400],//未選択中のアイコンカラー
    );
  }
}
