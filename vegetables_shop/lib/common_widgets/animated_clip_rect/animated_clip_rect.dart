import 'package:flutter/cupertino.dart';

class AnimatedClipRect extends StatefulWidget {
  @override
  _AnimatedClipRectState createState() => _AnimatedClipRectState();

  final Widget child;
  final ValueNotifier<bool> notifier;
  final bool horizontalAnimation;
  final bool verticalAnimation;
  final Alignment alignment;
  final Duration duration;
  final Duration reverseDuration;
  final Curve curve;
  final Curve reverseCurve;
  final double begin;
  final double end;

  ///The behavior of the controller when [AccessibilityFeatures.disableAnimations] is true.
  final AnimationBehavior animationBehavior;

  AnimatedClipRect(
      {this.child,
        @required this.notifier,
        this.horizontalAnimation = true,
        this.verticalAnimation = true,
        this.alignment = Alignment.center,
        this.duration,
        this.reverseDuration,
        this.curve = Curves.linear,
        this.reverseCurve,
        this.animationBehavior = AnimationBehavior.normal,
        this.begin = 0.0,
        this.end = 1.0});
}

class _AnimatedClipRectState extends State<AnimatedClipRect>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: widget.duration ?? const Duration(milliseconds: 500),
        reverseDuration: widget.reverseDuration ??
            (widget.duration ?? const Duration(milliseconds: 500)),
        vsync: this,
        value: widget.notifier.value ? widget.end : widget.begin,
        animationBehavior: widget.animationBehavior);
    _animation =
        Tween(begin: widget.begin, end: widget.end).animate(CurvedAnimation(
          parent: _animationController,
          curve: widget.curve,
          reverseCurve: widget.reverseCurve ?? widget.curve,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, child) {
            return Align(
              alignment: widget.alignment,
              heightFactor: widget.verticalAnimation ? _animation.value : 1.0,
              widthFactor: widget.horizontalAnimation ? _animation.value : 1.0,
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
      builder: (BuildContext context, value, Widget child) {
        value ? _animationController.forward() : _animationController.reverse();
        return child;
      },
      valueListenable: widget.notifier,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
