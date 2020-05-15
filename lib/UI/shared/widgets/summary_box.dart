import 'package:covid_19/UI/shared/constants/text_style_constant.dart';
import 'package:flutter/material.dart';

class SummaryBox extends StatelessWidget {
  final Color color;
  final String title;
  final String count;

  const SummaryBox({
    @required this.color,
    @required this.title,
    @required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            "$title",
            style: kBoxTitleTextStyle,
          ),
          Text(
            "$count",
            style: kBoxTitleTextStyle,
          )
        ],
      ),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    );
  }
}
