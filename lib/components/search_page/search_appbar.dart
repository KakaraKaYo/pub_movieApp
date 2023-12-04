import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../Page/search_page/searching_page.dart';

class SearchAppbar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: InkWell(
          onTap: () {
            ref.read(searchTextProvider.notifier).state = '';
            context.go('/searching');

          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(231, 231, 231, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Color.fromRGBO(120, 120, 120, 1)),
                  SizedBox(width: 10),
                  Text(
                    '作品検索',
                    style: TextStyle(color: Color.fromRGBO(120, 120, 120, 1), fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56); // AppBarの高さを指定
}
