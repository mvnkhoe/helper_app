import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    super.key,
    required this.imageList,
    required this.carouselMessages,
  });

  final List<String> imageList;
  final List<String> carouselMessages;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageList.length,
      itemBuilder: (context, index, realIndex) {
        return Stack(
          children: [
            Image.asset(
              imageList[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            Positioned(
              bottom: 30, // Adjusted text position for better visibility
              left: 20,
              right: 20,
              child: Container(
                // decoration:
                //     BoxDecoration(borderRadius: BorderRadius.circular(8)),
                color: Colors.black.withOpacity(0.6),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
                child: Text(
                  carouselMessages[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5), // Adjust autoPlay interval
        autoPlayAnimationDuration:
            Duration(milliseconds: 1000), // Smooth transition duration
        enlargeCenterPage: true, // Enlarge the center item
        aspectRatio: 16 / 9,
        viewportFraction: 1.0, // Full-width images
        scrollPhysics: BouncingScrollPhysics(), // Bouncy effect for the scroll
      ),
    );
  }
}
