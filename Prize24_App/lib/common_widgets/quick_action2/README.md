# Quick Action 2 Widget

A customizable grid-based quick actions widget that displays action items in a 2-column layout. Each action has an icon with a colored background, a label, and a tap callback.

## Features

- ✅ **Fixed 2-column grid layout** for consistent appearance
- ✅ **Customizable icons** with colored backgrounds
- ✅ **Fixed 56x56 icon container** with rounded corners
- ✅ **Customizable title** (defaults to "Quick Actions")
- ✅ **Light borders, no shadows** for clean Material Design look
- ✅ **Theme-aware colors** for text and backgrounds
- ✅ **Responsive cards** with InkWell ripple effects

## Usage

### Basic Example

```dart
import 'package:prize24_app/common_widgets/common_widgets.dart';

QuickAction2Widget(
  title: 'Quick Actions',
  actions: [
    QuickAction2Item(
      icon: Icons.store,
      label: 'Edit Shop',
      iconBackgroundColor: Colors.black,
      onTap: () {
        // Handle edit shop action
      },
    ),
    QuickAction2Item(
      icon: Icons.people,
      label: 'Manage Staff',
      iconBackgroundColor: Color(0xFF4A90E2),
      onTap: () {
        // Handle manage staff action
      },
    ),
    QuickAction2Item(
      icon: Icons.local_offer,
      label: 'Shop Offers',
      iconBackgroundColor: Colors.grey.shade600,
      onTap: () {
        // Handle shop offers action
      },
    ),
    QuickAction2Item(
      icon: Icons.qr_code,
      label: 'Shop QR Code',
      iconBackgroundColor: Color(0xFF00BCD4),
      onTap: () {
        // Handle QR code action
      },
    ),
  ],
)
```

### Custom Title

```dart
QuickAction2Widget(
  title: 'Shop Management', // Custom title
  actions: [
    // ... your actions
  ],
)
```

### Custom Icon Color

By default, icons are white. You can customize the icon color:

```dart
QuickAction2Item(
  icon: Icons.star,
  label: 'Featured',
  iconBackgroundColor: Colors.yellow,
  iconColor: Colors.black, // Custom icon color
  onTap: () {},
)
```

## QuickAction2Item Properties

| Property | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `icon` | IconData | Yes | - | Icon to display |
| `label` | String | Yes | - | Label/title text |
| `iconBackgroundColor` | Color | Yes | - | Background color of icon container |
| `onTap` | VoidCallback | Yes | - | Callback when action is tapped |
| `iconColor` | Color | No | Colors.white | Icon color |

## QuickAction2Widget Properties

| Property | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `actions` | List<QuickAction2Item> | Yes | - | List of action items to display |
| `title` | String | No | 'Quick Actions' | Title displayed above actions |

## Design Specifications

- **Grid**: Fixed 2-column layout
- **Icon Container**: 56x56 pixels, 16px border radius
- **Icon Size**: 28px
- **Card Border Radius**: 12px
- **Card Border**: 1px with outline color at 20% opacity
- **Spacing**: 16px between cards
- **Padding**: 16px horizontal, 12px vertical inside cards

## Example Screen

See [quick_action2_example.dart](quick_action2_example.dart) for a complete example with multiple use cases.

## Integration

The widget is automatically exported in the common_widgets package:

```dart
import 'package:prize24_app/common_widgets/common_widgets.dart';

// Now you can use:
// - QuickAction2Widget
// - QuickAction2Item
```

## Design Reference

Based on the Figma design: "Price-24-Updated UI"
- Node: 381-5541 (Quick Actions Section)
