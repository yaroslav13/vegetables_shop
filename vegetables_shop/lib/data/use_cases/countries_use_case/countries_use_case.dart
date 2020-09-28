import 'package:vegetable_shop/data/models/country.dart';
import 'package:vegetable_shop/data/repository/country_repository/countries_repository.dart';
import 'package:vegetable_shop/data/repository/country_repository/data_countries_repository.dart';

class CountriesUseCase {
  final CountriesRepository _repository;

  CountriesUseCase() : _repository = DataCountriesRepository();

  Future<List<Country>> getCountries() => _repository.getCountries();
}
