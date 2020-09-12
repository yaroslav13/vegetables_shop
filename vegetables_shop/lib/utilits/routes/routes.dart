import 'package:flutter/material.dart';

const routeDuration = Duration(milliseconds: 1200);

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({@required this.page})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(-1.0, 0.0), end: Offset.zero)
                      .animate(animation),
                  child: child,
                ));
}


class SlideUpRoute extends PageRouteBuilder {
  final Widget page;

  SlideUpRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionDuration: routeDuration,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: const Offset(0.0, 0.0),
          )
              .chain(CurveTween(
            curve: Curves.fastOutSlowIn,
          ))
              .animate(animation),
          child: child,
        ),
  );
}

class SlideDownRoute extends PageRouteBuilder {
  final Widget page;

  SlideDownRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionDuration: routeDuration,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: const Offset(0.0, 0.0),
          )
              .chain(CurveTween(
            curve: Curves.fastOutSlowIn,
          ))
              .animate(animation),
          child: child,
        ),
  );
}
