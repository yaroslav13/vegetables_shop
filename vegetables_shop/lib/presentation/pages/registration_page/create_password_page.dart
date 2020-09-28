import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/behavior_button/behavior_button.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/completed_registration_page.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

class CreatePasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final TextEditingController _newPasswordFieldController =
      TextEditingController();
  final TextEditingController _repeatPasswordFieldController =
      TextEditingController();

  final ValueNotifier<bool> _fieldsIsValidNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _createPasswordTitle(),
            InputField(
              height: 54.0,
              controller: _newPasswordFieldController,
              hintText: AppStrings.newPassword,
              onChanged: (_){
                _checkButtonState();
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            InputField(
              height: 54.0,
              controller: _repeatPasswordFieldController,
              hintText: AppStrings.repeatPassword,
              onChanged: (_){
                _checkButtonState();
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            BehaviorNextButton(
              activeButtonNotifier: _fieldsIsValidNotifier,
              text: AppStrings.finishRegistration,
              onTap: _goToCompleteRegistrationPage,
            ),
          ],
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
    if (_fieldsIsNotEmpty()) {
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CompletedRegistrationPage(),
          ));
    }
  }

  void _checkButtonState() {
    _fieldsIsValidNotifier.value = _fieldsIsNotEmpty();
  }

  bool _fieldsIsNotEmpty() {
    return _newPasswordFieldController.text.trim().isNotEmpty &&
        _repeatPasswordFieldController.text.trim().isNotEmpty;
  }
}
