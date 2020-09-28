import 'package:flutter/cupertino.dart';
import 'package:vegetable_shop/common_widgets/app_drawer/app_drawer.dart';
import 'package:vegetable_shop/common_widgets/main_app_bar/main_app_bar.dart';
import 'package:vegetable_shop/common_widgets/grid_view_section/grid_view_section.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/spices_bloc/spices_bloc.dart';
import 'package:vegetable_shop/utilits/extentions.dart';

import '../vegetables_page/vegetables_page.dart';

class SpicesPage extends BaseScreen {
  @override
  _SpicesPageState createState() => _SpicesPageState();
}

class _SpicesPageState extends BaseState<SpicesPage, SpicesBloc> {
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
          unitType: UnitTypes.gram,
        );
      });

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  SpicesBloc provideBloc() => SpicesBloc();

  @override
  Widget drawer() => AppDrawer();
}
