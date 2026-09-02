# Button Components

A comprehensive set of reusable button widgets based on the Figma design system for the Prize24 app.

## Overview

This folder contains three main button types, each following Material Design principles and the app's design specifications:

1. **AppPrimaryButton** - Filled button with solid background (primary actions)
2. **AppSecondaryButton** - Outlined button with border (secondary actions)
3. **AppTextButton** - Text-only button with no border (tertiary actions)

## Features

- ✅ **Three size variants**: Small, Medium, Large (matching Figma specs)
- ✅ **Flexible icon support**: Left or right positioning
- ✅ **Loading states**: Built-in loading indicator
- ✅ **Theme integration**: Automatically uses Material theme colors
- ✅ **Customizable**: Override colors, sizes, and styles as needed
- ✅ **Responsive**: Adapts to different screen sizes
- ✅ **Accessibility**: Proper disabled states and color contrast

## Button Sizes

Based on Figma design specifications:

| Size | Height | Min Width | Font Size | Icon Size |
|------|--------|-----------|-----------|-----------|
| Small | 38px | 87px | 12px | 16px |
| Medium | 48px | 240px | 14px | 18px |
| Large | 58px | 327px | 16px | 20px |

## Usage Examples

### Basic Usage

```dart
import 'package:prize24_app/common_widgets/buttons/buttons.dart';

// Primary Button - Large (default)
AppPrimaryButton(
  text: 'Add payment method',
  onPressed: () {
    // Handle action
  },
)

// Secondary Button - Medium with left icon
AppSecondaryButton(
  text: 'Resend code',
  size: ButtonSize.medium,
  icon: Icons.refresh,
  iconPosition: ButtonIconPosition.left,
  onPressed: () {
    // Handle action
  },
)

// Text Button - Small with right icon
AppTextButton(
  text: 'Add',
  size: ButtonSize.small,
  icon: Icons.add,
  iconPosition: ButtonIconPosition.right,
  onPressed: () {
    // Handle action
  },
)
```

### Loading State

```dart
AppPrimaryButton(
  text: 'Submit',
  isLoading: true, // Shows loading spinner
  onPressed: () {
    // This won't be called while loading
  },
)
```

### Custom Width

```dart
AppPrimaryButton(
  text: 'Continue',
  width: double.infinity, // Full width button
  onPressed: () {},
)

AppSecondaryButton(
  text: 'Cancel',
  width: 200, // Fixed width
  onPressed: () {},
)
```

### Custom Colors

```dart
// Custom background color
AppPrimaryButton(
  text: 'Delete',
  backgroundColor: Colors.red,
  textColor: Colors.white,
  onPressed: () {},
)

// Custom border and text color
AppSecondaryButton(
  text: 'Info',
  borderColor: Colors.blue,
  textColor: Colors.blue,
  onPressed: () {},
)
```

### Disabled State

```dart
AppPrimaryButton(
  text: 'Submit',
  onPressed: null, // Passing null disables the button
)
```

### Icon Positioning

```dart
// Icon on the left
AppPrimaryButton(
  text: 'Back',
  icon: Icons.arrow_back,
  iconPosition: ButtonIconPosition.left,
  onPressed: () {},
)

// Icon on the right (default)
AppPrimaryButton(
  text: 'Next',
  icon: Icons.arrow_forward,
  iconPosition: ButtonIconPosition.right, // Can be omitted (default)
  onPressed: () {},
)
```

## Button Types

### 1. AppPrimaryButton

Filled button with solid background color. Use for the most important actions.

**Properties:**
- `text` (required): Button text
- `onPressed` (required): Callback function
- `size`: ButtonSize enum (small, medium, large)
- `icon`: Optional icon
- `iconPosition`: Left or right (default: right)
- `isLoading`: Show loading indicator
- `width`: Custom width
- `backgroundColor`: Custom background color
- `textColor`: Custom text color
- `borderRadius`: Border radius (default: 8)
- `elevation`: Shadow elevation (default: 0)

### 2. AppSecondaryButton

Outlined button with transparent background and colored border. Use for secondary actions.

**Properties:**
- `text` (required): Button text
- `onPressed` (required): Callback function
- `size`: ButtonSize enum (small, medium, large)
- `icon`: Optional icon
- `iconPosition`: Left or right (default: right)
- `isLoading`: Show loading indicator
- `width`: Custom width
- `borderColor`: Custom border color
- `textColor`: Custom text color
- `backgroundColor`: Custom background color
- `borderRadius`: Border radius (default: 8)
- `borderWidth`: Border width (default: 2)

### 3. AppTextButton

Text-only button with no background or border. Use for least prominent actions.

**Properties:**
- `text` (required): Button text
- `onPressed` (required): Callback function
- `size`: ButtonSize enum (small, medium, large)
- `icon`: Optional icon
- `iconPosition`: Left or right (default: right)
- `isLoading`: Show loading indicator
- `width`: Custom width
- `textColor`: Custom text color
- `backgroundColor`: Custom background color
- `borderRadius`: Border radius (default: 8)

## Import

To use these buttons in your code:

```dart
// Import all button widgets
import 'package:prize24_app/common_widgets/buttons/buttons.dart';

// Or import individually
import 'package:prize24_app/common_widgets/buttons/app_primary_button.dart';
import 'package:prize24_app/common_widgets/buttons/app_secondary_button.dart';
import 'package:prize24_app/common_widgets/buttons/app_text_button.dart';
import 'package:prize24_app/common_widgets/buttons/button_enums.dart';
```

## Design Reference

These buttons are based on the Figma design file: "Price-24-Updated UI"
- File: VnCKGL75HMHaisLyWBd5PZ
- Node: 1-10238 (Button Component Frame)

## Theme Integration

All buttons automatically use the Material theme's color scheme:
- Primary color: `theme.colorScheme.primary`
- On primary color: `theme.colorScheme.onPrimary`

You can override these by passing custom colors to the button properties.
