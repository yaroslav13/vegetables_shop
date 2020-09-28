import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/loader_indicator/loader_indicator.dart';
import 'package:vegetable_shop/presentation/pages/log_in_page/log_in_page.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

const animDuration = const Duration(milliseconds: 350);

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _logoAnimation;
  Animation<Offset> _titleAnimation;
  CurvedAnimation _curvedLogoAnimation;
  CurvedAnimation _curvedTitleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: animDuration)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(seconds: 2))
              .then((_) => _navigateToHomeScreen());
        }
      });
    _curvedLogoAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.linear);
    _logoAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_curvedLogoAnimation);
    _curvedTitleAnimation = CurvedAnimation(
      curve: Curves.bounceIn,
      parent: _controller,
    );
    _titleAnimation = Tween<Offset>(begin: Offset(5.0, 0.0), end: Offset.zero)
        .animate(_curvedTitleAnimation);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightKhaki,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _logo(),
          _title(),
          const SizedBox(height: 25.0),
          const LoadingIndicator(color: Colors.white),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _logo() => Opacity(
        opacity: _logoAnimation.value,
        child: Image.asset(AppImages.shopLogo),
      );

  Padding _title() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SlideTransition(
        position: _titleAnimation,
        child: Text(AppStrings.appName,
            style: Theme.of(context).textTheme.headline5),
      ));

  _navigateToHomeScreen() => Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true, builder: (context) => LogInPage()));
}
