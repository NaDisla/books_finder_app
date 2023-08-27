import 'package:flutter/material.dart';

class FavoritesBooksWidget extends StatefulWidget {
  const FavoritesBooksWidget({super.key});

  @override
  State<FavoritesBooksWidget> createState() => _FavoritesBooksWidgetState();
}

class _FavoritesBooksWidgetState extends State<FavoritesBooksWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Favorites screen'));
  }
}
