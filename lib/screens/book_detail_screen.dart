import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transparent_image/transparent_image.dart';

class BookDetailScreen extends StatelessWidget {
  final String? image;
  const BookDetailScreen({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
        ),
        title: Row(
          children: [
            Lottie.asset(
              'assets/icon-home.json',
              width: 90.0,
              height: 90.0,
            ),
            Text(
              'BooksFinder',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF786C44),
                fontStyle: FontStyle.normal,
                shadows: <Shadow>[
                  Shadow(
                      color: Colors.black,
                      blurRadius: 4.0,
                      offset: Offset(0, 4))
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.7),
        elevation: 0,
      ),
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.red.withOpacity(0.5),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'book-image',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: image!,
                      fit: BoxFit.fill,
                      width: 180,
                    ),
                  ),
                ),
                Text('Prueba'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
