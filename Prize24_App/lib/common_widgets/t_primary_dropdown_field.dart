import 'package:flutter/material.dart';

/// A reusable primary dropdown form field widget with Material Design styling
/// that respects the app's Material theme colors.
class TPrimaryDropdownField<T> extends StatelessWidget {
  const TPrimaryDropdownField({
    super.key,
    required this.value,
    required this.label,
    required this.hint,
    required this.icon,
    required this.items,
    required this.itemBuilder,
    required this.onChanged,
    this.validator,
    this.enabled = true,
  });

  final T? value;
  final String label;
  final String hint;
  final IconData icon;
  final List<T> items;
  final DropdownMenuItem<T> Function(T) itemBuilder;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          onChanged: enabled ? onChanged : null,
          validator: validator,
          style: theme.textTheme.bodyMedium,
          dropdownColor: colorScheme.surface,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
            prefixIcon: Icon(
              icon,
              color: enabled
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(alpha: 0.38),
            ),
            filled: true,
            // fillColor: enabled
            //     ? colorScheme.surface
            //     : colorScheme.onSurface.withValues(alpha: 0.12),

            fillColor: Colors.grey.shade300,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          items: items.map(itemBuilder).toList(),
        ),
      ],
    );
  }
}
