import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegetable_shop/common_widgets/behavior_button/behavior_button.dart';
import 'package:vegetable_shop/common_widgets/country_code_picker/country_code_picker.dart';
import 'package:vegetable_shop/common_widgets/image_source_alert/image_source_alert.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/data/models/country.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/registration_page.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

const double fieldHeight = 54.0;
const int secondPage = 1;

class MainProfileInformationPage extends StatefulWidget {
  final PageController pageController;

  const MainProfileInformationPage({Key key, this.pageController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainProfileInformationPageState();
}

class _MainProfileInformationPageState
    extends State<MainProfileInformationPage> {
  final RegistrationBloc _bloc = RegistrationBloc();

  final TextEditingController _firstNameFieldController =
      TextEditingController();
  final TextEditingController _secondNameFieldController =
      TextEditingController();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _phoneFieldController = TextEditingController();

  final ValueNotifier<bool> _fieldsIsValid =
      ValueNotifier<bool>(false);

  File _image;

  @override
  void initState() {
    super.initState();
    _bloc.loadCountries();
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
              _ProfilePhotoPicker(
                image: _image,
                onTap: () {
                  _onProfilePhotoPickerTap();
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              InputField(
                height: fieldHeight,
                controller: _firstNameFieldController,
                hintText: AppStrings.firstName,
                onChanged: (_) {
                  _checkButtonState();
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              InputField(
                height: fieldHeight,
                controller: _secondNameFieldController,
                hintText: AppStrings.secondName,
                onChanged: (_) {
                  _checkButtonState();
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              InputField(
                height: fieldHeight,
                controller: _emailFieldController,
                hintText: AppStrings.email,
                onChanged: (_) {
                  _checkButtonState();
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              InputField(
                height: fieldHeight,
                controller: _phoneFieldController,
                prefixIcon: _countryCode(),
                hintText: AppStrings.telephone,
                onChanged: (_) {
                  _checkButtonState();
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              BehaviorNextButton(
                activeButtonNotifier: _fieldsIsValid,
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
    _firstNameFieldController.dispose();
    _secondNameFieldController.dispose();
    _emailFieldController.dispose();
    _phoneFieldController.dispose();
    _fieldsIsValid.dispose();
    super.dispose();
  }

  Widget _countryCode() {
    return StreamBuilder<Country>(
      stream: _bloc.currentCountry,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: 110.0,
            child: GestureDetector(
              onTap: () {
                _getCountryCode(snapshot.data);
              },
              child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        AppImages.getFlagIcon(snapshot.data.code),
                        package: 'country_icons',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('${snapshot.data.dialCode}',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 18, color: AppColors.mineShaft)),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 12,
                        width: 12,
                        child: SvgPicture.asset(AppImages.arrowDown,
                            fit: BoxFit.contain),
                      ),
                    ],
                  )),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Future<void> _goToNextRegistrationPage() async {
    if (_fieldsIsNotEmpty()) {
      await widget.pageController.animateToPage(secondPage,
          duration: transitionDuration, curve: transitionCurve);
    }
  }

  void _getCountryCode(Country country) async {
    var _country = await showCountryCodePicker(context, country);
    if (_country != null) {
      _bloc.currentCountry.add(_country);
    }
  }

  void _onProfilePhotoPickerTap() async {
    FocusScope.of(context).requestFocus(FocusNode());
    var source = await showSelectImageSourceAlert(context);
    if (source != null) {
      _getImage(source);
    }
  }

  void _getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(
        source: source, maxWidth: 1000, maxHeight: 1000);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _checkButtonState() {
    _fieldsIsValid.value = _fieldsIsNotEmpty();
  }

  bool _fieldsIsNotEmpty() =>
      _firstNameFieldController.text.trim().isNotEmpty &&
      _secondNameFieldController.text.trim().isNotEmpty &&
      _phoneFieldController.text.trim().isNotEmpty &&
      _emailFieldController.text.trim().isNotEmpty;
}

class _ProfilePhotoPicker extends StatelessWidget {
  final File image;
  final VoidCallback onTap;

  const _ProfilePhotoPicker({Key key, this.image, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          child: CircleAvatar(
            backgroundColor: AppColors.mineShaft,
            radius: 50,
            backgroundImage: image != null ? FileImage(image) : null,
            child: image == null
                ? Image.asset(AppImages.camera, width: 50.0, height: 50.0)
                : null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            AppStrings.chooseImage,
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: AppColors.mantis,
                  fontSize: 16,
                ),
          ),
        ),
      ],
    );
  }
}
