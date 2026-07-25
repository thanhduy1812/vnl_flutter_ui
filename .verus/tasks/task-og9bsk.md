---
id: og9bsk
title: "Phase 4: Layout, Navigation, Overlay — migrate to Material"
status: todo
priority: high
createdAt: "2026-07-25T16:36:05+07:00"
updatedAt: "2026-07-25T16:36:05+07:00"
---

Replace custom layout/navigation/overlay components with Material equivalents. Keep VNL API unchanged.

Deliverables:
4A. VNLDivider/VNLVerticalDivider → material.Divider/VerticalDivider
4B. VNLCard/VNLSurfaceCard → material.Card
4C. VNLScaffold/VNLAppBar → material.Scaffold/AppBar
4D. VNLNavigationBar (bar/rail/sidebar) → material.NavigationBar/NavigationRail/NavigationDrawer
4E. VNLTabs → material.TabBar + TabBarView
4F. VNLAlertDialog → material.AlertDialog + showDialog
4G. VNLContextMenu/VNLDropdownMenu → material.showMenu/DropdownMenu
4H. VNLStepper → material.Stepper
4I. VNLAccordion/VNLCollapsible → material.ExpansionTile
4J. VNLTable/VNLPagination → material.TableView hoặc giữ nếu chưa stable
4K. Remove shadcn_flutter.dart hide directives for Material widgets

Depends on: Phase 3 (core controls done)
Constraint: ZERO visual change.

