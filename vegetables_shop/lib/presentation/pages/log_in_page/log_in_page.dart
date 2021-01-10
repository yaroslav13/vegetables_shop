import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/error_parser/error_parser.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/log_in_bloc/log_in_bloc.dart';
import 'package:vegetable_shop/presentation/pages/home_screen/home_screen.dart';
import 'package:vegetable_shop/presentation/pages/registration_page/registration_page.dart';
import '../../../common_widgets/animated_main_button/animated_main_button.dart';
import '../../../common_widgets/input_field/input_field.dart';
import '../../../common_widgets/terms/terms.dart';
import '../../bloc/base_screen.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_images.dart';
import '../../resources/app_strings.dart';

class LogInPage extends BaseScreen {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends BaseState<LogInPage, LogInBloc> {
  @override
  Widget body() => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _title(),
              Image.asset(AppImages.shopLogo),
              const _AuthFields(),
            ],
          ),
        ),
      );

  @override
  LogInBloc provideBloc() => LogInBloc();

  @override
  Color backgroundColor() => AppColors.lightKhaki;

  Padding _title() => Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(AppStrings.appName,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: AppColors.surface,
                  fontSize: 24.0,
                )),
      );
}

class _AuthFields extends StatefulWidget {
  const _AuthFields();

  @override
  _AuthFieldsState createState() => _AuthFieldsState();
}

class _AuthFieldsState extends State<_AuthFields> {
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final ValueNotifier<String> _errorNotifier = ValueNotifier<String>("");

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ErrorParser(
          errorParser: _errorNotifier,
        ),
        InputField(
          height: 54.0,
          width: MediaQuery.of(context).size.width * 0.9,
          controller: _emailFieldController,
        ),
        InputField(
          height: 54.0,
          width: MediaQuery.of(context).size.width * 0.9,
          controller: _passwordFieldController,
          obscureText: _obscureText,
          suffixIcon: GestureDetector(
            child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        const _RegistrationButton(),
        _terms(),
        _logInButton(),
      ],
    );
  }

  Padding _terms() => Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: const Terms(),
      );

  Padding _logInButton() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: AnimatedMainButton.fromText(AppStrings.singIn,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 54.0,
            onTap: _navigateToHomeScreen,
            onDone: _onSuccess,
            onError: _onError),
      );

  void _onSuccess() {
    _errorNotifier.value = "";
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ));
  }

  void _onError() {
    _errorNotifier.value = AppStrings.notFoundUser;
  }

  Future<void> _navigateToHomeScreen() async {
    if (_emailFieldController.text.isNotEmpty &&
        _passwordFieldController.text.isNotEmpty) {
      BlocProvider.of<LogInBloc>(context)
          .getUser(_emailFieldController.text, _passwordFieldController.text);
    }
  }
}

class _RegistrationButton extends StatelessWidget {
  const _RegistrationButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: GestureDetector(
            onTap: () {
              _navigateToRegistrationPage(context);
            },
            child: Text(
              AppStrings.singUp,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: AppColors.coral,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2.0),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.start,
            )));
  }

  _navigateToRegistrationPage(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationPage(),
      ));
}
