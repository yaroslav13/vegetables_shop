import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/common_widgets/terms/terms.dart';

import 'cart_products_list_element.dart';

class FontSide extends StatefulWidget {
  final AnimationController flipController;

  const FontSide({Key key, this.flipController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FontSideState();
}

class _FontSideState extends State<FontSide> {
  final ValueNotifier<bool> _agreeWithTermsSelected =
      ValueNotifier<bool>(false);

  List<_ProductItem> _selectedProductItems = List();

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: FractionalOffset.center,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                const Radius.circular(16.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _cartTitle(),
                _productsList(),
                _paySection(),
              ],
            )));
  }

  @override
  void dispose() {
    _agreeWithTermsSelected.dispose();
    super.dispose();
  }

  Padding _cartTitle() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ваши товары:', style: Theme.of(context).textTheme.subtitle2),
            Text('Общая сума: ${_getTotalPrice()}',
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontSize: 16.0,
                    )),
          ],
        ),
      );

  SizedBox _productsList() => SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 20,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int i) {
              return CartProductsListElement(
                productName: 'Name',
                price: 200,
                weightOfProduct: 200,
                // selected: _selectedProductItems.contains(element),
                onTap: () {
                  setState(() {
                    //TODO: add item to _selectedProductItems list after tap
                    //_selectedProductItems.add();
                  });
                },
              );
            }),
      );

  Expanded _paySection() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _AgreeWithTermsCheckBox(
              selectedNotifier: _agreeWithTermsSelected,
            ),
            AnimatedMainButton.fromText('Перейти к оплате',
                height: 54.0,
                weight: MediaQuery.of(context).size.width * 0.8,
                onTap: _navigateToPaySection),
          ],
        ),
      );

  Future<void> _navigateToPaySection() async {
    //TODO: check on _selectedProductItems.isNotEmpty && _agreeWithTermsSelected.value
    if (_agreeWithTermsSelected.value) {
      widget.flipController.forward();
    }
  }

  double _getTotalPrice() {
    const double defaultPrice = 0.0;
    double totalPrice = defaultPrice;
    for (_ProductItem item in _selectedProductItems) {
      totalPrice += item.data.price;
    }
    return totalPrice;
  }
}

class _AgreeWithTermsCheckBox extends StatelessWidget {
  final ValueNotifier<bool> selectedNotifier;

  const _AgreeWithTermsCheckBox({Key key, @required this.selectedNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: selectedNotifier,
            builder: (context, selected, _) {
              return Checkbox(
                value: selected,
                onChanged: (bool value) {
                  selectedNotifier.value = value;
                },
              );
            },
          ),
          Text('Я соглашаюсь с ', style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(width: 2.0),
          const Terms(),
        ],
      ),
    );
  }
}

class _ProductItem<T> {
  T data;
}
