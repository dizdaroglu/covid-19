import 'dart:convert';

import 'package:covid_19/core/model/summary_country_model.dart';
import 'package:covid_19/core/model/summary_model.dart';
import 'package:http/http.dart' as http;

class DataServices {
  final String _baseUrl = "https://api.covid19api.com";

  Future<Summary> getSummary() async {
    final response = await http.get("$_baseUrl/summary");

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return Summary.fromJson(jsonResponse);
    } else {
      return Future.error(response.statusCode);
    }
  }

  Future<List<SummaryCountry>> getCitySummary(String countryName) async {
    final response = await http.get("$_baseUrl/dayone/country/$countryName");

    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body);

      return items.map((item) => SummaryCountry.fromJson(item)).toList();
    } else {
      return Future.error(response.statusCode);
    }
  }
}
