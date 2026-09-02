# Common Widgets

This directory contains reusable UI components that can be used throughout the Prize24 app. All components automatically respect the app's Material Design theme and adapt to both light and dark modes.

## Components

### TPrimaryTextFormField
A reusable text form field with Material theme styling.

**Features:**
- Automatically adapts to Material theme colors
- Supports both light and dark themes
- Customizable validation
- Support for different input types
- Optional suffix icons
- Disabled state support
- Read-only mode

**Usage:**
```dart
TPrimaryTextFormField(
  controller: _titleController,
  label: 'Campaign Title',
  hint: 'Enter campaign title',
  icon: Icons.title,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter campaign title';
    }
    return null;
  },
)
```

**Parameters:**
- `controller` (required): TextEditingController
- `label` (required): Field label text
- `hint` (required): Placeholder text
- `icon` (required): Prefix icon
- `maxLines`: Number of lines (default: 1)
- `keyboardType`: Input keyboard type
- `inputFormatters`: Input formatters
- `validator`: Validation function
- `enabled`: Enable/disable field (default: true)
- `obscureText`: Hide text for passwords (default: false)
- `suffixIcon`: Optional suffix icon widget
- `onTap`: Tap callback
- `readOnly`: Read-only mode (default: false)

### TPrimaryDropdownField
A reusable dropdown form field with Material theme styling.

**Features:**
- Automatically adapts to Material theme colors
- Supports both light and dark themes
- Generic type support
- Customizable validation
- Disabled state support

**Usage:**
```dart
TPrimaryDropdownField<CampaignVisibility>(
  value: _selectedVisibility,
  label: 'Campaign Visibility',
  hint: 'Select visibility',
  icon: Icons.visibility,
  items: CampaignVisibility.values,
  itemBuilder: (visibility) => DropdownMenuItem(
    value: visibility,
    child: Text(
      visibility.name.substring(0, 1).toUpperCase() +
          visibility.name.substring(1),
      style: const TextStyle(color: Colors.white),
    ),
  ),
  onChanged: (value) {
    setState(() {
      _selectedVisibility = value;
    });
  },
  validator: (value) {
    if (value == null) {
      return 'Please select campaign visibility';
    }
    return null;
  },
)
```

**Parameters:**
- `value` (required): Current selected value
- `label` (required): Field label text
- `hint` (required): Placeholder text
- `icon` (required): Prefix icon
- `items` (required): List of dropdown items
- `itemBuilder` (required): Function to build dropdown items
- `onChanged` (required): Change callback
- `validator`: Validation function
- `enabled`: Enable/disable field (default: true)

### TPrimaryButton
A reusable primary button with Material theme styling.

**Features:**
- Uses theme primary color by default
- Supports both light and dark themes
- Loading state support
- Optional icon
- Customizable dimensions
- Disabled state handling

**Usage:**
```dart
TPrimaryButton(
  onPressed: () {
    // Handle button press
  },
  text: 'Save Campaign',
  icon: Icons.save,
)
```

**Parameters:**
- `onPressed` (required): Button press callback
- `text` (required): Button text
- `icon`: Optional prefix icon
- `width`: Button width (default: full width)
- `height`: Button height (default: 50)
- `isLoading`: Show loading indicator (default: false)
- `backgroundColor`: Background color (default: theme primary color)
- `textColor`: Text color (default: theme onPrimary color)
- `borderRadius`: Border radius (default: 12)
- `elevation`: Button elevation (default: 4)
- `fontSize`: Text font size (default: 16)
- `fontWeight`: Text font weight (default: FontWeight.bold)

### TSecondaryButton
A reusable secondary button with Material theme styling.

**Features:**
- Uses theme surface color by default
- Supports both light and dark themes
- Lower elevation than primary button
- Loading state support
- Optional icon
- Customizable dimensions

**Usage:**
```dart
TSecondaryButton(
  onPressed: () {
    // Handle button press
  },
  text: 'Cancel',
  icon: Icons.close,
)
```

**Parameters:**
- `onPressed` (required): Button press callback
- `text` (required): Button text
- `icon`: Optional prefix icon
- `width`: Button width (default: full width)
- `height`: Button height (default: 50)
- `isLoading`: Show loading indicator (default: false)
- `backgroundColor`: Background color (default: theme surface color)
- `textColor`: Text color (default: theme onSurface color)
- `borderRadius`: Border radius (default: 12)
- `elevation`: Button elevation (default: 2)
- `fontSize`: Text font size (default: 16)
- `fontWeight`: Text font weight (default: FontWeight.w600)

### TOutlinedButton
A reusable outlined button with Material theme styling.

**Features:**
- Uses theme primary color for border and text
- Supports both light and dark themes
- Transparent background with colored border
- Loading state support
- Optional icon
- Customizable border colors and width

**Usage:**
```dart
TOutlinedButton(
  onPressed: () {
    // Handle button press
  },
  text: 'Learn More',
  icon: Icons.info_outline,
)
```

**Parameters:**
- `onPressed` (required): Button press callback
- `text` (required): Button text
- `icon`: Optional prefix icon
- `width`: Button width (default: full width)
- `height`: Button height (default: 50)
- `isLoading`: Show loading indicator (default: false)
- `borderColor`: Border color (default: theme primary color)
- `textColor`: Text color (default: theme primary color)
- `backgroundColor`: Background color (default: Colors.transparent)
- `borderRadius`: Border radius (default: 12)
- `borderWidth`: Border width (default: 2)
- `fontSize`: Text font size (default: 16)
- `fontWeight`: Text font weight (default: FontWeight.w600)

### ProfileAvatar
A reusable profile avatar widget with Material Design styling.

**Features:**
- Material Design circular avatar with borders
- Edit functionality with overlay button
- Anonymous mode support
- Automatic letter generation from username
- Network image support
- Theme-aware colors

**Usage:**
```dart
ProfileAvatar(
  userName: user.userName,
  imageUrl: user.avatarUrl,
  onEditPressed: () {
    // Handle edit profile
  },
)
```

**Parameters:**
- `userName` (required): User name for letter avatar
- `imageUrl`: Optional network image URL
- `isAnonymous`: Hide edit button (default: false)
- `onEditPressed`: Edit button callback
- `radius`: Avatar radius (default: 50)

### SettingsOptionCard
A reusable settings option widget with Material Design styling.

**Features:**
- Card-based design with Material elevation
- Icon with colored background
- Title and subtitle support
- Customizable trailing widget
- Touch feedback with ripple effect
- Theme-aware colors

**Usage:**
```dart
SettingsOptionCard(
  icon: Icons.notifications_outlined,
  title: 'Notifications',
  subtitle: 'Manage your notifications',
  onTap: () {
    // Navigate to notifications page
  },
)
```

**Parameters:**
- `icon` (required): Leading icon
- `title` (required): Main title text
- `subtitle` (required): Description text
- `onTap` (required): Tap callback
- `trailing`: Optional trailing widget
- `iconColor`: Icon color override
- `backgroundColor`: Card background color override

### ProfileInfoCard
A reusable profile information card widget with Material Design styling.

**Features:**
- Card-based container with Material elevation
- Title header with optional actions
- Flexible child widget support
- Consistent spacing and styling
- Theme-aware colors

**Usage:**
```dart
ProfileInfoCard(
  title: 'Profile Information',
  children: [
    ProfileInfoRow(
      icon: Icons.person_outline,
      label: 'Name',
      value: user.name,
    ),
    ProfileInfoRow(
      icon: Icons.email_outlined,
      label: 'Email',
      value: user.email,
    ),
  ],
)
```

**Parameters:**
- `title` (required): Card title
- `children` (required): List of child widgets
- `padding`: Content padding (default: 16px all)
- `actions`: Optional header action widgets

### ProfileInfoRow
A reusable profile information row widget for key-value pairs.

**Features:**
- Icon and text layout
- Two-line text layout (label + value)
- Optional tap functionality
- Theme-aware colors

**Usage:**
```dart
ProfileInfoRow(
  icon: Icons.phone_outlined,
  label: 'Phone',
  value: '+1 234 567 8900',
  onTap: () {
    // Handle phone number tap
  },
)
```

**Parameters:**
- `icon` (required): Leading icon
- `label` (required): Field label
- `value` (required): Field value
- `iconColor`: Icon color override
- `onTap`: Optional tap callback

### VendorQRCard
A reusable vendor QR code card widget with Material Design styling.

**Features:**
- QR code placeholder with vendor information
- Material card design with elevation
- Vendor name and ID display
- Theme-aware colors
- Customizable size

**Usage:**
```dart
VendorQRCard(
  vendorId: user.vendorId,
  vendorName: user.businessName,
  size: 200,
)
```

**Parameters:**
- `vendorId` (required): Vendor identification
- `vendorName` (required): Vendor display name
- `size`: QR code size (default: 200)

## Import

To use these components in your files, import the common_widgets package:

```dart
import 'package:prize24_app/common_widgets/common_widgets.dart';
```

## Button Usage Examples

### Multiple buttons in a row
```dart
Row(
  children: [
    Expanded(
      child: TOutlinedButton(
        onPressed: () => Navigator.pop(context),
        text: 'Cancel',
      ),
    ),
    const SizedBox(width: 16),
    Expanded(
      child: TPrimaryButton(
        onPressed: _handleSave,
        text: 'Save',
        icon: Icons.save,
      ),
    ),
  ],
)
```

### Button with loading state
```dart
TPrimaryButton(
  onPressed: _isLoading ? null : _handleSubmit,
  text: 'Submit',
  isLoading: _isLoading,
)
```

### Custom styled button
```dart
TSecondaryButton(
  onPressed: _handleDelete,
  text: 'Delete',
  icon: Icons.delete,
  backgroundColor: Colors.red.shade700,
  width: 200,
)
```

## Profile Widget Usage Examples

### Complete profile section
```dart
Column(
  children: [
    ProfileAvatar(
      userName: user.name,
      imageUrl: user.avatarUrl,
      onEditPressed: () => _editProfile(),
    ),
    const SizedBox(height: 20),
    ProfileInfoCard(
      title: 'Personal Information',
      children: [
        ProfileInfoRow(
          icon: Icons.person_outline,
          label: 'Full Name',
          value: user.fullName,
        ),
        ProfileInfoRow(
          icon: Icons.email_outlined,
          label: 'Email',
          value: user.email,
        ),
      ],
    ),
  ],
)
```

### Settings options
```dart
Column(
  children: [
    SettingsOptionCard(
      icon: Icons.notifications_outlined,
      title: 'Notifications',
      subtitle: 'Manage push notifications',
      onTap: () => _openNotifications(),
    ),
    SettingsOptionCard(
      icon: Icons.dark_mode_outlined,
      title: 'Dark Mode',
      subtitle: 'Toggle dark theme',
      onTap: () => _toggleDarkMode(),
    ),
  ],
)
```

### Vendor QR code display
```dart
VendorQRCard(
  vendorId: 'vendor_123',
  vendorName: 'John\'s Coffee Shop',
  size: 180,
)
```

## Theme Consistency

All components automatically respect the app's Material Design theme:
- **Light Theme**: Uses white/light backgrounds with dark text and orange accent colors
- **Dark Theme**: Uses dark backgrounds with light text and orange accent colors
- Consistent border radius (12px)
- Material Design elevation and shadows
- Proper contrast ratios for accessibility

### Key Material Theme Colors Used:
- `colorScheme.primary`: Main brand color (orange)
- `colorScheme.onPrimary`: Text/icons on primary color
- `colorScheme.surface`: Card/input field backgrounds
- `colorScheme.onSurface`: Text on surface backgrounds
- `colorScheme.error`: Error states
- `colorScheme.outline`: Borders and dividers

The widgets will automatically adapt when the user switches between light and dark themes.
