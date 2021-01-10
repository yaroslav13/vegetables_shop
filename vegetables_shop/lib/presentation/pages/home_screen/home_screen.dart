import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/app_drawer/app_drawer.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/bloc_provider.dart';
import 'package:vegetable_shop/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:vegetable_shop/presentation/pages/tabs/fruits_page/fruits_page.dart';
import 'package:vegetable_shop/presentation/pages/tabs/mushrooms_page/mushrooms_page.dart';
import 'package:vegetable_shop/presentation/pages/tabs/nuts_page/nuts_page.dart';
import 'package:vegetable_shop/presentation/pages/tabs/spices_page/spices_page.dart';
import 'package:vegetable_shop/presentation/pages/tabs/vegetables_page/vegetables_page.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_images.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';

const startTab = 2;

class HomeScreen extends BaseScreen {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeBloc> {
  ValueNotifier<int> notifier;

  List<BottomNavigationBarItem> _tabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(AppImages.bananas)),
        title: Text(AppStrings.fruits)),
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(AppImages.chili)),
        title: Text(AppStrings.spices)),
    BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(AppImages.carrot)),
      title: Text(AppStrings.vegetables),
      activeIcon: Container(
        height: 25.0,
      ),
    ),
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(AppImages.mushroom)),
        title: Text(AppStrings.mushrooms)),
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(AppImages.nut)),
        title: Text(AppStrings.nuts)),
  ];

  @override
  void initState() {
    super.initState();
    notifier = ValueNotifier(startTab);
  }

  @override
  Widget body() => _TabPages(
        notifier: notifier,
      );

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  HomeBloc provideBloc() => HomeBloc();

  @override
  Widget drawer() => AppDrawer();

  @override
  Widget floatingActionButton() => ValueListenableBuilder<int>(
        valueListenable: notifier,
        builder: (BuildContext context, value, _) {
          return _getFloatingTab(value);
        },
      );

  @override
  Widget bottomNavigationBar() => ValueListenableBuilder<int>(
        valueListenable: notifier,
        builder: (BuildContext context, value, _) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: value,
            selectedItemColor: AppColors.lightKhaki,
            backgroundColor: AppColors.mantis,
            items: _tabs,
            onTap: (int i) {
              notifier.value = i;
            },
          );
        },
      );

  @override
  double get drawerEdgeDragWidth => 0.0;

  Widget _getFloatingTab(int currentIndex) {
    var padding = MediaQuery.of(context).viewPadding.bottom;
    if (padding > 0) {
      padding = padding - 8.0;
    }
    if (currentIndex == 2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 26 + padding),
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 48.0,
            width: 48.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mantis,
                border: Border.all(color: Colors.white, width: 2.0)),
            child: Center(
              child: Image.asset(
                AppImages.carrot,
              ),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _TabPages extends StatelessWidget {
  final ValueNotifier<int> notifier;
  final List<Widget> tabs;

  _TabPages({this.notifier}) : tabs = _buildTabs();

  static List<Widget> _buildTabs() {
    return <Widget>[
      FruitsPage(),
      SpicesPage(),
      VegetablesPage(),
      MushroomsPage(),
      NutsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: HomeBloc(),
      child: ValueListenableBuilder<int>(
        valueListenable: notifier,
        builder: (BuildContext context, value, _) {
          return IndexedStack(
            index: value,
            children: tabs,
          );
        },
      ),
    );
  }
}
