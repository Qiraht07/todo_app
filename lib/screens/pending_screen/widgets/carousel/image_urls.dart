import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageUrls extends StatelessWidget {
  final List<String> imageUrls;

  const ImageUrls({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        enableInfiniteScroll: false,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
      ),
      items: imageUrls.map<Widget>((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
