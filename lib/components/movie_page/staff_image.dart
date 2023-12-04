import 'package:flutter/material.dart';


class StaffImage extends StatelessWidget {
  final dynamic crews;


  StaffImage({required this.crews, });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 86,
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child:
              Container(
                width: 86,
                height: 114,
                child: crews["profile_path"] != null
                  ? Image.network(
                'https://image.tmdb.org/t/p/original' + crews["profile_path"],
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/images/your_error_image.png',
                      fit: BoxFit.cover,
                    );
                  },
                )
                    : Image.asset(
                  'assets/castimage_error.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

              Text(crews["name"],
                style: TextStyle(
                    fontSize: 12
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,),
              Text(crews["known_for_department"],
                style: TextStyle(
                    fontSize: 10,
                    //color: Colors.white,
                    color: Color.fromRGBO(123, 123, 123, 1)
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,),
            ]
        ),
    );
  }
}