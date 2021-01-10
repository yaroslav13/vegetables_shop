import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/common_widgets/cities_picker/cities_picker.dart';
import 'package:vegetable_shop/common_widgets/default_app_bar/default_app_bar.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/data/models/city.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/update_address_bloc/update_address_bloc.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/extentions.dart';

class UpdateAddressPage extends BaseScreen {
  final Address address;

  UpdateAddressPage(this.address);

  @override
  _UpdateAddressPageState createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState
    extends BaseState<UpdateAddressPage, UpdateAddressBloc> {
  final TextEditingController _countryNameController = TextEditingController();
  final TextEditingController _addressFieldController = TextEditingController();
  final TextEditingController _postCodeFieldController =
      TextEditingController();
  final TextEditingController _cityFieldController = TextEditingController();

  final ValueNotifier<bool> _fieldsNotEmptyNotifier =
      ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    bloc.getDefaultCity(widget.address.city);
    _countryNameController.text = widget.address.country;
    bloc.loadCities(_countryNameController.text);
    bloc.currentCity.listen((city) {
      _cityFieldController.text = city.name;
    });
    _addressFieldController.text = widget.address.addressName;
    _postCodeFieldController.text = widget.address.postcode.toString();
  }

  DefaultAppBar appBar() =>
      DefaultAppBar.fromText(AppStrings.updateAddressTitle);

  @override
  Widget body() => SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                InputField(
                  height: 54.0,
                  controller: _countryNameController,
                  width: MediaQuery.of(context).size.width * 0.9,
                  hintText: AppStrings.country,
                  onSubmitted: (String submittedValue) {
                    _updateCitiesList(submittedValue);
                  },
                  onChanged: (_) {
                    _checkButtonState();
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                StreamBuilder<City>(
                  stream: bloc.currentCity,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      return InputField(
                        height: 54.0,
                        readOnly: true,
                        width: MediaQuery.of(context).size.width * 0.9,
                        controller: _cityFieldController,
                        hintText: AppStrings.city,
                        suffixIcon: GestureDetector(
                          onTap: () => _showCitiesPicker(snapshot.data),
                          child: const Icon(Icons.keyboard_arrow_down),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InputField(
                  height: 54.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  controller: _addressFieldController,
                  hintText: AppStrings.address,
                  onChanged: (_) {
                    _checkButtonState();
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InputField(
                  height: 54.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  controller: _postCodeFieldController,
                  hintText: AppStrings.postCode,
                  onChanged: (_) {
                    _checkButtonState();
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ValueListenableBuilder(
                  valueListenable: _fieldsNotEmptyNotifier,
                  builder: (BuildContext context, isValid, _) {
                    return AnimatedMainButton.fromText(
                        AppStrings.updateAddressTitle,
                        height: 54.0,
                        width: MediaQuery.of(context).size.width * 0.9,
                        onTap: isValid ? _updateAddress : null,
                        onDone: _onSuccess);
                  },
                ),
              ],
            ),
          ),
        ),
      );

  @override
  UpdateAddressBloc provideBloc() => UpdateAddressBloc();

  @override
  void dispose() {
    _addressFieldController.dispose();
    _postCodeFieldController.dispose();
    _cityFieldController.dispose();
    _fieldsNotEmptyNotifier.dispose();
    super.dispose();
  }

  Future<void> _updateAddress() async {
    Address address = Address(
        widget.address.addressId,
        _addressFieldController.text,
        int.parse(_postCodeFieldController.text),
        _countryNameController.text,
        _cityFieldController.text);

    await bloc.updateAddress(address);
  }

  void _showCitiesPicker(City alreadySelectedCity) async {
    var _city = await showCitiesPicker(
        context, alreadySelectedCity, _countryNameController.text);
    if (_city != null) {
      bloc.currentCity.add(_city);
    }
  }

  void _checkButtonState() {
    _fieldsNotEmptyNotifier.value = _fieldsIsNotEmpty();
  }

  bool _fieldsIsNotEmpty() {
    return _addressFieldController.text.trim().isNotEmpty &&
        _cityFieldController.text.trim().isNotEmpty &&
        _postCodeFieldController.text.trim().isNotEmpty;
  }

  void _updateCitiesList(String submittedValue) {
    if (submittedValue.isNotEmpty) bloc.loadCities(submittedValue.capitalize);
  }

  _onSuccess() => Navigator.pop(context);
}
