# PPrimaryTextField

A flexible, Figma-design-matched text field widget with **static label above the field** that supports both simple text fields and text fields with icons.

**This widget extends `FormField<String>`** and properly integrates with Flutter's Form widget for validation.

## Features

- ✅ **Proper FormField**: Extends `FormField<String>` for seamless Form integration
- ✅ **Two Types Support**:
  - Type=No Icon: Simple text fields without icons
  - Type=With Icon: Text fields with left-side icons
  
- ✅ **Complete State Management**:
  - Default (empty with placeholder)
  - Focused/Typing
  - Filled
  - Error (with error message display)
  - Disabled
  
- ✅ **Material Theme Compliant**: Automatically respects your app's Material theme colors
- ✅ **Static Label**: Label appears above the field (matches Figma exactly)
- ✅ **Form Validation**: Built-in validator support with proper FormField integration
- ✅ **Password Field Support**: Obscure text with toggle visibility
- ✅ **Customizable**: Flexible API for various use cases

## Design System

Based on Figma design: [Price 24 Updated UI](https://www.figma.com/design/VnCKGL75HMHaisLyWBd5PZ/Price-24-Updated-UI?node-id=1-10134)

**Colors from Figma:**
- Base/100: `#111111` (Text color)
- Base/60: `#A0A0A0` (Placeholder/hint color)
- Border: `#CFCFCF` (Default state)

**Dimensions:**
- Width: 327px (flexible in implementation)
- Height: 58px (auto-adjusts based on content)
- Border radius: 4px
- Padding: 16px horizontal, 16px vertical

## Usage

### Basic Text Field (Type=No Icon)

```dart
PPrimaryTextField(
  controller: nameController,
  labelText: 'Legal first name',
)
```

### Text Field with Icon (Type=With Icon)

```dart
PPrimaryTextField(
  controller: emailController,
  labelText: 'Email address',
  prefixIcon: const Icon(Icons.email_outlined),
  keyboardType: TextInputType.emailAddress,
)
```

### Text Field with Error

```dart
PPrimaryTextField(
  controller: emailController,
  labelText: 'Input your email',
  keyboardType: TextInputType.emailAddress,
  validator: (value) => 'Your email is not found!',
  autovalidateMode: AutovalidateMode.always, // Show error immediately
)
```

### Using with Form Widget

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      PPrimaryTextField(
        controller: emailController,
        labelText: 'Email',
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!value.contains('@')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Form is valid, process data
          }
        },
        child: Text('Submit'),
      ),
    ],
  ),
)
```

### Password Field with Visibility Toggle

```dart
bool _obscurePassword = true;

PPrimaryTextField(
  controller: passwordController,
  labelText: 'Password',
  obscureText: _obscurePassword,
  prefixIcon: const Icon(Icons.lock_outline),
  suffixIcon: IconButton(
    icon: Icon(
      _obscurePassword ? Icons.visibility_off : Icons.visibility,
    ),
    onPressed: () {
      setState(() {
        _obscurePassword = !_obscurePassword;
      });
    },
  ),
)
```

### Disabled Field

```dart
PPrimaryTextField(
  controller: disabledController,
  labelText: 'Disabled field',
  enabled: false,
)
```

### With Validation

```dart
PPrimaryTextField(
  controller: emailController,
  labelText: 'Email',
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  },
)
```

### Search Field

```dart
PPrimaryTextField(
  controller: searchController,
  labelText: 'Search for Address',
  prefixIcon: const Icon(Icons.search),
  suffixIcon: searchController.text.isNotEmpty
      ? IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => searchController.clear(),
        )
      : null,
)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `controller` | `TextEditingController` | ✅ Yes | Controller for the text field |
| `labelText` | `String` | ✅ Yes | Label/placeholder text |
| `hintText` | `String?` | No | Optional hint text (defaults to labelText) |
| `prefixIcon` | `Widget?` | No | Icon to display at the start of the field |
| `suffixIcon` | `Widget?` | No | Icon to display at the end of the field |
| `obscureText` | `bool` | No | Whether to obscure text (default: false) |
| `enabled` | `bool` | No | Whether the field is enabled (default: true) |
| `readOnly` | `bool` | No | Whether the field is read-only (default: false) |
| `maxLines` | `int` | No | Maximum number of lines (default: 1) |
| `minLines` | `int?` | No | Minimum number of lines |
| `maxLength` | `int?` | No | Maximum length of text |
| `keyboardType` | `TextInputType?` | No | Type of keyboard to display |
| `textInputAction` | `TextInputAction?` | No | Action button on keyboard |
| `inputFormatters` | `List<TextInputFormatter>?` | No | Input formatters |
| `validator` | `String? Function(String?)?` | No | Validation function |
| `onChanged` | `ValueChanged<String>?` | No | Callback when text changes |
| `onTap` | `VoidCallback?` | No | Callback when field is tapped |
| `onFieldSubmitted` | `ValueChanged<String>?` | No | Callback when field is submitted |
| `focusNode` | `FocusNode?` | No | Custom focus node |
| `autofocus` | `bool` | No | Whether to autofocus (default: false) |
| `errorText` | `String?` | No | Error message to display |

## Examples

See `p_primary_text_field_examples.dart` for a comprehensive demonstration of all states and types.

## Comparison with TPrimaryTextFormField

| Feature | PPrimaryTextField | TPrimaryTextFormField |
|---------|-------------------|----------------------|
| Label Position | Above field (static) | Above field |
| Design Source | Figma exact match | Custom |
| Icon Support | Optional prefix/suffix | Required prefix |
| States Visual | Matches Figma states | Custom styling |
| Border Radius | 4px (Figma) | 12px (rounded) |
| Use Case | New features (Figma design) | Existing features (legacy) |

## Notes

- This widget is designed to match the Figma design exactly
- Use this for new features following the updated design system
- The existing `TPrimaryTextFormField` remains available for backward compatibility
- All colors respect the Material theme and can be customized via `ThemeData`

## Related Widgets

- `TPrimaryTextFormField` - Legacy text field with label above field
- `TPrimaryDropdownField` - Dropdown field component
