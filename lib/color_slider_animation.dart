import 'package:flutter/material.dart';

import 'custom_loader_animation.dart';
import 'mobikul_animated_button.dart';

class SlideColorAnimation extends AnimatedWidget {
  const SlideColorAnimation({
    super.key,
    required this.animation,
    required this.bgColor,
    required this.btnSize,
    required this.position,
    required this.borderColor,
    required this.gradientColor,
    required this.selectedGradientColor,
    required this.padding,
    required this.margin,
    required this.borderRadius,
    required this.borderWidth,
    required this.boxShadow,
    required this.gradientAnimation,
    required this.loaderColor,
    this.enableColorAnimation = true,
  }) : super(
          listenable: animation,
        );
  final Animation<double> animation;
  final Color bgColor;
  final Size btnSize;
  final Position position;
  final Color? borderColor;
  final List<Color>? gradientColor;
  final List<Color>? selectedGradientColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final Animation<Gradient?> gradientAnimation;
  final bool enableColorAnimation;
  final Color loaderColor;

  Animation<double> get curvedAnimation =>
      CurvedAnimation(parent: animation, curve: Curves.easeInOut);

  Animation<double> get heightAnimation => Tween<double>(
        begin: isTop ? 0 : btnSize.height,
        end: isTop ? btnSize.height : 0,
      ).animate(curvedAnimation);

  Animation<double> get widthAnimation => Tween<double>(
        begin: isLeft ? 0 : btnSize.width,
        end: isLeft ? btnSize.width : 0,
      ).animate(curvedAnimation);

  bool get isTop => position == Position.top;

  bool get isLeft => position == Position.left;

  bool get isVertical => isTop || position == Position.bottom;

  bool get isHorizontal =>
      position == Position.left || position == Position.right;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isHorizontal ? widthAnimation.value : btnSize.width,
      height: isVertical ? heightAnimation.value : btnSize.height,
      margin: margin ?? const EdgeInsets.all(8),
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        gradient: gradientAnimation.value,
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1.0,
        ),
        boxShadow: boxShadow,
      ),
    );
  }
}

class AnimatedColorText extends AnimatedWidget {
  const AnimatedColorText({
    super.key,
    required this.animation,
    required this.label,
    this.labelStyle,
    required this.firstColor,
    required this.secondColor,
    required this.enableColorAnimation,
    required this.icon,
    required this.isLoading,
    required this.loaderColor,
  }) : super(
          listenable: animation,
        );
  final String label;
  final TextStyle? labelStyle;
  final Animation<double> animation;
  final Color firstColor;
  final Color secondColor;
  final bool enableColorAnimation;
  final bool isLoading;
  final IconData? icon;
  final Color loaderColor;

  Animation<Color?> get colorAnimation => enableColorAnimation
      ? ColorTween(begin: firstColor, end: secondColor).animate(curvedAnimation)
      : AlwaysStoppedAnimation(firstColor);

  Animation<double> get curvedAnimation => CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? CustomLoaderAnimation(
              loaderColor: loaderColor,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Icon(
                        icon,
                        color: labelStyle != null
                            ? colorAnimation.value!
                            : colorAnimation.value!,
                      )
                    : Container(),
                icon != null
                    ? const SizedBox(
                        width: 8,
                      )
                    : Container(),
                Text(
                  label,
                  style: labelStyle != null
                      ? labelStyle?.copyWith(
                          color: colorAnimation.value!,
                        )
                      : Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colorAnimation.value!,
                          ),
                ),
              ],
            ),
    );
  }
}
