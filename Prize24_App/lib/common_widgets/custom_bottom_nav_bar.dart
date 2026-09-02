import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Model for navigation bar items
class BottomNavItem {
  const BottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.isCenterItem = false,
  });

  /// Icon to display when not selected
  final FaIcon icon;

  /// Icon to display when selected (optional)
  final IconData? activeIcon;

  /// Label text
  final String label;

  /// Whether this item is the special center button
  final bool isCenterItem;
}

/// A custom bottom navigation bar with support for a distinctive center button
///
/// Features:
/// - Fully customizable items list
/// - Optional center button with circular background
/// - Active items are highlighted
/// - Flexible styling options
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.centerButtonColor,
    this.backgroundColor,
    this.showLabels = true,
    this.height = 65,
    super.key,
  });

  /// List of navigation items
  final List<BottomNavItem> items;

  /// The index of the currently selected item
  final int currentIndex;

  /// Callback when a navigation item is tapped
  final ValueChanged<int> onTap;

  /// Color for selected items (defaults to primary color)
  final Color? selectedColor;

  /// Color for unselected items (defaults to grey)
  final Color? unselectedColor;

  /// Background color for the center button (defaults to blue)
  final Color? centerButtonColor;

  /// Background color for the entire nav bar
  final Color? backgroundColor;

  /// Whether to show labels under icons
  final bool showLabels;

  /// Height of the navigation bar
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedCol = selectedColor ?? theme.colorScheme.primary;
    final unselectedCol = unselectedColor ?? Colors.grey.shade600;
    final centerCol = centerButtonColor ?? const Color(0xFF1565C0); // Deep blue

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = currentIndex == index;

              if (item.isCenterItem) {
                return _CenterNavButton(
                  icon: item.icon.icon!,
                  isSelected: isSelected,
                  onTap: () => onTap(index),
                  backgroundColor: centerCol,
                );
              }

              return _NavItem(
                icon: item.icon.icon!,
                activeIcon: item.activeIcon,
                label: item.label,
                isSelected: isSelected,
                onTap: () => onTap(index),
                selectedColor: selectedCol,
                unselectedColor: unselectedCol,
                showLabel: showLabels,
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// Individual navigation item widget
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    this.activeIcon,
    this.showLabel = true,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final displayIcon = isSelected && activeIcon != null ? activeIcon! : icon;
    final color = isSelected ? selectedColor : unselectedColor;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(displayIcon, color: color, size: 26),
            if (showLabel) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Center navigation button with circular background
class _CenterNavButton extends StatelessWidget {
  const _CenterNavButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.backgroundColor,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: backgroundColor.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}

/// A glass-style floating bottom navigation bar with frosted blur effect
///
/// Features:
/// - Frosted glass effect with backdrop blur
/// - Floating design with rounded corners
/// - Premium shadows and translucent background
/// - Supports center button with accent color
class GlassFloatingNavBar extends StatelessWidget {
  const GlassFloatingNavBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.centerButtonColor,
    this.backgroundColor,
    this.showLabels = true,
    this.height = 70, // Slightly taller to accommodate padding
    super.key,
  });

  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? centerButtonColor;
  final Color? backgroundColor;
  final bool showLabels;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedCol = selectedColor ?? theme.colorScheme.primary;
    final unselectedCol = unselectedColor ?? Colors.grey.shade700;
    final centerCol = centerButtonColor ?? const Color(0xFF1565C0);
    final bgColor = backgroundColor ?? Colors.white;

    // Floating container with glass-like appearance (Impeller-safe, no BackdropFilter)
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      height: height,
      decoration: BoxDecoration(
        // Glass-like gradient background
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [bgColor.withOpacity(0.95), bgColor.withOpacity(0.85)],
        ),
        borderRadius: BorderRadius.circular(30),
        // Glass edge border
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
        // Shadow for the floating effect
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 2,
          ),
          // Inner glow effect
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = currentIndex == index;

            if (item.isCenterItem) {
              return _GlassCenterNavButton(
                icon: item.icon.icon!,
                isSelected: isSelected,
                onTap: () => onTap(index),
                backgroundColor: centerCol,
              );
            }

            return _GlassNavItem(
              icon: item.icon.icon!,
              activeIcon: item.activeIcon,
              label: item.label,
              isSelected: isSelected,
              onTap: () => onTap(index),
              selectedColor: selectedCol,
              unselectedColor: unselectedCol,
              showLabel: showLabels,
            );
          }),
        ),
      ),
    );
  }
}

/// Individual navigation item for glass nav bar
class _GlassNavItem extends StatelessWidget {
  const _GlassNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    this.activeIcon,
    this.showLabel = true,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final displayIcon = isSelected && activeIcon != null ? activeIcon! : icon;
    final color = isSelected ? selectedColor : unselectedColor;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? selectedColor.withOpacity(0.1)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(displayIcon, color: color, size: 24),
            ),
            if (showLabel) ...[
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Center navigation button for glass nav bar
class _GlassCenterNavButton extends StatelessWidget {
  const _GlassCenterNavButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.backgroundColor,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            // Deep shadow for the floating button to pop out of the glass
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}
