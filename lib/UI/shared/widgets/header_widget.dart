import 'package:covid_19/UI/screens/second_screen.dart';
import 'package:covid_19/UI/shared/constants/color_constants.dart';
import 'package:covid_19/UI/shared/constants/text_style_constant.dart';
import 'package:covid_19/core/model/summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderWidget extends StatefulWidget {
  final List<Countries> data;

  const HeaderWidget({this.data});
  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  void initState() {
    print(widget.data[1]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, right: 20, left: 20),
      height: 260,
      width: double.infinity,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SecondScreen(summary: widget.data)));
                },
                child: SvgPicture.asset("assets/icons/menu.svg")),
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Covid-19",
                    style: hHeadingTextStyle,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Symptoms",
                    style: hHeadingTitleTextStyle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "People may be sick with \nthe virus for 1 to 14 days \nbefore developing symptoms.",
                    style: hHeadingSubTitleTextStyle,
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.1),
                    borderRadius: BorderRadius.circular(200)),
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/group.png",
                  height: 150,
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
