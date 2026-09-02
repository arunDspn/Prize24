import 'package:flutter/material.dart';
import 'button_enums.dart';

/// A text button widget that follows Material Design and Figma specifications.
///
/// This button has no background or border, displaying only text (and optional icon)
/// with the theme's primary color. Used for tertiary/least prominent actions.
///
/// Example usage:
/// ```dart
/// AppTextButton(
///   text: 'Add',
///   onPressed: () {},
///   size: ButtonSize.small,
///   icon: Icons.add,
///   iconPosition: ButtonIconPosition.left,
/// )
/// ```
class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = ButtonSize.large,
    this.icon,
    this.iconPosition = ButtonIconPosition.right,
    this.isLoading = false,
    this.width,
    this.textColor,
    this.backgroundColor,
    this.borderRadius = 8.0,
  });

  /// The text displayed on the button
  final String text;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Size of the button (small, medium, or large)
  final ButtonSize size;

  /// Optional icon to display with text
  final IconData? icon;

  /// Position of the icon (left or right of text)
  final ButtonIconPosition iconPosition;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Custom width (overrides size's minWidth if provided)
  final double? width;

  /// Custom text color (overrides theme's primary color)
  final Color? textColor;

  /// Custom background color (default is transparent)
  final Color? backgroundColor;

  /// Border radius of the button
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveTextColor = textColor ?? theme.colorScheme.primary;
    final effectiveBackgroundColor = backgroundColor ?? Colors.transparent;

    return SizedBox(
      width: width ?? size.minWidth,
      height: size.height,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveTextColor,
          disabledForegroundColor: effectiveTextColor.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        child: isLoading
            ? SizedBox(
                height: size.iconSize,
                width: size.iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                ),
              )
            : _buildButtonContent(
                onPressed != null
                    ? effectiveTextColor
                    : effectiveTextColor.withOpacity(0.6),
              ),
      ),
    );
  }

  Widget _buildButtonContent(Color color) {
    final List<Widget> children = [];

    // Add icon on the left if specified
    if (icon != null && iconPosition == ButtonIconPosition.left) {
      children.add(
        Icon(
          icon,
          size: size.iconSize,
          color: color,
        ),
      );
      children.add(const SizedBox(width: 8));
    }

    // Add text
    children.add(
      Flexible(
        child: Text(
          text,
          style: TextStyle(
            fontSize: size.fontSize,
            fontWeight: FontWeight.w500,
            fontFamily: 'Gilroy',
            color: color,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );

    // Add icon on the right if specified
    if (icon != null && iconPosition == ButtonIconPosition.right) {
      children.add(const SizedBox(width: 8));
      children.add(
        Icon(
          icon,
          size: size.iconSize,
          color: color,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
