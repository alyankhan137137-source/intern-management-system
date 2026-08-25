# UI/UX Fixes and Crash Resolution

This plan addresses the "No Material widget found" crash in `ResourceCenterView` and improves the UI/UX by fixing hardcoded "too white" colors in search and filter components.

## User Review Required

> [!IMPORTANT]
> I will wrap `ResourceCenterView` in a `Scaffold` since it is pushed as a full-screen page from the navigation drawer. This will resolve the Material widget dependency crash.

## Proposed Changes

### UI/UX & Crash Fixes

#### [MODIFY] [resource_center_view.dart](file:///E:/MY ALL FLUTTER PROJECT FILE/intern_management_system/lib/views/intern/resource_center_view.dart)
- Wrap the main `Column` in a `Scaffold` with an `AppBar` to fix the "No Material widget found" error when pushed from the drawer.
- Replace hardcoded `Colors.white` in `FilterChip` with theme-adaptive colors.
- Use the same `_FilterChip` custom widget pattern as `TaskTrackerView` for visual consistency.

#### [MODIFY] [task_tracker_view.dart](file:///E:/MY ALL FLUTTER PROJECT FILE/intern_management_system/lib/views/intern/task_tracker_view.dart)
- Update the `TextField` `fillColor` from `Colors.grey[100]` to a theme-aware color (e.g., `Theme.of(context).colorScheme.surfaceContainerHighest`) to resolve the "too white" appearance.
- Ensure consistent padding and styling for the search bar.

### General UX Improvements
- Ensure all hardcoded background colors are replaced with adaptive theme references to support both Light and Dark modes professionally.

## Verification Plan

### Manual Verification
- **Crash Test**: Open the Navigation Drawer, select "Resource Center", and verify the app no longer crashes.
- **Visual Audit**: Toggle between Light and Dark modes and verify the Search bar and Filter chips have appropriate contrast and aren't "too white".
- **Navigation**: Verify that the new `Scaffold` in `ResourceCenterView` includes a back button to return to the main dashboard.
