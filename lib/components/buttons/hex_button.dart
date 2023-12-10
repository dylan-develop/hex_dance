import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/core/game_value.dart';
import 'package:hexagon/hexagon.dart';

class HexButton extends StatefulWidget {
  const HexButton({
    super.key,
    this.onTap,
    this.emoji,
    this.color,
    this.child,
    this.width,
    this.height,
    this.fontSize = 24.0,
  });

  final void Function()? onTap;
  final String? emoji;
  final Color? color;
  final Widget? child;
  final double? width;
  final double? height;
  final double fontSize;

  @override
  State<HexButton> createState() => _HexButtonState();
}

class _HexButtonState extends State<HexButton> {
  Color _originalColor = Colors.white;
  Color _color = Colors.white;

  @override
  void initState() {
    if (widget.color != null) {
      _originalColor = widget.color!;
      _color = _originalColor.darken(0.1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onHover: (value) {
        if (value) {
          setState(() {
            _color = _color.darken(0.1);
          });
        } else {
          setState(() {
            _color = _originalColor;
          });
        }
      },
      child: HexagonWidget.flat(
        width: widget.width ?? GameValue.hexRadius * 2,
        height: widget.height ?? GameValue.hexInradius * 2,
        elevation: 8.0,
        cornerRadius: 8.0,
        color: _color,
        child: Center(
          child: widget.child ??
              Text(
                widget.emoji ?? '',
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
        ),
      ),
    );
  }
}
