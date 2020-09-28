import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/common_widgets/not_found_placeholder/not_found_placeholder.dart';
import 'package:vegetable_shop/data/models/city.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

Future<City> showCitiesPicker(
        BuildContext context, City alreadySelectedCity, String countryName) =>
    showModalBottomSheet(
        useRootNavigator: true,
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(20.0),
          ),
        ),
        context: context,
        enableDrag: true,
        builder: (BuildContext context) {
          return CitiesPicker(
            alreadySelectedCity: alreadySelectedCity,
            parentCountryName: countryName,
          );
        });

class CitiesPicker extends StatefulWidget {
  final City alreadySelectedCity;
  final String parentCountryName;

  const CitiesPicker(
      {Key key, this.alreadySelectedCity, this.parentCountryName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CitiesPickerState();
}

class _CitiesPickerState extends State<CitiesPicker> {
  final RegistrationBloc _bloc = RegistrationBloc();

  final TextEditingController _searchFieldController = TextEditingController();
  final ValueNotifier<bool> _searchFieldIsNotEmptyNotifier =
      ValueNotifier<bool>(false);

  City _alreadySelectedCity;

  @override
  void initState() {
    super.initState();

    _bloc.loadCities(widget.parentCountryName);

    _searchFieldController
      ..addListener(_searchFieldIsNotEmptyListener)
      ..addListener(() => _onSearch(_searchFieldController.text));
    _alreadySelectedCity = widget.alreadySelectedCity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _bloc,
      child: SafeArea(
        child: _body(),
      ),
    );
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  Column _body() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _header(),
          ValueListenableBuilder<bool>(
            valueListenable: _searchFieldIsNotEmptyNotifier,
            builder: (BuildContext context, fieldIsNotEmpty, _) {
              return InputField.fromClearButtonSuffixIcon(
                height: 54.0,
                width: MediaQuery.of(context).size.width * 0.9,
                controller: _searchFieldController,
                fillColor: Colors.grey.withOpacity(0.2),
                hintText: AppStrings.search,
                displayClearButton: fieldIsNotEmpty,
              );
            },
          ),
          const Divider(),
          _citiesList(),
        ],
      );

  Padding _header() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: GestureDetector(
          child: Column(
            children: [
              Text('Закрыть',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: AppColors.mantis,
                        fontSize: 18.0,
                      )),
              const Icon(Icons.keyboard_arrow_down,
                  size: 30.0, color: AppColors.mantis),
            ],
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      );

  Expanded _citiesList() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: StreamBuilder<List<City>>(
              stream: _bloc.searchInCitiesStream,
              initialData: _bloc.citiesList,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isEmpty) {
                    return const NotFound();
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return _CityTile(
                          city: snapshot.data[i],
                          selected: _alreadySelectedCity.name ==
                              snapshot.data[i].name,
                        );
                      });
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      );

  void _onSearch(String request) {
    if (request == null) {
      return;
    }
    if (request.trim().isNotEmpty) {
      var searchResult = _bloc.citiesList
          ?.where((item) =>
              item.name.toLowerCase().startsWith(request.trim().toLowerCase()))
          ?.toList();
      _bloc.searchInCitiesStream.add(searchResult);
    } else {
      _bloc.searchInCitiesStream.add(_bloc.citiesList);
    }
  }

  void _searchFieldIsNotEmptyListener() {
    _searchFieldIsNotEmptyNotifier.value =
        _searchFieldController.text.isNotEmpty;
  }
}

class _CityTile extends StatefulWidget {
  final City city;
  final bool selected;

  const _CityTile({Key key, this.city, this.selected}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CityTileState();
}

class _CityTileState extends State<_CityTile> {
  bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected ?? false;
  }

  @override
  void didUpdateWidget(_CityTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selected = widget.selected ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        child: Container(
          height: 54.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            ),
            border: Border.all(color: AppColors.mantis),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.city.name != null)
                  Text(widget.city.name,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: AppColors.mantis,
                            fontSize: 22,
                          )),
                _selectedItem(),
              ],
            ),
          ),
        ),
        onTap: _onTap,
      ),
    );
  }

  Padding _selectedItem() => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 270),
          switchOutCurve: Curves.linear,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(child: child, scale: animation);
          },
          child: _selected
              ? Image.asset(AppImages.iconChecked, width: 30.0, height: 30.0)
              : Image.asset(AppImages.emptyOval, width: 30.0, height: 30.0),
        ),
      );

  void _onTap() {
    if (!_selected) {
      setState(() {
        _selected = true;
      });
    }
    if (_selected) {
      Navigator.of(context).pop(widget.city);
    }
  }
}
