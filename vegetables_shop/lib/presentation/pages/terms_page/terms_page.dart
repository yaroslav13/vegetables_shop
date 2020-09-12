import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vegetable_shop/common_widgets/default_app_bar/default_app_bar.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/terms_bloc/terms_bloc.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

class TermsPage extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _TermsPageState();
}

class _TermsPageState extends BaseState<TermsPage, TermsBloc> {
  @override
  PreferredSizeWidget appBar() => DefaultAppBar.fromText(AppStrings.terms);

  @override
  Widget body() => SafeArea(
        child: FutureBuilder<String>(
          future: bloc.getTerms(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Html(
                    data: snapshot.data,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      );

  @override
  TermsBloc provideBloc() => TermsBloc();
}
