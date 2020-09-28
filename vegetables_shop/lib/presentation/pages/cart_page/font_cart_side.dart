import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/common_widgets/terms/terms.dart';

import '../../resources/app_strings.dart';
import 'cart_products_list_element.dart';

class FontSide extends StatefulWidget {
  final AnimationController flipController;

  const FontSide({Key key, this.flipController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FontSideState();
}

class _FontSideState extends State<FontSide> {
  final ValueNotifier<bool> _buttonCanBeActiveNotifier =
      ValueNotifier<bool>(false);

  List<_ProductItem> _selectedProductItems = List();

  bool _isCheckBoxSelected = false;

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

  Padding _cartTitle() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.yourProducts,
                style: Theme.of(context).textTheme.subtitle2),
            Text(AppStrings.totalPrice(_getTotalPrice()),
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontSize: 16.0,
                    )),
          ],
        ),
      );

  Expanded _productsList() => Expanded(
        flex: 3,
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
                  _checkButtonState();
                  setState(() {
                    //TODO: add item to _selectedProductItems list after tap
                    //_selectedProductItems.add();
                  });
                },
              );
            }),
      );

  Padding _paySection() => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _AgreeWithTermsCheckBox(
              isSelected: _isCheckBoxSelected,
              onSelectedChanged: (bool selected) {
                _onCheckBoxTap(selected);
                _checkButtonState();
              },
            ),
            ValueListenableBuilder(
              valueListenable: _buttonCanBeActiveNotifier,
              builder: (BuildContext context, canBeActive, _) {
                return AnimatedMainButton.fromText(AppStrings.transitToPayment,
                    height: 54.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    onTap: canBeActive ? _navigateToPaySection : null);
              },
            ),
          ],
        ),
      );

  Future<void> _navigateToPaySection() async {
    if (_buttonIsActive()) {
      widget.flipController.forward();
    }
  }

  void _checkButtonState() {
    _buttonCanBeActiveNotifier.value = _buttonIsActive();
  }

  bool _buttonIsActive() {
    //TODO: check on _selectedProductItems.isNotEmpty && _isCheckBoxSelected
    return _isCheckBoxSelected;
  }

  double _getTotalPrice() {
    const double defaultPrice = 0.0;
    double totalPrice = defaultPrice;
    for (_ProductItem item in _selectedProductItems) {
      totalPrice += item.data.price;
    }
    return totalPrice;
  }

  void _onCheckBoxTap(bool selected) {
    setState(() {
      _isCheckBoxSelected = selected;
    });
  }
}

class _AgreeWithTermsCheckBox extends StatelessWidget {
  final ValueChanged<bool> onSelectedChanged;
  final bool isSelected;

  const _AgreeWithTermsCheckBox(
      {Key key, @required this.onSelectedChanged, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (bool value) {
              onSelectedChanged(value);
            },
          ),
          Text('Я соглашаюсь с ',
              style: Theme.of(context).textTheme.bodyText1,
              overflow: TextOverflow.clip),
          Expanded(
            child: const Terms(),
          ),
        ],
      ),
    );
  }
}

class _ProductItem<T> {
  T data;
}
