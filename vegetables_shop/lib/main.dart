import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegetable_shop/data/repository/cache_manager/cache_manager.dart';
import 'package:vegetable_shop/data/repository/cache_manager/data_cache_manager.dart';
import 'package:vegetable_shop/presentation/bloc/base_bloc.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/pages/splash_screen/splash_screen.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';

import 'presentation/bloc/base_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: ApplicationBloc(),
        child: MaterialApp(
          builder: (_context, navigator) {
            return Theme(
              data: _appTheme(_context),
              child: navigator,
            );
          },
          theme: _appTheme(context),
          home: const SplashScreen(),
        ));
  }

  _appTheme(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ThemeData(
        appBarTheme: AppBarTheme(
            brightness: Brightness.light, color: Colors.transparent),
        dividerTheme: _dividerTheme(),
        fontFamily: 'Como',
        scaffoldBackgroundColor: AppColors.background,
        cursorColor: AppColors.onPrimary,
        accentColor: AppColors.mantis,
        primaryColor: AppColors.mantis,
        textTheme: _textTheme(),
        buttonTheme: ButtonThemeData(
          height: 48.0,
          buttonColor: AppColors.mantis,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(8.0)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(8.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(8.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(8.0)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8.0)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(8.0))));
  }

  TextTheme _textTheme() {
    return TextTheme(
      headline5: TextStyle(
          color: Colors.white,
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Como'),
      subtitle2: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.w500),
      subtitle1: TextStyle(
          fontSize: 20.0,
          color: AppColors.onPrimary,
          fontWeight: FontWeight.bold,
          fontFamily: 'Manjari'),
      bodyText1: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 16.0,
          fontWeight: FontWeight.w500),
      button: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
      bodyText2: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 16.0,
          fontWeight: FontWeight.w400),
      overline:
          TextStyle(fontSize: 48.0, height: 1.2, color: AppColors.lightKhaki),
      headline4: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 15.0,
          fontWeight: FontWeight.w500),
      headline3: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
    );
  }

  DividerThemeData _dividerTheme() {
    return DividerThemeData(thickness: 1.0);
  }
}

class ApplicationBloc extends BaseBloc {
  final CacheManager _cacheManager = DataCacheManager();

  Future<bool> isLogined() async {
    return await _cacheManager.getUser() != null;
  }
}
