import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class BottomNavigationBarButtonWidget extends StatelessWidget {
  final IconData? icon;
  final Color btnColor;
  final String btnText;
  final bool isImageButton;
  final bool isImageButtonSelected;
  final String? imagePath;
  final List<Shadow>? shadowList;

  const BottomNavigationBarButtonWidget({
    super.key,
    this.icon,
    required this.btnColor,
    required this.btnText,
    required this.isImageButton,
    this.imagePath,
    required this.isImageButtonSelected,
    this.shadowList,
  });

  @override
  Widget build(BuildContext context) {
    return isImageButton
        ? Column(
            children: [
              Image.asset(
                imagePath!,
                width: 28,
                height: 28,
              ),
              Text(
                btnText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: btnColor,
                ),
              ),
            ],
          )
        : isImageButtonSelected
            ? Column(
                children: [
                  SimpleShadow(
                    opacity: 0.6,
                    color: btnColor,
                    offset: const Offset(0, 5),
                    sigma: 7,
                    child: Image.asset(
                      imagePath!,
                      width: 28,
                      height: 28,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Text(
                    btnText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: btnColor,
                      shadows: shadowList,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Icon(
                    icon,
                    size: 30,
                    color: btnColor,
                    shadows: shadowList,
                  ),
                  Text(
                    btnText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: btnColor,
                      shadows: shadowList,
                    ),
                  ),
                ],
              );
  }
}
