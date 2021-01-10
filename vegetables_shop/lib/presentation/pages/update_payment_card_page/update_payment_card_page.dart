import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/common_widgets/default_app_bar/default_app_bar.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/update_payment_card_bloc/update_payment_card_bloc.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/date_converter.dart';
import 'package:vegetable_shop/utilits/input_formatters.dart';

class UpdatePaymentCardPage extends BaseScreen {
  final PaymentCard card;

  UpdatePaymentCardPage(this.card);

  @override
  _UpdatePaymentCardPageState createState() => _UpdatePaymentCardPageState();
}

class _UpdatePaymentCardPageState
    extends BaseState<UpdatePaymentCardPage, UpdatePaymentCardBloc> {
  final TextEditingController _cardNumberFieldController =
      TextEditingController();
  final TextEditingController _expireDateFieldController =
      TextEditingController();
  final TextEditingController _cvvCodeFieldController = TextEditingController();
  final TextEditingController _cardHolderNameFieldController =
      TextEditingController();

  final ValueNotifier<bool> _fieldsIsValidNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _cardHolderNameFieldController.text = widget.card.paymentCardHolder;
    _expireDateFieldController.text =
        convertFromIso8601StringToExpireDate(widget.card.expireDate);
    _cvvCodeFieldController.text = widget.card.cvc;
    _cardNumberFieldController.text = widget.card.paymentCardNumber;
  }

  @override
  PreferredSizeWidget appBar() =>
      DefaultAppBar.fromText(AppStrings.updatePaymentCard);

  @override
  Widget body() => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputField(
                  height: 54.0,
                  width: MediaQuery.of(context).size.width * 0.9,
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
                  width: MediaQuery.of(context).size.width * 0.9,
                  controller: _cardHolderNameFieldController,
                  hintText: AppStrings.cardHolderHint,
                  onChanged: (_) {
                    _checkButtonState();
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ValueListenableBuilder(
                  valueListenable: _fieldsIsValidNotifier,
                  builder: (BuildContext context, isValid, _) {
                    return AnimatedMainButton.fromText(AppStrings.updateProfile,
                        height: 54.0,
                        width: MediaQuery.of(context).size.width * 0.9,
                        onTap: isValid ? _updatePaymentCard : null,
                        onDone: _onSuccess);
                  },
                ),
              ],
            ),
          ),
        ),
      );

  @override
  UpdatePaymentCardBloc provideBloc() => UpdatePaymentCardBloc();

  @override
  void dispose() {
    _cardNumberFieldController.dispose();
    _expireDateFieldController.dispose();
    _cvvCodeFieldController.dispose();
    _cardHolderNameFieldController.dispose();
    _fieldsIsValidNotifier.dispose();
    super.dispose();
  }

  Future<void> _updatePaymentCard() async {
    PaymentCard card = PaymentCard(
        widget.card.paymentCardId,
        _cardNumberFieldController.text,
        convertExpireDate(_expireDateFieldController.text),
        _cvvCodeFieldController.text,
        _cardHolderNameFieldController.text);

    await bloc.updatePaymentCard(card);
  }

  _onSuccess() => Navigator.pop(context);

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
