import 'package:flutter/foundation.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

/// Dropdown menu anchored to a button.
///
/// Uses [showDropdown] to present a [VNLDropdownMenu] overlay with labels,
/// dividers, buttons, and a nested submenu.
class DropdownMenuExample1 extends StatelessWidget {
  const DropdownMenuExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLOutlineButton(
      onPressed: () {
        // Show the dropdown relative to the button.
        showDropdown(
          context: context,
          builder: (context) {
            return const VNLDropdownMenu(
              children: [
                VNLMenuLabel(child: Text('My Account')),
                VNLMenuDivider(),
                VNLMenuButton(
                  child: Text('Profile'),
                ),
                VNLMenuButton(
                  child: Text('Billing'),
                ),
                VNLMenuButton(
                  child: Text('Settings'),
                ),
                VNLMenuButton(
                  child: Text('Keyboard shortcuts'),
                ),
                VNLMenuDivider(),
                VNLMenuButton(
                  child: Text('Team'),
                ),
                VNLMenuButton(
                  // Demonstrates a nested submenu.
                  subMenu: [
                    VNLMenuButton(
                      child: Text('Email'),
                    ),
                    VNLMenuButton(
                      child: Text('Message'),
                    ),
                    VNLMenuDivider(),
                    VNLMenuButton(
                      child: Text('More...'),
                    ),
                  ],
                  child: Text('Invite users'),
                ),
                VNLMenuButton(
                  child: Text('New Team'),
                ),
                VNLMenuDivider(),
                VNLMenuButton(
                  child: Text('GitHub'),
                ),
                VNLMenuButton(
                  child: Text('Support'),
                ),
                VNLMenuButton(
                  enabled: false,
                  child: Text('API'),
                ),
                VNLMenuButton(
                  child: Text('Log out'),
                ),
              ],
            );
          },
        ).future.then((_) {
          // Called when the dropdown is closed.
          if (kDebugMode) {
            print('Closed');
          }
        });
      },
      child: const Text('Open'),
    );
  }
}
