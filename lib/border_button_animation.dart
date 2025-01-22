import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MobiKulBorderButton extends StatefulWidget {
  const MobiKulBorderButton({
    super.key,
    this.borderWidth = 1,
    this.borderColor = Colors.blueGrey,
    required this.text,
    this.backgroundColor = Colors.white,
    this.textStyle,
    required this.onPressed,
  });

  final String text;
  final TextStyle? textStyle;
  final double borderWidth;
  final Color borderColor;
  final VoidCallback onPressed;
  final Color backgroundColor;

  @override
  State<MobiKulBorderButton> createState() => _MobiKulBorderButtonState();
}

class _MobiKulBorderButtonState extends State<MobiKulBorderButton>
    with SingleTickerProviderStateMixin {
  late EdgeInsetsGeometry padding;
  late Size textSize;
  late Size containerSize;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    padding = const EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 24,
    );

    textSize = _calculateTextSize(widget.text, widget.textStyle);

    containerSize = Size(
      textSize.width + padding.horizontal,
      textSize.height + padding.vertical,
    );
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
        if (!kIsWeb) {
          _controller.reset();
          _controller.forward();
        }
        widget.onPressed();
      },
      child: Center(
        child: SizedBox(
          width: containerSize.width,
          height: containerSize.height,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor,

                ),
                child: Center(
                  child: Text(
                    widget.text,
                    style: widget.textStyle,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _AnimatedBorder(
                  animation: _controller,
                  containerSize: containerSize,
                  isHorizontal: true,
                  borderWidth: widget.borderWidth,
                  borderColor: widget.borderColor,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: _AnimatedBorder(
                  animation: _controller,
                  containerSize: containerSize,
                  isHorizontal: false,
                  borderWidth: widget.borderWidth,
                  borderColor: widget.borderColor,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: _AnimatedBorder(
                  animation: _controller,
                  containerSize: containerSize,
                  isHorizontal: true,
                  borderWidth: widget.borderWidth,
                  borderColor: widget.borderColor,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _AnimatedBorder(
                  animation: _controller,
                  containerSize: containerSize,
                  isHorizontal: false,
                  borderWidth: widget.borderWidth,
                  borderColor: widget.borderColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedBorder extends AnimatedWidget {
  const _AnimatedBorder({
    required this.animation,
    required this.containerSize,
    required this.isHorizontal,
    required this.borderWidth,
    required this.borderColor,
  }) : super(
          listenable: animation,
        );
  final Animation<double> animation;
  final Size containerSize;
  final bool isHorizontal;
  final double borderWidth;
  final Color borderColor;

  Animation<double> get animatedWidth =>
      Tween<double>(begin: 0, end: containerSize.width)
          .animate(curvedAnimation);

  Animation<double> get animatedHeight =>
      Tween<double>(begin: 0, end: containerSize.height)
          .animate(curvedAnimation);

  Animation<double> get curvedAnimation =>
      CurvedAnimation(parent: animation, curve: Curves.easeInOut);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isHorizontal ? animatedWidth.value : borderWidth,
      height: isHorizontal ? borderWidth : animatedHeight.value,
      color: borderColor,
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
