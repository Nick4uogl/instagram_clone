import 'package:flutter/material.dart';

class DividerColors extends ThemeExtension<DividerColors> {
  const DividerColors({required this.color});
  final Color? color;

  @override
  DividerColors copyWith({Color? color}) {
    return DividerColors(color: color ?? this.color);
  }

  @override
  DividerColors lerp(DividerColors? other, double t) {
    if (other is! DividerColors) {
      return this;
    }
    return DividerColors(
      color: Color.lerp(color, other.color, t),
    );
  }
}
