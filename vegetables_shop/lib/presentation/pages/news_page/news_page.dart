import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/default_app_bar/default_app_bar.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:vegetable_shop/presentation/pages/news_page/news_section.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

class NewsPage extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _NewsPageState();
}

class _NewsPageState extends BaseState<NewsPage, NewsBloc> {
  @override
  PreferredSizeWidget appBar() => DefaultAppBar.fromText(AppStrings.news);

  @override
  Widget body() => SafeArea(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (BuildContext context, int i) {
            return NewsSection(
              title: 'Обвал цен',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tristique, dui at condimentum dignissim, ligula sem rhoncus nisl, at fringilla purus magna vitae tortor. Proin felis justo, gravida a mattis nec, interdum et mi. Vestibulum mollis erat porta, sodales neque in, ultrices ex. Fusce pellentesque urna in dignissim posuere. Nullam ut nisi malesuada, pretium quam sit amet, sodales nibh. Sed quam nisi, luctus quis laoreet ac, molestie eget est. Cras eros ex, porttitor in bibendum et, tempus eu sem. In diam leo, eleifend non mollis sit amet, aliquet sit amet justo. Nunc pellentesque risus id ligula placerat euismod. Sed id risus in purus elementum ullamcorper ut bibendum magna. Donec eu posuere arcu.',
            );
          }));

  @override
  NewsBloc provideBloc() => NewsBloc();
}
