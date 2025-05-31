# VNL Prefix Refactor Changelog

**Date:** [YYYY-MM-DD]

## Summary

All ambiguous widget/component names that could conflict with Material 3 have been renamed to use the `VNL` prefix. This ensures clarity, consistency, and avoids naming collisions. All usages in the codebase, documentation, and widget lists have been updated accordingly.

## Renamed Components

| Old Name             | New Name             |
| -------------------- | -------------------- |
| VNLAvatar            | VNLAvatar            |
| VNLAvatarBadge       | VNLAvatarBadge       |
| VNLAvatarGroup       | VNLAvatarGroup       |
| VNLButtonGroup       | VNLButtonGroup       |
| VNLCard              | VNLCard              |
| VNLCardButton        | VNLCardButton        |
| VNLCardImage         | VNLCardImage         |
| VNLChipButton        | VNLChipButton        |
| VNLIconButton        | VNLIconButton        |
| VNLLabel             | VNLLabel             |
| VNLMenuPopup         | VNLMenuPopup         |
| VNLOutlineBadge      | VNLOutlineBadge      |
| VNLOutlineButton     | VNLOutlineButton     |
| VNLPagination        | VNLPagination        |
| VNLPrimaryBadge      | VNLPrimaryBadge      |
| VNLPrimaryButton     | VNLPrimaryButton     |
| VNLProgress          | VNLProgress          |
| VNLRadio             | VNLRadio             |
| VNLSecondaryBadge    | VNLSecondaryBadge    |
| VNLSecondaryButton   | VNLSecondaryButton   |
| VNLSelectedButton    | VNLSelectedButton    |
| VNLSpinner           | VNLSpinner           |
| VNLTabButton         | VNLTabButton         |
| VNLTextButton        | VNLTextButton        |
| VNLTooltip           | VNLTooltip           |
| VNLDestructiveButton | VNLDestructiveButton |
| VNLGhostButton       | VNLGhostButton       |
| VNLLinkButton        | VNLLinkButton        |
| VNLTable             | VNLTable             |
| VNLTableRow          | VNLTableRow          |
| VNLTableCell         | VNLTableCell         |
| VNLTableHeader       | VNLTableHeader       |
| VNLTableCellTheme    | VNLTableCellTheme    |
| VNLResizableTable    | VNLResizableTable    |

> **Note:** Only ambiguous UI/control widgets that could conflict with Material or require clarity are listed here. All references, imports, and documentation have been updated to use the new names. Please use the VNL-prefixed versions for all future development to ensure consistency and avoid confusion with Material 3 widgets.
