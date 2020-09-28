import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:vegetable_shop/data/models/country.dart';

import 'countries_repository.dart';

class DataCountriesRepository implements CountriesRepository {
  static const String countriesJson =
      'json/countries.json';

  @override
  Future<List<Country>> getCountries() async {
    var data = await rootBundle.loadString(countriesJson);
    final jsonResult = json.decode(data);
    List<Country> countriesList = <Country>[];
    for (dynamic object in jsonResult[_kCountries]) {
      countriesList
          .add(Country(object[_kName], object[_kDialCode], object[_kCode]));
    }
    return countriesList;
  }
}

final String _kCode = 'code';
final String _kName = 'name';
final String _kDialCode = 'dial_code';
final String _kCountries = 'countries';
