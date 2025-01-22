library mobikul_animated_button;

export 'border_button_animation.dart';
export 'animated_wave_button.dart';
export 'mobikul_slider_button.dart';
import 'color_slider_animation.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class MobiKulAnimatedButton extends StatefulWidget {
  final String? text;
  final VoidCallback onPressed;
  final double height;
  final double? width;
  final double? borderWidth;
  final Color backgroundColor;
  final Color selectedColor;
  final Color textFirstColor;
  final Color textSecondColor;
  final Color? borderColor;
  final Color loaderColor;
  final TextStyle? textStyle;
  final List<Color>? gradientColor;
  final List<Color>? selectedGradientColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final double finalScale;
  final double initialScale;
  final double opacity;
  final double fadeStart;
  final double fadeEnd;
  final Position position;
  final List<BoxShadow>? boxShadow;
  final bool enableColorAnimation;
  final bool isReverse;
  final bool isLoading;
  final IconData? icon;

  const MobiKulAnimatedButton({
    super.key,
    required this.onPressed,
    this.text,
    this.width,
    this.backgroundColor = Colors.black,
    this.selectedColor = Colors.white,
    this.textStyle,
    this.margin,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.textSecondColor = Colors.black,
    this.textFirstColor = Colors.white,
    this.loaderColor = Colors.white,
    this.boxShadow,
    this.borderWidth,
    this.gradientColor,
    this.position = Position.left,
    this.selectedGradientColor,
    this.height = 45,
    this.finalScale = 1,
    this.initialScale = 1,
    this.fadeStart = 1,
    this.fadeEnd = 1,
    this.opacity = 1,
    this.enableColorAnimation = false,
    this.isReverse = false,
    this.isLoading = false,
    this.icon,
  });

  @override
  State<MobiKulAnimatedButton> createState() => _MobiKulAnimatedButtonState();
}

class _MobiKulAnimatedButtonState extends State<MobiKulAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Gradient?> _gradientAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation; // Opacity Animation

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Initialize animations
    _initializeDefaultAnimations();

    // Add a listener to toggle _isReverseEnabled based on animation status
    _controller.addStatusListener((status) {
      if (widget.isReverse && status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  void _initializeDefaultAnimations() {
    _gradientAnimation = GradientTween(
      begin: widget.gradientColor != null
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.gradientColor!,
            )
          : null,
      end: widget.selectedGradientColor != null
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.selectedGradientColor!,
            )
          : null,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(
      begin: widget.initialScale,
      end: widget.finalScale,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(
      begin: widget.fadeStart, // Start slightly faded
      end: widget.fadeEnd, // Fully visible
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    _initializeDefaultAnimations();

    return GestureDetector(
        onTap: () {
          if (widget.opacity == 1) {
            if (_controller.status == AnimationStatus.dismissed) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
            widget.onPressed();
          }
        },
        child: Opacity(
          opacity: widget.opacity,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Stack(
                        children: [
                          Container(
                            margin: widget.margin ?? const EdgeInsets.all(8),
                            padding: widget.padding,
                            alignment: Alignment.center,
                            height: widget.height,
                            width: widget.width ??
                                MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: widget.enableColorAnimation
                                  ? (widget.position == Position.left ||
                                          widget.position == Position.top)
                                      ? widget.backgroundColor
                                      : widget.selectedColor
                                  : widget.backgroundColor,
                              gradient: _gradientAnimation.value,
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? 0.0),
                              border: Border.all(
                                color: widget.borderColor ?? Colors.transparent,
                                width: widget.borderWidth ?? 1.0,
                              ),
                              boxShadow: widget.boxShadow,
                            ),
                          ),
                          SlideColorAnimation(
                            animation: _controller,
                            bgColor: widget.enableColorAnimation
                                ? (widget.position == Position.left ||
                                        widget.position == Position.top)
                                    ? widget.selectedColor
                                    : widget.backgroundColor
                                : widget.backgroundColor,
                            btnSize: Size(
                              widget.width ?? MediaQuery.of(context).size.width,
                              widget.height,
                            ),
                            position: widget.position,
                            borderColor: widget.borderColor,
                            gradientColor: widget.gradientColor,
                            selectedGradientColor: widget.selectedGradientColor,
                            padding: widget.padding,
                            margin: widget.margin,
                            borderRadius: widget.borderRadius,
                            borderWidth: widget.borderWidth,
                            boxShadow: widget.boxShadow,
                            gradientAnimation: _gradientAnimation,
                            enableColorAnimation: widget.enableColorAnimation, loaderColor: widget.loaderColor,
                          ),
                          Container(
                            width: widget.width,
                            height: widget.height,
                            margin: widget.margin ?? const EdgeInsets.all(8),
                            padding: widget.padding,
                            child: AnimatedColorText(
                              label: widget.text ?? "Save",
                              labelStyle: TextStyle(fontSize: 20),
                              animation: _controller,
                              firstColor: (widget.position == Position.left ||
                                      widget.position == Position.top)
                                  ? widget.textFirstColor
                                  : widget.textSecondColor,
                              secondColor: (widget.position == Position.left ||
                                      widget.position == Position.top)
                                  ? widget.textSecondColor
                                  : widget.textFirstColor,
                              enableColorAnimation: widget.enableColorAnimation,
                              icon: widget.icon,
                              isLoading: widget.isLoading, loaderColor: widget.loaderColor,
                            ),
                          ),
                        ],
                      ));
                }),
          ),
        ));
  }
}

class GradientTween extends Tween<Gradient?> {
  GradientTween({required Gradient? begin, required Gradient? end})
      : super(begin: begin, end: end);

  @override
  Gradient? lerp(double t) {
    if (begin is LinearGradient && end is LinearGradient) {
      final LinearGradient beginGradient = begin as LinearGradient;
      final LinearGradient endGradient = end as LinearGradient;

      return LinearGradient(
        begin: Alignment.lerp(
          beginGradient.begin as Alignment?,
          endGradient.begin as Alignment?,
          t,
        )!,
        end: Alignment.lerp(
          beginGradient.end as Alignment?,
          endGradient.end as Alignment?,
          t,
        )!,
        colors: List<Color>.generate(
          beginGradient.colors.length,
          (index) => Color.lerp(
            beginGradient.colors[index],
            endGradient.colors[index],
            t,
          )!,
        ),
        stops: _lerpStops(beginGradient.stops, endGradient.stops, t),
        tileMode: beginGradient.tileMode,
      );
    }
    return null;
  }

  List<double>? _lerpStops(
    List<double>? beginStops,
    List<double>? endStops,
    double t,
  ) {
    if (beginStops == null || endStops == null) return null;

    return List.generate(
      beginStops.length,
      (index) => lerpDouble(beginStops[index], endStops[index], t)!,
    );
  }
}

enum Position {
  left,
  right,
  top,
  bottom,
}
