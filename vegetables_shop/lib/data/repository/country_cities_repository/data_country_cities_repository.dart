import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:vegetable_shop/data/models/city.dart';
import 'package:vegetable_shop/data/repository/country_cities_repository/country_cities_repository.dart';

class DataCountriesCitiesRepository implements CountryCitiesRepository {
  static const String countriesJson =
      'json/cities.json';

  @override
  Future<List<City>> getCities(String countryName) async {
    var data = await rootBundle.loadString(countriesJson);
    final jsonResult = json.decode(data);
    List<City> countriesList = <City>[];
    for (String object in jsonResult[countryName]) {
      countriesList
          .add(City(object));
    }
    return countriesList;
  }
}