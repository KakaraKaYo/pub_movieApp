import 'package:flutter/material.dart';


class CastImage extends StatelessWidget {
  final dynamic casts;


  CastImage({required this.casts, });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:86,
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child:Container(
                width:86,
                height: 114,
                child: casts["profile_path"] != null
                    ? Image.network(
                  'https://image.tmdb.org/t/p/original' + casts["profile_path"],
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

                      Text(casts["name"],
                        style: const TextStyle(
                          fontSize: 12
                        ),
                        overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,),
                      Text(casts["character"],
                          style: const TextStyle(
                              fontSize: 10,
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