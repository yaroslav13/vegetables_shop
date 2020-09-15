import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';

class CartProductsListElement extends StatefulWidget {
  final bool selected;
  final int price;
  final VoidCallback onTap;
  final int weightOfProduct;
  final String productName;

  const CartProductsListElement(
      {Key key,
      this.selected,
      this.onTap,
      this.price,
      this.weightOfProduct,
      this.productName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CartProductsListElementState();
}

class _CartProductsListElementState extends State<CartProductsListElement> {
  bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected ?? false;
  }

  @override
  void didUpdateWidget(CartProductsListElement oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selected = widget.selected ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DottedBorder(
        radius: const Radius.circular(16.0),
        strokeWidth: 1.0,
        dashPattern: [5, 4],
        borderType: BorderType.RRect,
        child: RaisedButton(
          elevation: 0.8,
          color: Colors.white,
          onPressed: _handlePress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _productDescription(),
              _selectedItem(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _productDescription() => Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Image.asset('assets/cucumber.png', height: 50.0, width: 50.0),
            const SizedBox(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.productName,
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  height: 5.0,
                ),
                Text('${widget.weightOfProduct} г',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 16,
                        )),
                const SizedBox(
                  height: 5.0,
                ),
                Text('${widget.price} грн',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 14.0)),
              ],
            ),
          ],
        ),
      );

  Padding _selectedItem() => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 270),
          switchOutCurve: Curves.linear,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(child: child, scale: animation);
          },
          child: _selected
              ? Image.asset(AppImages.iconChecked, width: 30.0, height: 30.0)
              : Image.asset(AppImages.emptyOval, width: 30.0, height: 30.0),
        ),
      );

  void _handlePress() {
    if (widget.onTap != null) {
      widget.onTap();
    }
  }
}
