import 'package:flutter/material.dart';

/// A custom button widget that shows a wave animation when pressed.
class MobiKulWaveButton extends StatefulWidget {
  /// Creates a [MobiKulWaveButton] with the given properties.
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

  /// The callback function that is called when the button is pressed.
  final VoidCallback onPressed;

  /// The border radius of the button.
  final double borderRadius;

  /// The background color of the button.
  final Color backgroundColor;

  /// The vertical padding inside the button.
  final double verticalPadding;

  /// The horizontal padding inside the button.
  final double horizontalPadding;

  /// The duration of the wave animation.
  final Duration duration;

  /// The curve of the animation.
  final Curve curve;

  /// The wavelength of the wave animation.
  final double waveLength;

  /// The text to display on the button.
  final String text;

  /// The text style for the button's text. If not provided, defaults to the theme's body text style.
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
    // Initialize the animation controller with the given duration
    _controller = AnimationController(vsync: this, duration: widget.duration);
    // Add a listener to reset the animation when it completes
    _controller.addStatusListener(_controllerListener);
  }

  /// Resets the animation when it completes.
  void _controllerListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    // Remove the listener and dispose of the controller when the widget is disposed
    _controller.removeStatusListener(_controllerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        // Start the wave animation when the button is pressed
        _controller.forward();
        widget.onPressed();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBorderButton(
            // Pass animation parameters to the animated border button
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

/// An animated button with a border that changes size during the animation.
class AnimatedBorderButton extends AnimatedWidget {
  /// Creates an [AnimatedBorderButton] with the given animation and properties.
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

  /// The animation that controls the size of the border.
  final Animation<double> animation;

  /// The curve used for the border animation.
  final Curve curve;

  /// The vertical padding inside the button.
  final double verticalPadding;

  /// The horizontal padding inside the button.
  final double horizontalPadding;

  /// The border radius of the button.
  final double borderRadius;

  /// The wavelength of the wave animation.
  final double waveLength;

  /// The background color of the button.
  final Color backgroundColor;

  /// The child widget to display inside the button.
  final Widget child;

  // Animations to control the border size and padding
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
