import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetable_shop/common_widgets/loader_indicator/loader_indicator.dart';
import 'package:vegetable_shop/presentation/resources/app_colors.dart';

const Duration _kAnimationDuration = Duration(milliseconds: 270);

typedef UpdateCallback = Future<void> Function();

class AnimatedMainButton extends StatefulWidget {
  final double height;
  final double weight;
  final Widget child;
  final UpdateCallback onTap;
  final VoidCallback onDone;

  const AnimatedMainButton(
      {Key key, this.height, this.weight, this.child, this.onTap, this.onDone})
      : super(key: key);

  AnimatedMainButton.fromText(String text,
      {this.height, this.weight, this.onTap, this.onDone})
      : child = Text(text, style: TextStyle(fontSize: 14, color: Colors.white));

  @override
  State<StatefulWidget> createState() => _AnimatedMainButtonState();
}

class _AnimatedMainButtonState extends State<AnimatedMainButton> {
  _ResponseState _responseState = _ResponseState.done;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: widget.height,
        width: widget.weight,
        decoration: BoxDecoration(
            color: AppColors.mantis,
            borderRadius: const BorderRadius.all(
              const Radius.circular(8.0),
            )),
        child: Center(
          child: AnimatedSwitcher(
            duration: _kAnimationDuration,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: _responseState == _ResponseState.done
                ? widget.child
                : const LoadingIndicator(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _handleTap() async {
    if (widget.onTap == null) return;

    if (mounted && _responseState == _ResponseState.done) {
      setState(() {
        _responseState = _ResponseState.update;
      });
    }

    final refreshTap = widget.onTap();

    if (refreshTap == null) return;

    await refreshTap.then((_) {
      if (widget.onDone != null) {
        widget.onDone();
      }
    }).whenComplete(() {
      if (mounted) {
        setState(() {
          _responseState = _ResponseState.done;
        });
      }
    });
  }
}

enum _ResponseState { update, done }
