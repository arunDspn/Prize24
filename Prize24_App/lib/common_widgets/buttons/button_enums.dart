/// Enum for button sizes based on Figma design specifications
enum ButtonSize {
  /// Small button: 38px height, 87px min width
  small(height: 38.0, minWidth: 87.0, fontSize: 12.0, iconSize: 16.0),

  /// Medium button: 48px height, 240px min width
  medium(height: 48.0, minWidth: 240.0, fontSize: 14.0, iconSize: 18.0),

  /// Large button: 58px height, 327px min width
  large(height: 58.0, minWidth: 327.0, fontSize: 16.0, iconSize: 20.0);

  const ButtonSize({
    required this.height,
    required this.minWidth,
    required this.fontSize,
    required this.iconSize,
  });

  final double height;
  final double minWidth;
  final double fontSize;
  final double iconSize;
}

/// Enum for icon position in buttons
enum ButtonIconPosition {
  /// Icon on the left side of text
  left,

  /// Icon on the right side of text
  right,
}
