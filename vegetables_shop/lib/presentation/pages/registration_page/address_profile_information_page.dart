import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/behavior_button/behavior_button.dart';
import 'package:vegetable_shop/common_widgets/cities_picker/cities_picker.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/data/models/city.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/registration_page.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/extentions.dart';

import 'main_profile_information_page.dart';

const int thirdPage = 2;

class AddressProfileInformationPage extends StatefulWidget {
  final PageController pageController;

  const AddressProfileInformationPage({Key key, this.pageController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddressProfileInformationPageState();
}

class _AddressProfileInformationPageState
    extends State<AddressProfileInformationPage> {
  final RegistrationBloc _bloc = RegistrationBloc();

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
    _countryNameController.text = RegistrationBloc.defaultCountryName;
    _bloc.loadCities(_countryNameController.text);
    _bloc.currentCity.listen((city) {
      _cityFieldController.text = city.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _bloc,
      child: SingleChildScrollView(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: [
              InputField(
                height: 54.0,
                controller: _countryNameController,
                width: MediaQuery.of(context).size.width,
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
                stream: _bloc.currentCity,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return InputField(
                      height: 54.0,
                      readOnly: true,
                      width: MediaQuery.of(context).size.width,
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
                width: MediaQuery.of(context).size.width,
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
                width: MediaQuery.of(context).size.width,
                controller: _postCodeFieldController,
                hintText: AppStrings.postCode,
                onChanged: (_) {
                  _checkButtonState();
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              BehaviorNextButton(
                activeButtonNotifier: _fieldsNotEmptyNotifier,
                onTap: _goToNextRegistrationPage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _addressFieldController.dispose();
    _postCodeFieldController.dispose();
    _cityFieldController.dispose();
    _fieldsNotEmptyNotifier.dispose();
    super.dispose();
  }

  Future<void> _goToNextRegistrationPage() async {
    if (_fieldsIsNotEmpty()) {
      var address = Address.fromPost(
          _addressFieldController.text,
          int.parse(_postCodeFieldController.text),
          _countryNameController.text,
          _cityFieldController.text);

      BlocProvider.of<RegistrationBloc>(context).postAddress(address)
          .then((addressId) {
            if(addressId != null) {
              Auth.addressId = addressId;
              widget.pageController.animateToPage(thirdPage,
                  duration: transitionDuration, curve: transitionCurve);
            }
      });
    }
  }

  void _showCitiesPicker(City alreadySelectedCity) async {
    var _city = await showCitiesPicker(
        context, alreadySelectedCity, _countryNameController.text);
    if (_city != null) {
      _bloc.currentCity.add(_city);
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
    if (submittedValue.isNotEmpty) _bloc.loadCities(submittedValue.capitalize);
  }
}
