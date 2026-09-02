# Theme Configuration

This document explains the Material theme implementation for the vendors campaign list components and the overall app theme structure.

## Overview

The app now supports both light and dark themes using Material Design 3 principles. The theme automatically switches based on the user's system settings.

## Theme Structure

### Files Modified/Created

1. **Theme Configuration** (`lib/configs/theme_config.dart`)
   - Centralized theme configuration
   - Light and dark theme definitions
   - Brand color definitions (Orange primary, Green secondary)
   - Consistent styling for all Material components

2. **App Configuration** (`lib/app/view/app.dart`)
   - Updated to use the new theme configuration
   - Set to `ThemeMode.system` to respect user's system preference

3. **Vendors Campaign List Components** (All updated to use theme colors)
   - `vendors_campaign_list_view.dart` - Main view
   - `campaign_card.dart` - Individual campaign cards  
   - `campaign_list_app_bar.dart` - App bar
   - `campaign_search_bar.dart` - Search functionality
   - `empty_state_widget.dart` - Empty state UI
   - `enhanced_fab.dart` - Floating action button

## Key Theme Properties Used

### Colors
- `theme.colorScheme.primary` - Orange brand color (buttons, accents)
- `theme.colorScheme.onPrimary` - Text color on primary surfaces
- `theme.colorScheme.surface` - Card and container backgrounds
- `theme.colorScheme.onSurface` - Text color on surfaces
- `theme.colorScheme.outline` - Border colors
- `theme.colorScheme.error` - Error states

### Responsive Elements
- All hardcoded colors replaced with theme-aware colors
- Text colors adapt to light/dark mode
- Background colors respect theme
- Border and accent colors follow Material Design guidelines

## Benefits

1. **Automatic Theme Switching**: Respects user's system preference
2. **Consistent Styling**: All components use the same theme values
3. **Future-Proof**: Easy to modify brand colors or add custom theme modes
4. **Accessibility**: Better contrast ratios in both light and dark modes
5. **Material Design Compliance**: Follows Material Design 3 specifications

## Usage

### For Developers

When creating new components, always use theme colors:

```dart
// ✅ Good - Uses theme colors
Container(
  color: theme.colorScheme.surface,
  child: Text(
    'Hello',
    style: TextStyle(color: theme.colorScheme.onSurface),
  ),
)

// ❌ Bad - Hardcoded colors
Container(
  color: Colors.grey.shade900,
  child: Text(
    'Hello',
    style: TextStyle(color: Colors.white),
  ),
)
```

### For Users

The app will automatically switch between light and dark themes based on your device's system settings. No manual configuration is required.

## Future Enhancements

1. **Manual Theme Selection**: Add user preference to override system settings
2. **Custom Theme Colors**: Allow users to choose from different color schemes
3. **Seasonal Themes**: Special themes for holidays or events
4. **High Contrast Mode**: Enhanced accessibility options

## Testing

To test the theme implementation:

1. Change your device's system theme setting
2. Observe that the app automatically switches themes
3. Verify that all text remains readable in both modes
4. Check that all interactive elements maintain proper contrast
