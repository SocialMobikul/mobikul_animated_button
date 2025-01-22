import 'package:flutter/material.dart';

class MobiKulWaveButton extends StatefulWidget {
  const MobiKulWaveButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderRadius = 50.0,
    this.textStyle,
    this.backgroundColor = Colors.black,
    this.verticalPadding = 14.0,
    this.horizontalPadding = 42.0,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.easeInOut,
    this.waveLength = 6.0,
  });

  final VoidCallback onPressed;
  final double borderRadius;
  final Color backgroundColor;
  final double verticalPadding;
  final double horizontalPadding;
  final Duration duration;
  final Curve curve;
  final double waveLength;
  final String text;
  final TextStyle? textStyle;

  @override
  State<MobiKulWaveButton> createState() => _MobiKulWaveButtonState();
}

class _MobiKulWaveButtonState extends State<MobiKulWaveButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.addStatusListener(_controllerListener);
  }

  void _controllerListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_controllerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
        widget.onPressed();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBorderButton(
            animation: _controller,
            curve: widget.curve,
            verticalPadding: widget.verticalPadding,
            horizontalPadding: widget.horizontalPadding,
            waveLength: widget.waveLength,
            backgroundColor: widget.backgroundColor,
            borderRadius: widget.borderRadius,
            child: Text(
              widget.text,
              style: widget.textStyle ??
                  Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius + 2),
              color: widget.backgroundColor,
            ),
            padding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding,
              horizontal: widget.horizontalPadding,
            ),
            margin: EdgeInsets.all(widget.waveLength),
            child: Text(
              widget.text,
              style: widget.textStyle ??
                  Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBorderButton extends AnimatedWidget {
  const AnimatedBorderButton({
    super.key,
    required this.animation,
    required this.curve,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.borderRadius,
    required this.waveLength,
    required this.backgroundColor,
    required this.child,
  }) : super(listenable: animation);

  final Animation<double> animation;
  final Curve curve;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final double waveLength;
  final Color backgroundColor;
  final Widget child;

  Animation<double> get _verticalBorderAnimation => Tween<double>(
        begin: verticalPadding - waveLength,
        end: verticalPadding + waveLength,
      ).animate(_curvedAnimation);

  Animation<double> get _horizontalBorderAnimation => Tween<double>(
        begin: horizontalPadding - waveLength,
        end: horizontalPadding + waveLength,
      ).animate(_curvedAnimation);

  Animation<double> get _borderAnimation => Tween<double>(
        begin: waveLength,
        end: 0.0,
      ).animate(_curvedAnimation);

  Animation<double> get _curvedAnimation => CurvedAnimation(
        parent: animation,
        curve: curve,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: backgroundColor,
            width: _borderAnimation.value,
          ),
          color: Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(
          vertical: _verticalBorderAnimation.value,
          horizontal: _horizontalBorderAnimation.value,
        ),
        child: child);
  }
}
