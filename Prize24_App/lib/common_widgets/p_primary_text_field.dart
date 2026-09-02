import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A reusable primary text field widget that matches the Figma design
/// with a static label positioned above the field and optional icon support.
///
/// This is a proper FormField that integrates with Flutter's Form widget
/// and supports validation.
///
/// Supports two types:
/// - Type=No Icon: Simple text fields without icons
/// - Type=With Icon: Text fields with left-side icons
///
/// States handled:
/// - Default (empty with placeholder)
/// - Focused/Typing
/// - Filled
/// - Error (with error message)
/// - Disabled
class PPrimaryTextField extends FormField<String> {
  PPrimaryTextField({
    required this.controller,
    required this.labelText,
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    super.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    super.validator,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
    super.initialValue,
    super.autovalidateMode,
  }) : super(
          builder: (FormFieldState<String> field) {
            final state = field as _PPrimaryTextFieldState;

            void onChangedHandler(String value) {
              field.didChange(value);
              onChanged?.call(value);
            }

            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Static label above the field (matching Figma design)
                  Text(
                    labelText,
                    style: TextStyle(
                      color: enabled
                          ? const Color(0xFF111111) // Base/100
                          : const Color(0xFF111111).withOpacity(0.38),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Text field without floating label
                  TextField(
                    controller: controller,
                    focusNode: state._focusNode,
                    enabled: enabled,
                    readOnly: readOnly,
                    obscureText: obscureText,
                    maxLines: maxLines,
                    minLines: minLines,
                    maxLength: maxLength,
                    keyboardType: keyboardType,
                    textInputAction: textInputAction,
                    inputFormatters: inputFormatters,
                    onChanged: onChangedHandler,
                    onTap: onTap,
                    onSubmitted: onFieldSubmitted,
                    autofocus: autofocus,
                    style: TextStyle(
                      color: enabled
                          ? const Color(0xFF111111) // Base/100 from Figma
                          : const Color(0xFF111111).withOpacity(0.38),
                      fontSize: 16,
                      letterSpacing: 0.2,
                    ),
                    decoration: state._buildDecoration(field.errorText),
                  ),
                  // Error text display
                  if (field.hasError && field.errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Text(
                        field.errorText!,
                        style: const TextStyle(
                          color: Color(0xFFD32F2F), // Error color
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );

  /// Text editing controller
  final TextEditingController controller;

  /// Label text (displayed above the field)
  final String labelText;

  /// Optional hint text (if different from label)
  final String? hintText;

  /// Optional prefix icon (for Type=With Icon)
  final Widget? prefixIcon;

  /// Optional suffix icon (for password toggle, clear button, etc.)
  final Widget? suffixIcon;

  /// Whether the text should be obscured (for passwords)
  final bool obscureText;

  /// Whether the field is read-only
  final bool readOnly;

  /// Maximum number of lines
  final int maxLines;

  /// Minimum number of lines
  final int? minLines;

  /// Maximum length of text
  final int? maxLength;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// On changed callback
  final void Function(String)? onChanged;

  /// On tap callback
  final VoidCallback? onTap;

  /// On field submitted callback
  final void Function(String)? onFieldSubmitted;

  /// Custom focus node
  final FocusNode? focusNode;

  /// Whether to autofocus
  final bool autofocus;

  @override
  FormFieldState<String> createState() => _PPrimaryTextFieldState();
}

class _PPrimaryTextFieldState extends FormFieldState<String> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  PPrimaryTextField get widget => super.widget as PPrimaryTextField;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);

    // Sync controller with form field
    widget.controller.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    widget.controller.removeListener(_handleControllerChanged);

    // Only dispose if we created it
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleControllerChanged() {
    // Sync controller text with form field value
    if (widget.controller.text != value) {
      didChange(widget.controller.text);
    }
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  InputDecoration _buildDecoration(String? errorText) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasError = errorText != null && errorText.isNotEmpty;

    // Determine border color based on state
    Color getBorderColor() {
      if (!widget.enabled) {
        return colorScheme.outline.withOpacity(0.38);
      }
      if (hasError) {
        return colorScheme.error;
      }
      if (_isFocused) {
        return colorScheme.primary;
      }
      return const Color(0xFFCFCFCF); // Default border from Figma
    }

    // Determine fill color based on state
    Color? getFillColor() {
      if (!widget.enabled) {
        return colorScheme.surfaceContainerHighest.withOpacity(0.12);
      }
      return Colors.transparent;
    }

    return InputDecoration(
      hintText: widget.hintText ?? widget.labelText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      filled: true,
      fillColor: getFillColor(),

      // Hint style
      hintStyle: TextStyle(
        color: const Color(0xFFA0A0A0), // Base/60 from Figma
        fontSize: 16,
        letterSpacing: 0.2,
      ),

      // Error style - handled separately in Column
      errorText: null, // We display error text separately

      // Borders
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: getBorderColor(),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: Color(0xFFCFCFCF), // Default border from Figma
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: colorScheme.outline.withOpacity(0.38),
          width: 1,
        ),
      ),
    );
  }
}
