# Club Progress Card Widget

A reusable Flutter widget that displays club membership progress with visual check-in tracking and gift day indicators.

## Features

- **7-Box Progress Window**: Always displays 7 boxes showing the progression window
- **Streak Tracking**: Shows checkmarks for completed check-ins based on `streakTotal`
- **Current Position Marker**: Arrow indicator above the current streak position
- **Gift Day Indicator**: Gift icon appears when the gift day falls within the visible range
- **Progress Dots**: Left dots indicate previous progress (when streak > 7), right dot shows continuation

## Usage

```dart
import 'package:prize24_app/features/clubs/presentation/widgets/club_progress_card.dart';

ClubProgressCard(
  clubData: ClubMemberUserDataModel(
    streakTotal: 5,
    consecutiveDays: 5,
    lastCheckInDate: DateTime.now(),
    lastBonusDate: null,
    lastGiftDate: null,
    giftDayCycle: 6,
    clubName: 'ABC Pvt Store',
    clubDescription: 'Your favorite store',
  ),
  onTap: () {
    // Navigate to club details
  },
)
```

## Visual Examples

### Example 1: Early Progress (Streak = 3, Gift at Day 6)
```
[✓] [✓] [↑] [ ] [ ] [🎁] [ ] •
 1   2   3   4   5   6    7
```

### Example 2: Mid Progress (Streak = 10, Gift Cycle = 6)
```
• • [✓] [✓] [✓] [✓] [✓] [✓] [↑] •
     9   10  11  12  13  14  15
(Next gift at day 12 - within visible range)
```

### Example 3: Gift Day Coincides with Current Streak
```
• • [✓] [✓] [✓] [✓] [✓] [✓] [🎁↑] •
     7   8   9   10  11  12   12
```

## Logic Details

### Window Calculation
The 7-box window is always positioned so the current streak appears in the **2nd box**:
- Window days: `[streakTotal - 1, streakTotal, streakTotal + 1, ..., streakTotal + 5]`

### Checkmark Display
- Boxes with day numbers `< streakTotal` show a checkmark (✓)
- Box at `streakTotal` position shows an arrow marker (↑) above it

### Gift Day Calculation
- **First cycle** (`lastGiftDate == null`): Gift appears at day `giftDayCycle`
- **Subsequent cycles**: Next gift = `(currentCycle + 1) × giftDayCycle`
- Gift icon only shows if the gift day falls within the 7-box window

### Dots Display
- **Left dots** (`• •`): Visible when `streakTotal > 7`
- **Right dot** (`•`): Always visible (indicates continuation)

## Parameters

### ClubProgressCard
- `clubData` (required): `ClubMemberUserDataModel` - The club membership data
- `onTap` (optional): `VoidCallback?` - Callback when card is tapped

### ClubMemberUserDataModel Fields Used
- `streakTotal`: Total cumulative streak count (determines window position and checkmarks)
- `giftDayCycle`: Number of days between gifts
- `lastGiftDate`: Date of last gift received (used to calculate next gift day)
- `clubName`: Name of the club
- `clubDescription`: Description of the club

## Styling

The widget uses the app's theme colors:
- Primary color for checkmarks, borders, and icons
- Card styling from theme's `CardTheme`
- Responsive to dark/light mode

## Notes

- The widget is designed for club membership tracking in a loyalty program
- Progress is cumulative and does not reset (streak doesn't break)
- `consecutiveDays` is not used in the current implementation
- Gift icon uses `Icons.card_giftcard` - can be customized if needed
