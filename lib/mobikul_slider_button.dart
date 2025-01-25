import 'package:flutter/material.dart';

class MobiKulSliderButton extends StatefulWidget {
  const MobiKulSliderButton({
    super.key,
    this.textStyle,
    required this.text,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.gradientColor,
    this.icon = Icons.arrow_forward,
    this.iconSize = 16,
    this.duration = const Duration(seconds: 1),
    this.borderRadius,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  });

  final String text;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final Color foregroundColor;
  final List<Color>? gradientColor;
  final IconData icon;
  final double iconSize;
  final double? borderRadius;
  final EdgeInsetsGeometry padding;
  final VoidCallback onPressed;
  final Duration duration;

  @override
  State<MobiKulSliderButton> createState() => _MobiKulSliderButtonState();
}

class _MobiKulSliderButtonState extends State<MobiKulSliderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Size textSize;
  late Size containerSize;

  @override
  void initState() {
    super.initState();

    textSize = _calculateTextSize(widget.text, widget.textStyle);

    containerSize = Size(
      textSize.width + widget.padding.horizontal,
      textSize.height + widget.padding.vertical,
    );

    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _controller.reset();
          _controller.forward();
          widget.onPressed();
        },
        child: Stack(
          children: [
            ShapeContainer(
              animation: _controller,
              containerSize: containerSize,
              textSize: textSize,
              padding: widget.padding,
              backgroundColor: widget.backgroundColor,
              foregroundColor: widget.foregroundColor,
              gradientColor: widget.gradientColor,
              icon: widget.icon,
              iconSize: widget.iconSize,
              borderRadius: widget.borderRadius ?? 20,
            ),
            Positioned.fill(
              left: 10,
              child: Center(
                child: MobiKulColorText(
                  text: widget.text,
                  textStyle: widget.textStyle,
                  firstColor: widget.backgroundColor,
                  secondColor: widget.foregroundColor,
                  animation: _controller,
                ),
              ),
            ),
          ],
        ));
  }
}

class ShapeContainer extends AnimatedWidget {
  const ShapeContainer({
    required this.animation,
    required this.containerSize,
    required this.textSize,
    required this.padding,
    required this.backgroundColor,
    required this.gradientColor,
    required this.foregroundColor,
    required this.icon,
    required this.iconSize,
    required this.borderRadius,
  }) : super(listenable: animation);

  final Animation<double> animation;
  final Size containerSize;
  final Size textSize;
  final Color backgroundColor;
  final Color foregroundColor;
  final List<Color>? gradientColor;

  final IconData icon;
  final double iconSize;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  Animation<double> get curvedAnimation => CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

  Animation<double> get widthAnimation =>
      Tween<double>(begin: 0, end: containerSize.width)
          .animate(curvedAnimation);

  Animation<double> get paddingAnimation =>
      Tween<double>(begin: containerSize.height, end: padding.horizontal * 0.5)
          .animate(curvedAnimation);

  Animation<double> get iconSlideAnimation => Tween<double>(
        begin: containerSize.height * 0.5 - iconSize * 0.5,
        end: padding.horizontal * 0.4,
      ).animate(curvedAnimation);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: paddingAnimation.value + widthAnimation.value,
          height: containerSize.height,
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: gradientColor?.isNotEmpty ?? false
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColor ?? [],
                  )
                : null,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: iconSlideAnimation.value,
                ),
                child: Icon(
                  icon,
                  size: iconSize,
                  color: foregroundColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: containerSize.width - widthAnimation.value,
          height: containerSize.height,
        ),
      ],
    );
  }
}

Size _calculateTextSize(String text, TextStyle? style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.size;
}

class MobiKulColorText extends AnimatedWidget {
  const MobiKulColorText({
    super.key,
    required this.animation,
    required this.text,
    this.textStyle,
    required this.firstColor,
    required this.secondColor,
  }) : super(
          listenable: animation,
        );
  final String text;
  final TextStyle? textStyle;
  final Animation<double> animation;
  final Color firstColor;
  final Color secondColor;

  Animation<Color?> get colorAnimation =>
      ColorTween(begin: firstColor, end: secondColor).animate(curvedAnimation);

  Animation<double> get curvedAnimation => CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: textStyle != null
            ? textStyle?.copyWith(
                color: colorAnimation.value!,
              )
            : Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorAnimation.value!,
                ),
      ),
    );
  }
}
