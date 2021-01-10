import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/common_widgets/default_app_bar/default_app_bar.dart';
import 'package:vegetable_shop/common_widgets/image_source_alert/image_source_alert.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/main_profile_information_page.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

class UpdateProfilePage extends BaseScreen {
  final Customer customer;

  UpdateProfilePage(this.customer);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState
    extends BaseState<UpdateProfilePage, UpdateProfileBloc> {
  final TextEditingController _firstNameFieldController =
      TextEditingController();
  final TextEditingController _secondNameFieldController =
      TextEditingController();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _phoneFieldController = TextEditingController();
  final TextEditingController _newPasswordFieldController =
      TextEditingController();
  final TextEditingController _repeatPasswordFieldController =
      TextEditingController();

  final ValueNotifier<bool> _fieldsIsValid = ValueNotifier<bool>(false);

  File _image;

  @override
  void initState() {
    super.initState();
    _firstNameFieldController.text = widget.customer.customerName;
    _secondNameFieldController.text = widget.customer.customerSurname;
    _emailFieldController.text = widget.customer.emailAddress;
    _phoneFieldController.text = widget.customer.phoneNumber;
    _newPasswordFieldController.text = widget.customer.password;
    _repeatPasswordFieldController.text = widget.customer.password;
    if (widget.customer.photoUrl.isNotEmpty) {
      _image = File(widget.customer.photoUrl);
    }
  }

  @override
  PreferredSizeWidget appBar() =>
      DefaultAppBar.fromText(AppStrings.updateProfileInfo);

  @override
  Widget body() => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              ProfilePhotoPicker(
                image: _image,
                onTap: () {
                  _onProfilePhotoPickerTap();
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                  child: Text(AppStrings.mainInfo,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: AppColors.mineShaft,
                          )),
                ),
              ),
              InputField(
                height: fieldHeight,
                width: MediaQuery.of(context).size.width * 0.9,
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
                width: MediaQuery.of(context).size.width * 0.9,
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
                width: MediaQuery.of(context).size.width * 0.9,
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
                width: MediaQuery.of(context).size.width * 0.9,
                controller: _phoneFieldController,
                hintText: AppStrings.telephone,
                onChanged: (_) {
                  _checkButtonState();
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                  child: Text(AppStrings.updatePassword,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: AppColors.mineShaft,
                          )),
                ),
              ),
              InputField(
                height: 54.0,
                width: MediaQuery.of(context).size.width * 0.9,
                controller: _newPasswordFieldController,
                hintText: AppStrings.newPassword,
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
                controller: _repeatPasswordFieldController,
                hintText: AppStrings.repeatPassword,
                onChanged: (_) {
                  _checkButtonState();
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              ValueListenableBuilder(
                valueListenable: _fieldsIsValid,
                builder: (BuildContext context, isValid, _) {
                  return AnimatedMainButton.fromText(AppStrings.updateProfile,
                      height: 54.0,
                      width: MediaQuery.of(context).size.width * 0.9,
                      onTap: isValid ? _updateProfile : null,
                      onDone: _onSuccess);
                },
              ),
            ],
          ),
        ),
      );

  @override
  UpdateProfileBloc provideBloc() => UpdateProfileBloc();

  @override
  void dispose() {
    _firstNameFieldController.dispose();
    _secondNameFieldController.dispose();
    _emailFieldController.dispose();
    _phoneFieldController.dispose();
    _fieldsIsValid.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    Customer customer = Customer(
        widget.customer.customerId,
        _secondNameFieldController.text,
        _firstNameFieldController.text,
        _phoneFieldController.text,
        _emailFieldController.text,
        widget.customer.addressId,
        _image != null ? _image.path : widget.customer.photoUrl,
        _newPasswordFieldController.text,
        widget.customer.paymentCardId);

    await bloc.updateUser(customer);
  }

  _onSuccess() => Navigator.pop(context);

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
      _emailFieldController.text.trim().isNotEmpty &&
      _newPasswordFieldController.text.trim().isNotEmpty &&
      _repeatPasswordFieldController.text.trim().isNotEmpty &&
      _newPasswordFieldController.text == _repeatPasswordFieldController.text;
}
