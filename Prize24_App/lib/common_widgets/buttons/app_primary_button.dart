import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'button_enums.dart';

/// Gradient colors for the primary button
class _ButtonColors {
  static const Color gradientStart = Color(0xFFEF4444); // red-500
  static const Color gradientEnd = Color(0xFFF97316); // orange-500
}

/// A primary gradient button widget that matches the HTML design.
///
/// This button has a red-to-orange gradient background and is used
/// for primary actions in the app.
///
/// Example usage:
/// ```dart
/// AppPrimaryButton(
///   text: 'Add payment method',
///   onPressed: () {},
///   size: ButtonSize.large,
///   icon: Icons.add,
///   iconPosition: ButtonIconPosition.right,
/// )
/// ```
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.size = ButtonSize.large,
    this.icon,
    this.iconPosition = ButtonIconPosition.right,
    this.isLoading = false,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 16.0,
    this.elevation = 0,
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

  /// Custom background color (not used for gradient, kept for API compatibility)
  final Color? backgroundColor;

  /// Custom text color (overrides white)
  final Color? textColor;

  /// Border radius of the button
  final double borderRadius;

  /// Elevation of the button (not used for gradient, kept for API compatibility)
  final double elevation;

  bool get _isActive => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    // Create lighter gradient colors when disabled
    final gradientStartColor = _isActive
        ? _ButtonColors.gradientStart
        : Color.lerp(_ButtonColors.gradientStart, Colors.white, 0.5)!;
    final gradientEndColor = _isActive
        ? _ButtonColors.gradientEnd
        : Color.lerp(_ButtonColors.gradientEnd, Colors.white, 0.5)!;

    final effectiveTextColor = textColor ?? Colors.white;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width ?? double.infinity,
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gradientStartColor,
            gradientEndColor,
          ],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: _isActive
            ? [
                BoxShadow(
                  color: _ButtonColors.gradientStart.withOpacity(0.5),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                  spreadRadius: -5,
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isActive ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: isLoading
                ? Center(
                    child: SizedBox(
                      height: size.iconSize,
                      width: size.iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(effectiveTextColor),
                      ),
                    ),
                  )
                : _buildButtonContent(effectiveTextColor),
          ),
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
          style: GoogleFonts.inter(
            fontSize: size.fontSize,
            fontWeight: FontWeight.w600,
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
