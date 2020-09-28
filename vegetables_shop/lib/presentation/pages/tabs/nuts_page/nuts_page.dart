import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/app_drawer/app_drawer.dart';
import 'package:vegetable_shop/common_widgets/main_app_bar/main_app_bar.dart';
import 'package:vegetable_shop/common_widgets/grid_view_section/grid_view_section.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/nuts_bloc/nuts_bloc.dart';

import '../vegetables_page/vegetables_page.dart';

class NutsPage extends BaseScreen {
  @override
  _NutsPageState createState() => _NutsPageState();
}

class _NutsPageState extends BaseState<NutsPage, NutsBloc> {
  final TextEditingController _searchController = TextEditingController();


  @override
  PreferredSizeWidget appBar() => MainAppBar(
    searchController: _searchController,
  );

  @override
  Widget body() => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: 12.0),
      padding: const EdgeInsets.all(12.0),
      itemCount: 10,
      itemBuilder: (BuildContext context, int i) {
        return GridViewProductElement(
          productName: 'Product name',
          price: 300,
          country: 'Ukraine',
        );
      });

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  NutsBloc provideBloc() => NutsBloc();

  @override
  Widget drawer() => AppDrawer();

}
