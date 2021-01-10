import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/common_widgets/terms/terms.dart';
import 'package:vegetable_shop/data/models/cart.dart';
import 'package:vegetable_shop/data/models/totalPrice.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/cart_bloc/cart_bloc.dart';

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

  bool _isCheckBoxSelected = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).getTotalCartPrice();
    BlocProvider.of<CartBloc>(context).getCarts();
  }


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
            FutureBuilder<TotalPrice>(
              future: BlocProvider.of<CartBloc>(context).getTotalCartPrice(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return Text(AppStrings.totalPrice(snapshot.data.totalPrice),
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontSize: 16.0,
                          ));
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      );

  Expanded _productsList() => Expanded(
        flex: 3,
        child: StreamBuilder<List<Cart>>(
          stream: BlocProvider.of<CartBloc>(context).carts,
          builder: (BuildContext context, snapshot){
            if(snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int i) {
                    return CartProductsListElement(
                      cart: snapshot.data[i],
                    );
                  });
            }else {
              return SizedBox.shrink();
            }
          },
        ),
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

  bool _buttonIsActive() => _isCheckBoxSelected;

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
          Text(AppStrings.iAgree,
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
