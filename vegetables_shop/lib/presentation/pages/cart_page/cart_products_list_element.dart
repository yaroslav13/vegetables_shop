import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/data/models/cart.dart';
import 'package:vegetable_shop/data/models/product/product.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';

class CartProductsListElement extends StatelessWidget {
  final Cart cart;

  const CartProductsListElement({Key key, this.cart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DottedBorder(
        radius: const Radius.circular(16.0),
        strokeWidth: 1.0,
        dashPattern: [5, 4],
        borderType: BorderType.RRect,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _productDescription(context),
            _selectedItem(context),
          ],
        ),
      ),
    );
  }

  Padding _productDescription(BuildContext context) => Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            FutureBuilder<Product>(
                future: BlocProvider.of<CartBloc>(context)
                    .getProductById(cart.productId),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(snapshot.data.productPhoto),
                      )),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
            const SizedBox(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<Product>(
                    future: BlocProvider.of<CartBloc>(context)
                        .getProductById(cart.productId),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.productName,
                            style: Theme.of(context).textTheme.bodyText1);
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                const SizedBox(
                  height: 5.0,
                ),
                Text('${cart.desiredWeight} г',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 16,
                        )),
                const SizedBox(
                  height: 5.0,
                ),
                Text('${cart.cartPrice} грн',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 14.0)),
              ],
            ),
          ],
        ),
      );

  Padding _selectedItem(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: GestureDetector(
            onTap: () => _handlePress(context),
            child: Image.asset(AppImages.trash, width: 30.0, height: 30.0)),
      );

  void _handlePress(BuildContext context) {
    BlocProvider.of<CartBloc>(context).deleteCart(cart.productId);
  }
}
