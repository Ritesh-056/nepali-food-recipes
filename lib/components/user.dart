import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nepali_food_recipes/constants.dart';

class Info extends StatelessWidget {
  const Info({
    this.name = 'John Doe',
    this.email = 'xyz@gmail.com',
    this.imageURL =
        'https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png',
  });
  final String name, email, imageURL;
  @override
  Widget build(BuildContext context) {
    double defaultSize = 15;
    return SizedBox(
      height: defaultSize * 24, // 240
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: defaultSize * 15, //150
              color: kPrimaryColor,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CachedNetworkImage(
                    placeholder: (context, url) =>
                        Image.asset('images/profile_loading.png'),
                    imageBuilder: (context, imageProvider) => Container(
                          margin: EdgeInsets.only(bottom: defaultSize), //10
                          height: defaultSize * 14, //140
                          width: defaultSize * 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: defaultSize * 0.8, //8
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        ),
                    imageUrl: imageURL),

                Text(
                  name,
                  style: TextStyle(
                    fontSize: defaultSize * 2.2,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    // 22
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: defaultSize / 3), //5
                Text(
                  email,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: kSecondaryTextColor,
                      letterSpacing: 1.3),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
