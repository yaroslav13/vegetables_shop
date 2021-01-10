import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/app_drawer/app_drawer.dart';
import 'package:vegetable_shop/common_widgets/main_app_bar/main_app_bar.dart';
import 'package:vegetable_shop/common_widgets/grid_view_section/grid_view_section.dart';
import 'package:vegetable_shop/data/models/product/product.dart';
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
  void initState() {
    super.initState();
    bloc.getProducts();
    _searchController.addListener(() => _onSearch(_searchController.text));
  }

  @override
  PreferredSizeWidget appBar() => MainAppBar(
        searchController: _searchController,
      );

  @override
  Widget body() => StreamBuilder<List<Product>>(
      stream: bloc.searchProducts,
      initialData: bloc.allNuts,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: childAspectRatio,
                  mainAxisSpacing: 12.0),
              padding: const EdgeInsets.all(12.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int i) {
                return GridViewProductElement(
                  product: snapshot.data[i],
                );
              });
        } else {
          return SizedBox.shrink();
        }
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

  void _onSearch(String request) {
    if (request == null) {
      return;
    }
    if (request.trim().isNotEmpty) {
      var searchResult = bloc.allNuts
          ?.where((item) => item.productName
              .toLowerCase()
              .startsWith(request.trim().toLowerCase()))
          ?.toList();
      bloc.searchProducts.add(searchResult);
    } else {
      bloc.searchProducts.add(bloc.allNuts);
    }
  }
}
