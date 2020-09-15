import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/loader_indicator/loader_indicator.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';

const Size carouselDotSize = Size(10.0, 10.0);

class ImagesCarousel extends StatefulWidget {
  final List<String> imagesUrl;
  final double height;

  const ImagesCarousel({Key key, this.imagesUrl, this.height})
      : super(key: key);

  @override
  _ImagesCarouselState createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  final ValueNotifier<int> carouselIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.imagesUrl.forEach((imageUrl) {
        precacheImage(CachedNetworkImageProvider(imageUrl), context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      CarouselSlider.builder(
        height: widget.height,
        itemCount: widget.imagesUrl.length,
        enableInfiniteScroll: false,
        viewportFraction: 1.0,
        itemBuilder: (context, i) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: CachedNetworkImage(
              imageUrl: widget.imagesUrl[i],
              fit: BoxFit.cover,
              placeholder: (context, _) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(child: const LoadingIndicator()),
                );
              },
            ),
          );
        },
        onPageChanged: (i) {
          carouselIndex.value = i;
        },
      ),
      _dotsIndicator(widget.imagesUrl.length),
    ]);
  }

  @override
  void dispose() {
    carouselIndex.dispose();
    super.dispose();
  }

  Widget _dotsIndicator(int imagesCount) {
    return Container(
      height: widget.height,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsetsDirectional.only(bottom: 24.0),
          child: ValueListenableBuilder<int>(
            valueListenable: carouselIndex,
            builder: (BuildContext context, value, Widget child) {
              return DotsIndicator(
                dotsCount: imagesCount,
                position: value.toDouble(),
                decorator: DotsDecorator(
                  size: carouselDotSize,
                  activeSize: carouselDotSize,
                  activeColor: AppColors.mantis,
                  color: Colors.white.withOpacity(0.5),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
