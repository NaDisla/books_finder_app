import 'package:flutter/material.dart';

class SwitchLanguageWidget extends StatelessWidget {
  final Function translate;
  final bool isEnglish;

  const SwitchLanguageWidget({
    super.key,
    required this.translate,
    required this.isEnglish,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          onChanged: (bool value) {
            translate(value);
          },
          value: isEnglish,
          activeColor: Colors.white,
          inactiveTrackColor: Colors.white54,
          activeThumbImage: Image.asset('assets/images/us_icon.png', scale: 17.0).image,
          inactiveThumbImage: Image.asset('assets/images/es_icon.png', scale: 17.0).image,
        ),
      ),
    );
  }
}
