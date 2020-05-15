import 'package:covid_19/UI/screens/second_screen.dart';
import 'package:covid_19/UI/shared/constants/color_constants.dart';
import 'package:covid_19/UI/shared/constants/text_style_constant.dart';
import 'package:covid_19/UI/shared/widgets/prevention_box.dart';
import 'package:covid_19/UI/shared/widgets/summary_box.dart';
import 'package:covid_19/core/data_services.dart';
import 'package:covid_19/core/model/summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _service = DataServices();
  Future<Summary> summary;

  @override
  void initState() {
    summary = _service.getSummary();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<Summary>(
          future: summary,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("An error occurred "));
            }
            if (snapshot.hasData) {
              final summary = snapshot.data.global;

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
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
                                          builder: (context) => SecondScreen(
                                              summary: snapshot.data)));
                                },
                                child:
                                    SvgPicture.asset("assets/icons/menu.svg")),
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
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Global",
                              style: kGlobalTitleTextStyle,
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: size.width / (size.height / 4),
                              children: <Widget>[
                                SummaryBox(
                                    title: "Total Cases",
                                    color: confirmedBoxColor,
                                    count: "${summary.totalConfirmed}"),
                                SummaryBox(
                                  title: "Active Cases",
                                  color: activeBoxColor,
                                  count:
                                      "${summary.totalConfirmed - (summary.totalRecovered - summary.totalDeaths)}",
                                ),
                                SummaryBox(
                                  title: "Recovered Cases",
                                  color: recoveredBoxColor,
                                  count: "${summary.totalRecovered}",
                                ),
                                SummaryBox(
                                  title: "Deaths",
                                  color: deceasedBoxColor,
                                  count: "${summary.totalDeaths}",
                                ),
                              ],
                            )
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Prevention",
                            style: kPreventionTitleTextStyle,
                          ),
                          GridView.count(
                            padding: EdgeInsets.only(top: 10),
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: size.width / (size.height / 3),
                            children: <Widget>[
                              PreventionBox(
                                imageText: "home",
                                title: "Stay at home",
                              ),
                              PreventionBox(
                                imageText: "keep",
                                title: "Keep a safe \ndistance",
                              ),
                              PreventionBox(
                                imageText: "wash",
                                title: "Wash hands often",
                              ),
                              PreventionBox(
                                imageText: "sneezes",
                                title: "Cover coughs \nand sneezes",
                              ),
                              PreventionBox(
                                imageText: "facemask",
                                title: "Wear facemask \nif you are sick",
                              ),
                              PreventionBox(
                                imageText: "clean",
                                title: "Clean and \ndisinfect",
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(backgroundColor),
              ),
            );
          }),
    );
  }
}
