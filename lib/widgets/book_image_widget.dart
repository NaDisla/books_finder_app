import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

Widget BookImageWidget({required String thumbnail}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: thumbnail,
        fit: BoxFit.fill,
        width: 100,
      ),
    ),
  );
}
