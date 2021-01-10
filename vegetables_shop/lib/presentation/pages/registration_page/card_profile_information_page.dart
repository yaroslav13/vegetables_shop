import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vegetable_shop/common_widgets/behavior_button/behavior_button.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/main_profile_information_page.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/registration_page.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/date_converter.dart';
import 'package:vegetable_shop/utilits/input_formatters.dart';
import 'package:vegetable_shop/data/models/customer.dart';

const fourthPage = 4;

class CardProfileInformationPage extends StatefulWidget {
  final PageController pageController;

  const CardProfileInformationPage({Key key, this.pageController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardProfileInformationPageState();
}

class _CardProfileInformationPageState
    extends State<CardProfileInformationPage> {
  final TextEditingController _cardNumberFieldController =
      TextEditingController();
  final TextEditingController _expireDateFieldController =
      TextEditingController();
  final TextEditingController _cvvCodeFieldController = TextEditingController();
  final TextEditingController _cardHolderNameFieldController =
      TextEditingController();

  final ValueNotifier<bool> _fieldsIsValidNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _addPaymentCardDetailsTitle(),
                InputField(
                  height: 54.0,
                  width: MediaQuery.of(context).size.width,
                  controller: _cardNumberFieldController,
                  hintText: AppStrings.cardNumberHint,
                  keyboardType: TextInputType.number,
                  textInputFormatterList: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    CarNumberFormatter(),
                  ],
                  onChanged: (_) {
                    _checkButtonState();
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InputField(
                      height: 54.0,
                      width: MediaQuery.of(context).size.width * 0.3,
                      controller: _expireDateFieldController,
                      hintText: AppStrings.expiryDateHint,
                      keyboardType: TextInputType.number,
                      textInputFormatterList: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        ExpireDateTextFormatter(),
                      ],
                      onChanged: (_) {
                        _checkButtonState();
                      },
                    ),
                    InputField(
                      height: 54.0,
                      width: MediaQuery.of(context).size.width * 0.25,
                      controller: _cvvCodeFieldController,
                      hintText: AppStrings.cvvCode,
                      keyboardType: TextInputType.number,
                      textInputFormatterList: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onChanged: (_) {
                        _checkButtonState();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InputField(
                  height: 54.0,
                  width: MediaQuery.of(context).size.width,
                  controller: _cardHolderNameFieldController,
                  hintText: AppStrings.cardHolderHint,
                  onChanged: (_) {
                    _checkButtonState();
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                BehaviorNextButton(
                  activeButtonNotifier: _fieldsIsValidNotifier,
                  onTap: _goToNextRegistrationPage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardNumberFieldController.dispose();
    _expireDateFieldController.dispose();
    _cvvCodeFieldController.dispose();
    _cardHolderNameFieldController.dispose();
    _fieldsIsValidNotifier.dispose();
    super.dispose();
  }

  Padding _addPaymentCardDetailsTitle() => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(AppStrings.addInformationAboutPaymentCard,
            style: Theme.of(context).textTheme.bodyText1),
      );

  Future<void> _goToNextRegistrationPage() async {
    if (_fieldsIsNotEmpty()) {
      var expireDate = convertExpireDate(_expireDateFieldController.text);

      var paymentCard = PaymentCard.fromPost(
        _cardNumberFieldController.text,
        expireDate,
        _cvvCodeFieldController.text,
        _cardHolderNameFieldController.text,
      );

      BlocProvider.of<RegistrationBloc>(context)
          .postPaymentCard(paymentCard)
          .then((paymentCardId) async {
        if (paymentCardId != null) {
          Auth.paymentCardId = paymentCardId;

          await widget.pageController.animateToPage(fourthPage,
              duration: transitionDuration, curve: transitionCurve);
        }
      });
    }
  }

  void _checkButtonState() {
    _fieldsIsValidNotifier.value = _fieldsIsNotEmpty();
  }

  bool _fieldsIsNotEmpty() {
    return _cardHolderNameFieldController.text.trim().isNotEmpty &&
        _cardNumberFieldController.text.trim().isNotEmpty &&
        _cvvCodeFieldController.text.trim().isNotEmpty &&
        _expireDateFieldController.text.trim().isNotEmpty;
  }
}
