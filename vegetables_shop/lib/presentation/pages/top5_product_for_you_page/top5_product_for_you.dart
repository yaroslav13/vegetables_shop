import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegetable_shop/common_widgets/animated_main_button/animated_main_button.dart';
import 'package:vegetable_shop/common_widgets/default_app_bar/default_app_bar.dart';
import 'package:vegetable_shop/common_widgets/input_field/input_field.dart';
import 'package:vegetable_shop/data/models/product/top_product.dart';
import 'package:vegetable_shop/presentation/bloc/base_screen.dart';
import 'package:vegetable_shop/presentation/bloc/top5_product_for_you_bloc/top5_product_for_you_bloc.dart';
import 'package:vegetable_shop/presentation/pages/top5_product_for_you_page/top5_product_tile/top5_product_tile.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';
import 'package:vegetable_shop/presentation/resources/app_strings.dart';
import 'package:vegetable_shop/utilits/extentions.dart';

class TopFiveProductForYouPage extends BaseScreen {
  @override
  _TopFiveProductForYouPageState createState() =>
      _TopFiveProductForYouPageState();
}

class _TopFiveProductForYouPageState
    extends BaseState<TopFiveProductForYouPage, TopFiveProductForYouBloc> {
  final TextEditingController _caloriesTextField = TextEditingController();
  final ValueNotifier<bool> _isFieldNotEmpty = ValueNotifier<bool>(false);

  VitaminEnum _priorityVitamin = VitaminEnum.A;
  Nutrients _nutrient = Nutrients.carbohydrates;

  @override
  void initState() {
    super.initState();
    _caloriesTextField.addListener(_caloriesFieldListener);
  }

  @override
  DefaultAppBar appBar() =>
      DefaultAppBar.fromText(AppStrings.topFiveProductForYouTitle);

  @override
  Widget body() => SafeArea(
        child: Column(
          children: [
            _searchParams(),
            Expanded(
              child: StreamBuilder<List<TopProduct>>(
                stream: bloc.topFiveProducts,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isEmpty) {
                      return const _NotFound();
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int i) {
                          return TopFiveProductTile(
                            product: snapshot.data[i],
                            priorityVitamin: _priorityVitamin.getVitaminName,
                          );
                        });
                  } else {
                    return const _NotFound();
                  }
                },
              ),
            ),
          ],
        ),
      );

  @override
  TopFiveProductForYouBloc provideBloc() => TopFiveProductForYouBloc();

  @override
  void dispose() {
    _caloriesTextField.dispose();
    super.dispose();
  }

  Container _searchParams() => Container(
        height: MediaQuery.of(context).size.height * 0.52,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
              child: Text('${AppStrings.desiredCalories}:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: AppColors.mineShaft)),
            ),
            _inputCalories(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
              child: Text('${AppStrings.priorityVitamin}:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: AppColors.mineShaft)),
            ),
            _buildVitaminChooser(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
              child: Text('${AppStrings.priorityNutrients}:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: AppColors.mineShaft)),
            ),
            _buildNutrientChooser(),
            _searchButton(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
              child: Text('${AppStrings.topFiveProductForYouTitle}:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: AppColors.mineShaft)),
            ),
          ],
        ),
      );

  Row _inputCalories() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputField(
            height: 56.0,
            width: MediaQuery.of(context).size.width * 0.7,
            controller: _caloriesTextField,
            textInputFormatterList: [
              WhitelistingTextInputFormatter.digitsOnly,
            ],
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(AppStrings.kal, style: Theme.of(context).textTheme.bodyText1),
        ],
      );

  Padding _buildVitaminChooser() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CheckBoxSection(
              name: AppStrings.vitaminA,
              isSelected: _priorityVitamin == VitaminEnum.A,
              onSelectedChanged: (_) {
                setState(() {
                  _priorityVitamin = VitaminEnum.A;
                });
              },
            ),
            _CheckBoxSection(
              name: AppStrings.vitaminB,
              isSelected: _priorityVitamin == VitaminEnum.B,
              onSelectedChanged: (_) {
                setState(() {
                  _priorityVitamin = VitaminEnum.B;
                });
              },
            ),
            _CheckBoxSection(
              name: AppStrings.vitaminC,
              isSelected: _priorityVitamin == VitaminEnum.C,
              onSelectedChanged: (_) {
                setState(() {
                  _priorityVitamin = VitaminEnum.C;
                });
              },
            ),
          ],
        ),
      );

  Padding _buildNutrientChooser() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CheckBoxSection(
              name: AppStrings.proteins,
              isSelected: _nutrient == Nutrients.proteins,
              onSelectedChanged: (_) {
                setState(() {
                  _nutrient = Nutrients.proteins;
                });
              },
            ),
            _CheckBoxSection(
              name: AppStrings.carbohydrates,
              isSelected: _nutrient == Nutrients.carbohydrates,
              onSelectedChanged: (_) {
                setState(() {
                  _nutrient = Nutrients.carbohydrates;
                });
              },
            ),
            _CheckBoxSection(
              name: AppStrings.fats,
              isSelected: _nutrient == Nutrients.fats,
              onSelectedChanged: (_) {
                setState(() {
                  _nutrient = Nutrients.fats;
                });
              },
            ),
          ],
        ),
      );

  Widget _searchButton() => ValueListenableBuilder(
      valueListenable: _isFieldNotEmpty,
      builder: (BuildContext context, isAvailable, _) {
        return AnimatedMainButton.fromText(
          AppStrings.search,
          height: 54.0,
          width: MediaQuery.of(context).size.width * 0.9,
          onTap: isAvailable ? getTopFiveProducts : null,
        );
      });

  Future<void> getTopFiveProducts() async {
    await bloc.getTopFiveProducts(
      priorityVitamin: _priorityVitamin.getVitaminName,
      priorityUsefulSubstances: _nutrient.getNutrientsName,
      calories: double.parse(_caloriesTextField.text),
    );
  }

  void _caloriesFieldListener() {
    _isFieldNotEmpty.value = _caloriesTextField.text.isNotEmpty;
  }
}

class _CheckBoxSection extends StatelessWidget {
  final String name;
  final bool isSelected;
  final ValueChanged<bool> onSelectedChanged;

  const _CheckBoxSection(
      {Key key, this.isSelected = false, this.onSelectedChanged, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name, style: Theme.of(context).textTheme.bodyText1),
        const SizedBox(
          width: 7.0,
        ),
        Checkbox(
          value: isSelected,
          onChanged: (bool value) {
            onSelectedChanged(value);
          },
        ),
      ],
    );
  }
}

class _NotFound extends StatelessWidget {
  const _NotFound();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.notFound,
          style: Theme.of(context).textTheme.subtitle2),
    );
  }
}
