import 'package:vegetable_shop/data/models/city.dart';

abstract class CountryCitiesRepository{
  Future<List<City>> getCities(String countryName);
}