# VNL Prefix Refactor Changelog

**Date:** [YYYY-MM-DD]

## Summary
All ambiguous widget/component names that could conflict with Material 3 have been renamed to use the `VNL` prefix. This ensures clarity, consistency, and avoids naming collisions. All usages in the codebase, documentation, and widget lists have been updated accordingly.

## Renamed Components

| Old Name            | New Name              |
|---------------------|----------------------|
| ActiveDotItem       | VNLActiveDotItem     |
| Avatar              | VNLAvatar            |
| AvatarBadge         | VNLAvatarBadge       |
| AvatarGroup         | VNLAvatarGroup       |
| AvatarWidget        | VNLAvatarWidget      |
| ButtonGroup         | VNLButtonGroup       |
| ButtonStyleOverride | VNLButtonStyleOverride |
| CalendarGrid        | VNLCalendarGrid      |
| CalendarItem        | VNLCalendarItem      |
| CardButton          | VNLCardButton        |
| ChipButton          | VNLChipButton        |
| Clickable           | VNLClickable         |
| ContextMenuPopup    | VNLContextMenuPopup  |
| DotItem             | VNLDotItem           |
| Hover               | VNLHover             |
| HoverActivity       | VNLHoverActivity     |
| IconButton          | VNLIconButton        |
| InactiveDotItem     | VNLInactiveDotItem   |
| Label               | VNLLabel             |
| MenuPopup           | VNLMenuPopup         |
| MonthCalendar       | VNLMonthCalendar     |
| NumberTicker        | VNLNumberTicker      |
| Pagination          | VNLPagination        |
| PopoverOverlayWidget| VNLPopoverOverlayWidget |
| Progress            | VNLProgress          |
| SelectedButton      | VNLSelectedButton    |
| Spinner             | VNLSpinner           |
| StatedWidget        | VNLStatedWidget      |
| TabButton           | VNLTabButton         |
| TextButton          | VNLTextButton        |
| ToastEntryLayout    | VNLToastEntryLayout  |
| ToastLayer          | VNLToastLayer        |
| Tooltip             | VNLTooltip           |
| TooltipContainer    | VNLTooltipContainer  |
| YearCalendar        | VNLYearCalendar      |

> **Note:** All references, imports, and documentation have been updated to use the new names. Please use the VNL-prefixed versions for all future development to ensure consistency and avoid confusion with Material 3 widgets. 