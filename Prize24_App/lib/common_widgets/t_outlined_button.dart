import 'package:flutter/material.dart';

/// A reusable outlined button widget with Material Design styling
/// that respects the app's Material theme colors.
class TOutlinedButton extends StatelessWidget {
  const TOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.width,
    this.height = 50,
    this.isLoading = false,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.borderRadius = 12,
    this.borderWidth = 2,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
  });

  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final double? width;
  final double height;
  final bool isLoading;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBorderColor = borderColor ?? theme.colorScheme.primary;
    final effectiveTextColor = textColor ?? theme.colorScheme.primary;
    final effectiveBackgroundColor = backgroundColor ?? Colors.transparent;

    // Calculate responsive padding based on button height
    final verticalPadding = height < 50 ? 8.0 : 16.0;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
            color: onPressed != null
                ? effectiveBorderColor
                : effectiveBorderColor.withValues(alpha: 0.6),
            width: borderWidth,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: onPressed != null
                          ? effectiveTextColor
                          : effectiveTextColor.withValues(alpha: 0.6),
                      size: fontSize + 2,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: onPressed != null
                            ? effectiveTextColor
                            : effectiveTextColor.withValues(alpha: 0.6),
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        fontFamily: 'Gilroy',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
