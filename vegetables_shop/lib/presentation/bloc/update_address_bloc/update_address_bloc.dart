import 'package:rxdart/rxdart.dart';
import 'package:vegetable_shop/data/models/city.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/data/use_cases/country_cities_use_case/country_cities_use_case.dart';
import 'package:vegetable_shop/data/use_cases/user_use_case/user_use_case.dart';
import 'package:vegetable_shop/presentation/bloc/base_bloc.dart';

class UpdateAddressBloc extends BaseBloc {
  final CountryCitiesUseCase _citiesUseCase = CountryCitiesUseCase();
  final UserUseCase _userUseCase = UserUseCase();

  PublishSubject<List<City>> searchInCitiesStream =
      PublishSubject<List<City>>();
  BehaviorSubject<City> currentCity = BehaviorSubject<City>();

  List<City> citiesList = <City>[];

  @override
  void dispose() {
    searchInCitiesStream.close();
    currentCity.close();
  }

  Future<void> updateAddress(Address address) {
    return _userUseCase.updateAddress(address);
  }

  Future<void> loadCities(String countryName) async {
    await _citiesUseCase.getCities(countryName).then((cities) {
      _fillInitCitiesList(cities);
      _fillSearchInCitiesStream(cities);
    });
  }

  void _fillInitCitiesList(List<City> cities) {
    citiesList.addAll(cities);
  }

  void _fillSearchInCitiesStream(List<City> cities) {
    searchInCitiesStream.add(cities);
  }

  void getDefaultCity(String cityName) {
    City city = City(cityName);

    currentCity.add(city);
  }
}
