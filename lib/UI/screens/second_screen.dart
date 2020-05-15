import 'package:covid_19/UI/shared/constants/color_constants.dart';
import 'package:covid_19/UI/shared/constants/text_style_constant.dart';
import 'package:covid_19/UI/shared/widgets/chart.dart';
import 'package:covid_19/UI/shared/widgets/summary_box.dart';
import 'package:covid_19/core/data_services.dart';
import 'package:covid_19/core/model/summary_country_model.dart';
import 'package:covid_19/core/model/summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class SecondScreen extends StatefulWidget {
  final summary;

  const SecondScreen({this.summary});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Countries country;
  List<Countries> get countries => widget.summary.countries;

  Future<List<SummaryCountry>> cityData;
  final _service = DataServices();

  @override
  void initState() {
    selectCountry(countries[2]);
    cityData = _service.getCitySummary("algeria");

    super.initState();
  }

  selectCountry(Countries newCountry) {
    setState(() {
      country = newCountry;
      cityData = _service.getCitySummary(newCountry.country);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          /*   bottom: new PreferredSize(
              child: new Container(
                padding: const EdgeInsets.all(0),
              ),
              preferredSize: const Size.fromHeight(20.0)),
              */
          backgroundColor: backgroundColor,
        ),
        body: FutureBuilder<List<SummaryCountry>>(
            future: cityData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("hata");
              }
              if (snapshot.hasData) {
                final summary = snapshot.data;

                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 15, right: 20, left: 20),
                        height: 380,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Statistics",
                              style: hHeadingTextStyle,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Color(0XFFFFFFFF),
                                  border: Border.all(
                                      width: 1.00, color: Color(0XFFE5E5E5)),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    "assets/icons/maps-and-flags.svg",
                                    color: backgroundColor,
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                      child: DropdownButton(
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          icon: SvgPicture.asset(
                                            "assets/icons/dropdown.svg",
                                            color: backgroundColor,
                                          ),
                                          value: country,
                                          onChanged: selectCountry,
                                          items: countries
                                              .map<DropdownMenuItem<Countries>>(
                                                  (Countries value) {
                                            return DropdownMenuItem<Countries>(
                                                value: value,
                                                child: Text(value.country));
                                          }).toList()))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: size.width / (size.height / 4),
                              children: <Widget>[
                                SummaryBox(
                                  title: "Total Cases",
                                  color: confirmedBoxColor,
                                  count: summary[summary.length - 1]
                                      .confirmed
                                      .toString(),
                                ),
                                SummaryBox(
                                  title: "Active Cases",
                                  color: activeBoxColor,
                                  count: summary[summary.length - 1]
                                      .active
                                      .toString(),
                                ),
                                SummaryBox(
                                  title: "Recovered Cases",
                                  color: recoveredBoxColor,
                                  count: summary[summary.length - 1]
                                      .recovered
                                      .toString(),
                                ),
                                SummaryBox(
                                  title: "Deaths",
                                  color: deceasedBoxColor,
                                  count: summary[summary.length - 1]
                                      .deaths
                                      .toString(),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Last 7 Days Deaths",
                        style: TextStyle(
                            color: Color(0xFF0E3360),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "NotoSans-Bold"),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: BarChartSample(
                              countryName: country.country,
                              data: snapshot.data),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(backgroundColor),
                ),
              );
            }));
  }
}
