import 'package:vegetable_shop/data/models/city.dart';
import 'package:vegetable_shop/data/repository/country_cities_repository/country_cities_repository.dart';
import 'package:vegetable_shop/data/repository/country_cities_repository/data_country_cities_repository.dart';

class CountryCitiesUseCase {
  final CountryCitiesRepository _repository;

  CountryCitiesUseCase() : _repository = DataCountriesCitiesRepository();

  Future<List<City>> getCities(String countryName) => _repository.getCities(countryName);
}