import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/common_widgets/not_found_placeholder/not_found_placeholder.dart';
import 'package:vegetable_shop/data/models/country.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

Future<Country> showCountryCodePicker(BuildContext context, Country country) =>
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CountryCodePicker(
            wasSelected: country,
          );
        });

class CountryCodePicker extends StatefulWidget {
  final Country wasSelected;

  const CountryCodePicker({Key key, this.wasSelected}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  final RegistrationBloc _bloc = RegistrationBloc();

  final TextEditingController _searchFieldController = TextEditingController();
  final ValueNotifier<bool> _visibilityAnimationNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> _queryIsNotEmptyNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> _searchCancelNotifier = ValueNotifier<bool>(false);
  final FocusNode _searchFieldFocus = FocusNode();

  Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _bloc.loadCountries();
    _searchFieldFocus.addListener(_onFocus);
    _searchFieldController
        .addListener(() => _onSearch(_searchFieldController.text));
    _selectedCountry = widget.wasSelected;
  }

  @override
  void didUpdateWidget(CountryCodePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedCountry = widget.wasSelected;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: _bloc,
        child: Material(
            child: SafeArea(
          child: _body(),
        )));
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    _searchFieldFocus.dispose();
    _queryIsNotEmptyNotifier.dispose();
    _visibilityAnimationNotifier.dispose();
    _searchCancelNotifier.dispose();
    super.dispose();
  }

  Column _body() {
    return Column(
      children: <Widget>[
        _pickerHeader(),
        Expanded(
          child: Stack(
            children: <Widget>[
              StreamBuilder<List<Country>>(
                stream: _bloc.searchInCountryStream,
                initialData: _bloc.countriesList,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isEmpty) {
                      return const NotFound();
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return _CountryTile(
                          onSelected:
                              snapshot.data[i].code == _selectedCountry.code,
                          country: snapshot.data[i],
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _visibilityAnimationNotifier,
                builder: (BuildContext context, visibilityAnimationValue,
                    Widget child) {
                  return Visibility(
                    visible: visibilityAnimationValue,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 270),
                      color: AppColors.mineShaft.withOpacity(0.7),
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _pickerHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(
                  AppStrings.selectedCountryCode,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                ),
              ),
              _closePickerButton(),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),
          _searchElement(),
          const SizedBox(
            height: 10.0,
          ),
        ],
      );

  Padding _closePickerButton() => Padding(
      padding: const EdgeInsetsDirectional.only(end: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text(
          AppStrings.close,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: AppColors.mantis,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
        ),
      ));

  Padding _searchElement() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: <Widget>[
            _searchTextField(),
            _cancelButton(),
          ],
        ),
      );

  Expanded _searchTextField() => Expanded(
        child: ValueListenableBuilder(
          valueListenable: _queryIsNotEmptyNotifier,
          builder: (BuildContext context, queryIsNotEmpty, _) {
            return InputField.fromClearButtonSuffixIcon(
              controller: _searchFieldController,
              focusNode: _searchFieldFocus,
              textInputAction: TextInputAction.done,
              textFieldStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: AppColors.mineShaft,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
              contentPadding: EdgeInsets.zero,
              fillColor: AppColors.mineShaft.withOpacity(0.1),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.mineShaft,
                size: 24,
              ),
              hintText: AppStrings.search,
              hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: AppColors.mineShaft,
                    fontWeight: FontWeight.w100,
                  ),
              displayClearButton: queryIsNotEmpty,
            );
          },
        ),
      );

  Padding _cancelButton() => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ValueListenableBuilder<bool>(
          valueListenable: _searchCancelNotifier,
          builder: (context, searchCancel, _) {
            return Visibility(
              visible: searchCancel,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Center(
                  child: Text(
                    AppStrings.cancel,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: AppColors.mantis,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                onTap: _onSearchCanceled,
              ),
            );
          },
        ),
      );

  void _onSearch(String request) {
    _onFocus();
    _onFieldNotEmpty();
    if (request == null) {
      return;
    }
    if (request.trim().isNotEmpty) {
      var searchResult = _bloc.countriesList
          ?.where((item) =>
              item.name.toLowerCase().startsWith(request.trim().toLowerCase()))
          ?.toList();
      _bloc.searchInCountryStream.add(searchResult);
    } else {
      _bloc.searchInCountryStream.add(_bloc.countriesList);
    }
  }

  void _onSearchCanceled() {
    _searchFieldController.clear();
    _searchFieldFocus.unfocus();
  }

  void _onFocus() {
    _visibilityAnimationNotifier.value = _searchFieldFocus.hasFocus &&
        _searchFieldController.text.trim().isEmpty;
    _searchCancelNotifier.value = _searchFieldFocus.hasFocus;
  }

  void _onFieldNotEmpty() {
    _queryIsNotEmptyNotifier.value =
        _searchFieldController.text.trim().isNotEmpty;
  }
}

class _CountryTile extends StatefulWidget {
  final Country country;
  final bool onSelected;

  const _CountryTile({Key key, this.country, this.onSelected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CountryTileState();
}

class _CountryTileState extends State<_CountryTile> {
  bool _onSelected;

  @override
  void initState() {
    super.initState();
    _onSelected = widget.onSelected;
  }

  @override
  void didUpdateWidget(_CountryTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    _onSelected = widget.onSelected ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Container(
            height: 50.0,
            padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
            child: Row(
              children: <Widget>[
                _countryFlagIcon(),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    widget.country.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.button.copyWith(
                        color: _onSelected
                            ? AppColors.mantis
                            : AppColors.mineShaft,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Spacer(),
                Text(
                  widget.country.dialCode,
                  style: Theme.of(context).textTheme.button.copyWith(
                      color:
                          _onSelected ? AppColors.mantis : AppColors.mineShaft,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 8.0,
                )
              ],
            ),
          ),
          onTap: _onTap,
        ),
        const Divider(),
      ],
    );
  }

  Widget _countryFlagIcon() => AnimatedSwitcher(
        duration: Duration(milliseconds: 270),
        switchInCurve: Curves.bounceInOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(child: child, scale: animation);
        },
        child: _onSelected
            ? Image.asset(
                AppImages.iconChecked,
                width: 25,
              )
            : Image.asset(
                AppImages.getFlagIcon(widget.country.code),
                package: 'country_icons',
                height: 20,
                width: 20,
              ),
      );

  void _onTap() {
    if (!_onSelected) {
      setState(() {
        _onSelected = true;
      });
    }
    if (_onSelected) {
      Navigator.of(context).pop(widget.country);
    }
  }
}
