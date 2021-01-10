import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/behavior_button/behavior_button.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import 'package:vegetable_shop/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/completed_registration_page.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

import 'main_profile_information_page.dart';

class CreatePasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final RegistrationBloc _bloc = RegistrationBloc();

  final TextEditingController _newPasswordFieldController =
      TextEditingController();
  final TextEditingController _repeatPasswordFieldController =
      TextEditingController();

  final ValueNotifier<bool> _fieldsIsValidNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _bloc,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createPasswordTitle(),
              InputField(
                height: 54.0,
                width: MediaQuery.of(context).size.width,
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
                width: MediaQuery.of(context).size.width,
                controller: _repeatPasswordFieldController,
                hintText: AppStrings.repeatPassword,
                onChanged: (_) {
                  _checkButtonState();
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              BehaviorNextButton(
                activeButtonNotifier: _fieldsIsValidNotifier,
                text: AppStrings.finishRegistration,
                onTap: _registrationComplete,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordFieldController.dispose();
    _repeatPasswordFieldController.dispose();
    _fieldsIsValidNotifier.dispose();
    super.dispose();
  }

  Padding _createPasswordTitle() => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(AppStrings.createPassword,
            style: Theme.of(context).textTheme.bodyText1),
      );

  Future<void> _goToCompleteRegistrationPage() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CompletedRegistrationPage(),
        ));
  }

  Future<void> _registrationComplete() async {
    if (_fieldsIsNotEmpty()) {
      var customer = Customer.fromPost(
          Auth.surname,
          Auth.name,
          Auth.phone,
          Auth.email,
          Auth.addressId,
          Auth.photoPath,
          _newPasswordFieldController.text,
          Auth.paymentCardId);

      BlocProvider.of<RegistrationBloc>(context).postUser(customer).then((id) {
        if (id != null) {
          _goToCompleteRegistrationPage();
        }
      });
    }
  }

  void _checkButtonState() {
    _fieldsIsValidNotifier.value = _fieldsIsNotEmpty() &&
        _newPasswordFieldController.text == _repeatPasswordFieldController.text;
  }

  bool _fieldsIsNotEmpty() {
    return _newPasswordFieldController.text.trim().isNotEmpty &&
        _repeatPasswordFieldController.text.trim().isNotEmpty;
  }
}
