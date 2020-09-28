import 'package:vegetable_shop/data/models/country.dart';

abstract class CountriesRepository {
  Future<List<Country>> getCountries();
}