import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/presentation/pages/product_order_page/default_weight_items.dart';
import 'package:vegetable_shop/presentation/pages/product_order_page/product_description_section.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/extentions.dart';

class OrderBody extends StatefulWidget {
  final int price;
  final UnitTypes unitType;

  const OrderBody({Key key, @required this.price, @required this.unitType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  final TextEditingController _desiredWeightFieldController =
      TextEditingController();

  final ValueNotifier<bool> _desiredWeightFieldControllerIsNotEmpty =
      ValueNotifier(false);
  final ValueNotifier<String> _desiredWeightFieldControllerTextNotifier =
      ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _desiredWeightFieldController.addListener(_desiredWeightFieldListener);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _desiredWeightFieldDescription(),
        _desiredWeightField(),
        _defaultWeightValues(),
        ProductDescriptionSection(),
        _finalPrice(),
        _addToCartButton(),
      ],
    );
  }

  @override
  void dispose() {
    _desiredWeightFieldController.dispose();
    _desiredWeightFieldControllerIsNotEmpty.dispose();
    _desiredWeightFieldControllerTextNotifier.dispose();
    super.dispose();
  }

  Padding _desiredWeightFieldDescription() => Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(AppStrings.enterNecessaryWeight,
              style: Theme.of(context).textTheme.bodyText1),
        ),
      );

  Padding _desiredWeightField() => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: ValueListenableBuilder(
          valueListenable: _desiredWeightFieldControllerIsNotEmpty,
          builder: (BuildContext context, controllerIsNotEmpty, _) {
            return InputField.fromClearButtonSuffixIcon(
              height: 45.0,
              width: MediaQuery.of(context).size.width * 0.9,
              controller: _desiredWeightFieldController,
              displayClearButton: controllerIsNotEmpty,
              textInputFormatterList: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            );
          },
        ),
      );

  SizedBox _defaultWeightValues() {
    final items = _prepareDefaultWeightItems();
    return SizedBox(
      height: 25,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ValueListenableBuilder<String>(
        valueListenable: _desiredWeightFieldControllerTextNotifier,
        builder: (BuildContext context, controllerText, _) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int i) {
              final bool isDisplayed =
                  _isDefaultWeightSelected(items[i], controllerText);
              return DefaultWeightBubbles(
                defaultWeightItems: items[i],
                isDisplayed: isDisplayed,
                onTap: () {
                  _desiredWeightFieldController.text = items[i].grams;
                },
              );
            },
          );
        },
      ),
    );
  }

  Padding _finalPrice() => Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 5.0, right: 20.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: ValueListenableBuilder(
            valueListenable: _desiredWeightFieldControllerTextNotifier,
            builder: (BuildContext context, enteredWeight, _) {
              final double price = _getFinalPrice(enteredWeight);
              return Text(AppStrings.finalPrice(price),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 16.0,
                        color: Colors.red,
                      ));
            },
          ),
        ),
      );

  Padding _addToCartButton() => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: AnimatedMainButton.fromText(AppStrings.addToCart,
            width: MediaQuery.of(context).size.width * 0.9, height: 45.0),
      );

  List<DefaultWeightItems> _prepareDefaultWeightItems() {
    return [
      DefaultWeightItems('100 г'),
      DefaultWeightItems('200 г'),
      DefaultWeightItems('500 г'),
      DefaultWeightItems('1000 г'),
    ];
  }

  bool _isDefaultWeightSelected(
      DefaultWeightItems item, String controllerText) {
    final itemsWeight = _separateNumbers(item.grams);
    final introducedWeightToController = _separateNumbers(controllerText);

    return !(itemsWeight == introducedWeightToController);
  }

  String _separateNumbers(String allText) {
    String onlyNumbers = '';
    for (int i = 0; i < allText.length; i++) {
      if (int.tryParse(allText[i]) != null) {
        onlyNumbers += allText[i];
      }
    }
    return onlyNumbers;
  }

  double _getFinalPrice(String controllerText) {
    const double defaultPrice = 0.0;
    int defaultWeight = widget.unitType.getDefaultValues;

    String weightEnteredInField = _separateNumbers(controllerText);
    int parseEnteredWeightToInt = int.tryParse(weightEnteredInField);

    if (parseEnteredWeightToInt != null) {
      return (widget.price * parseEnteredWeightToInt) / defaultWeight;
    }
    return defaultPrice;
  }

  void _desiredWeightFieldListener() {
    _desiredWeightFieldIsNotEmptyCheck();
    _desiredWeightFieldRead();
  }

  void _desiredWeightFieldIsNotEmptyCheck() {
    _desiredWeightFieldControllerIsNotEmpty.value =
        _desiredWeightFieldController.text.isNotEmpty;
  }

  void _desiredWeightFieldRead() {
    _desiredWeightFieldControllerTextNotifier.value =
        _desiredWeightFieldController.text;
  }
}
