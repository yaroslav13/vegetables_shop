import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegetable_shop/common_widgets/terms/terms.dart';
import 'package:vegetable_shop/common_widgets/user_placeholder/user_placeholder.dart';
import 'package:vegetable_shop/data/models/customer.dart';
import 'package:vegetable_shop/presentation/bloc/app_drawer_bloc/app_drawer_bloc.dart';
import 'package:vegetable_shop/presentation/bloc/base_drawer.dart';
import 'package:vegetable_shop/presentation/pages/log_in_page/log_in_page.dart';
import 'package:vegetable_shop/presentation/pages/product_cheque_page/product_cheque_page.dart';
import 'package:vegetable_shop/presentation/pages/top5_product_for_you_page/top5_product_for_you.dart';
import 'package:vegetable_shop/presentation/pages/update_address_page/update_address_page.dart';
import 'package:vegetable_shop/presentation/pages/update_payment_card_page/update_payment_card_page.dart';
import 'package:vegetable_shop/presentation/pages/update_profile_page/update_profile_page.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/routes/routes.dart';

class AppDrawer extends BaseDrawer {
  @override
  State<StatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends BaseState<AppDrawer, AppDrawerBloc> {
  @override
  Widget body() => Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.5,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder<Customer>(
                    future: bloc.getCustomer(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        Customer customer = snapshot.data;
                        return UserPlaceholder(
                          imagePath: customer.photoUrl,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                const Divider(color: AppColors.turquoise),
                FutureBuilder<Customer>(
                    future: bloc.getCustomer(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        Customer customer = snapshot.data;
                        return _DrawerSections(
                            imagePath: AppImages.profileIcon,
                            text: AppStrings.updateProfileInfo,
                            onTap: () {
                              _navigateToProfilePage(customer);
                            });
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                FutureBuilder<Address>(
                    future: bloc.getAddress(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        Address address = snapshot.data;
                        return _DrawerSections(
                            imagePath: AppImages.locationIcon,
                            text: AppStrings.address,
                            onTap: () {
                              _navigateToUpdateAddressPage(address);
                            });
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
                FutureBuilder<PaymentCard>(
                    future: bloc.getPaymentCard(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        PaymentCard card = snapshot.data;
                        return _DrawerSections(
                            imagePath: AppImages.creditCardIcon,
                            text: AppStrings.cardName,
                            onTap: () {
                              _navigateToUpdatePaymentCard(card);
                            });
                      } else {
                        return SizedBox.shrink();
                      }
                    }),
            _DrawerSections(
                imagePath: AppImages.cheque,
                text: AppStrings.chequeTitle,
                onTap: _navigateToCheques),
                _DrawerSections(
                    imagePath: AppImages.topFiveIcon,
                    text: AppStrings.topFive,
                    onTap: _navigateToTopFiveForYouPage),
                _DrawerSections(
                    imagePath: AppImages.telephone,
                    text: AppStrings.contacts,
                    onTap: _launchToCall),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: const Terms(),
                ),
                const Divider(color: AppColors.turquoise),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: _DrawerSections(
                    imagePath: AppImages.logout,
                    text: AppStrings.exit,
                    onTap: _logout,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  AppDrawerBloc provideBloc() => AppDrawerBloc();

  _launchToCall() async {
    const url = 'tel:+380992926152';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _navigateToProfilePage(Customer customer) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => UpdateProfilePage(customer)));
  }

  _navigateToUpdateAddressPage(Address address) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => UpdateAddressPage(address)));
  }

  _navigateToCheques() {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => ProductChequePage()));
  }

  _navigateToUpdatePaymentCard(PaymentCard card) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => UpdatePaymentCardPage(card)));
  }

  _navigateToTopFiveForYouPage() => Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => TopFiveProductForYouPage()));

  Future<void> _logout() async {
    await bloc.logout().whenComplete(() => Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true, builder: (context) => LogInPage())));
  }
}

class _DrawerSections extends StatefulWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const _DrawerSections(
      {Key key, @required this.imagePath, @required this.text, this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrawerSectionsState();
}

class _DrawerSectionsState extends State<_DrawerSections>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacityAnimation;
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _reverseAnimation();
        }
      });
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.bounceInOut,
      parent: _controller,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: GestureDetector(
            onTap: _handleTap,
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(widget.imagePath,
                              height: 20.0,
                              width: 20.0,
                              color: _selected
                                  ? AppColors.lightKhaki
                                  : AppColors.onPrimary),
                          const SizedBox(width: 5.0),
                          Text(widget.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      fontSize: 18,
                                      color: _selected
                                          ? AppColors.lightKhaki
                                          : AppColors.onPrimary)),
                        ],
                      ),
                      Opacity(
                        opacity: _opacityAnimation.value,
                        child: Image.asset(AppImages.rightArrow,
                            width: 20.0,
                            height: 20.0,
                            color: AppColors.lightKhaki),
                      ),
                    ],
                  ),
                  Divider(
                      color: _selected
                          ? AppColors.lightKhaki
                          : AppColors.turquoise)
                ],
              ),
            )));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _forwardAnimation() {
    _selected = true;
    _controller.forward();
  }

  void _reverseAnimation() {
    _selected = false;
    _controller.reverse();
  }

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap();
    }
    _forwardAnimation();
  }
}
