import 'package:rxdart/rxdart.dart';
import 'package:vegetable_shop/data/models/country.dart';
import 'package:vegetable_shop/data/models/city.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/data/repository/user_repository/data_user_repository.dart';
import 'package:vegetable_shop/data/repository/user_repository/user_repository.dart';
import 'package:vegetable_shop/data/use_cases/countries_use_case/countries_use_case.dart';
import 'package:vegetable_shop/data/use_cases/country_cities_use_case/country_cities_use_case.dart';

import '../base_bloc.dart';

class RegistrationBloc extends BaseBloc {
  static const String defaultCountryCode = 'ua';
  static const String defaultCountryName = 'Ukraine';

  final CountriesUseCase _countriesUseCase = CountriesUseCase();
  final CountryCitiesUseCase _citiesUseCase = CountryCitiesUseCase();
  final UserRepository _userRepository = DataUserRepository();

  PublishSubject<List<Country>> searchInCountryStream =
      PublishSubject<List<Country>>();
  BehaviorSubject<Country> currentCountry = BehaviorSubject<Country>();

  PublishSubject<List<City>> searchInCitiesStream =
      PublishSubject<List<City>>();
  BehaviorSubject<City> currentCity = BehaviorSubject<City>();

  List<Country> countriesList = <Country>[];
  List<City> citiesList = <City>[];

  @override
  void dispose() {
    searchInCountryStream.close();
    searchInCitiesStream.close();
    currentCountry.close();
    currentCity.close();
  }

  Future<int> postUser(Customer customer) {
    return _userRepository.postUser(customer).catchError(print);
  }

  Future<int> postAddress(Address address) async {
    return await _userRepository.postAddress(address);
  }

  Future<int> postPaymentCard(PaymentCard card) async {
    return await _userRepository.postPaymentCard(card);
  }

  Future<void> loadCountries() async {
    await _countriesUseCase.getCountries().then((countries) {
      _fillInitCountriesList(countries);
      _fillSearchInCountriesStream(countries);
      _getDefaultCountryCode(countries);
    });
  }

  Future<void> loadCities(String countryName) async {
    await _citiesUseCase.getCities(countryName).then((cities) {
      _fillInitCitiesList(cities);
      _fillSearchInCitiesStream(cities);
      _getDefaultCity(cities);
    });
  }

  void _fillInitCountriesList(List<Country> countries) {
    countriesList.addAll(countries);
  }

  void _fillSearchInCountriesStream(List<Country> countries) {
    searchInCountryStream.add(countries);
  }

  void _fillInitCitiesList(List<City> cities) {
    citiesList.addAll(cities);
  }

  void _fillSearchInCitiesStream(List<City> cities) {
    searchInCitiesStream.add(cities);
  }

  void _getDefaultCountryCode(List<Country> countries) {
    final Country country = countries
        .where((country) => country.code.toLowerCase() == defaultCountryCode)
        .first;
    currentCountry.add(country);
  }

  void _getDefaultCity(List<City> cities) {
    final City city = cities.first;
    currentCity.add(city);
  }
}
