# VNL Prefix Refactor Changelog

**Date:** [YYYY-MM-DD]

## Summary
All ambiguous widget/component names that could conflict with Material 3 have been renamed to use the `VNL` prefix. This ensures clarity, consistency, and avoids naming collisions. All usages in the codebase, documentation, and widget lists have been updated accordingly.

## Renamed Components

| Old Name            | New Name              |
|---------------------|----------------------|
| Avatar              | VNLAvatar            |
| AvatarBadge         | VNLAvatarBadge       |
| AvatarGroup         | VNLAvatarGroup       |
| ButtonGroup         | VNLButtonGroup       |
| Card                | VNLCard              |
| CardButton          | VNLCardButton        |
| CardImage           | VNLCardImage         |
| ChipButton          | VNLChipButton        |
| IconButton          | VNLIconButton        |
| Label               | VNLLabel             |
| MenuPopup           | VNLMenuPopup         |
| OutlineBadge        | VNLOutlineBadge      |
| OutlineButton       | VNLOutlineButton     |
| Pagination          | VNLPagination        |
| PrimaryBadge        | VNLPrimaryBadge      |
| PrimaryButton       | VNLPrimaryButton     |
| Progress            | VNLProgress          |
| Radio               | VNLRadio             |
| SecondaryBadge      | VNLSecondaryBadge    |
| SecondaryButton     | VNLSecondaryButton   |
| SelectedButton      | VNLSelectedButton    |
| Spinner             | VNLSpinner           |
| TabButton           | VNLTabButton         |
| TextButton          | VNLTextButton        |
| Tooltip             | VNLTooltip           |

> **Note:** Only ambiguous UI/control widgets that could conflict with Material or require clarity are listed here. All references, imports, and documentation have been updated to use the new names. Please use the VNL-prefixed versions for all future development to ensure consistency and avoid confusion with Material 3 widgets. 