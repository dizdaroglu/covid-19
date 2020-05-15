import 'package:covid_19/UI/shared/constants/text_style_constant.dart';
import 'package:flutter/material.dart';

class PreventionBox extends StatelessWidget {
  final String title;
  final String imageText;

  const PreventionBox({
    @required this.title,
    @required this.imageText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/$imageText.png",
            width: 40,
          ),
          Text(title, style: kPreventionIconTextStyle)
        ],
      ),
    );
  }
}
