import 'package:flutter/services.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class MenubarExample1 extends StatefulWidget {
  const MenubarExample1({super.key});

  @override
  State<MenubarExample1> createState() => _MenubarExample1State();
}

class _MenubarExample1State extends State<MenubarExample1> {
  bool _showBookmarksBar = false;
  bool _showFullURLs = true;
  int _selectedProfile = 1;
  @override
  Widget build(BuildContext context) {
    // Typical desktop-style menubar with nested submenus, shortcuts,
    // checkboxes (non-closing), and a radio group.
    return VNLMenubar(
      children: [
        const VNLMenuButton(
          subMenu: [
            VNLMenuButton(
              leading: Icon(RadixIcons.filePlus),
              trailing: VNLMenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyT,
                  control: true,
                ),
              ),
              child: Text('New Tab'),
            ),
            VNLMenuButton(
              trailing: VNLMenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyN,
                  control: true,
                ),
              ),
              child: Text('New VNLWindow'),
            ),
            VNLMenuButton(
              enabled: false,
              child: Text('New Incognito VNLWindow'),
            ),
            VNLMenuDivider(),
            VNLMenuButton(
              subMenu: [
                VNLMenuButton(
                  child: Text('Email Link'),
                ),
                VNLMenuButton(
                  child: Text('Messages'),
                ),
                VNLMenuButton(
                  child: Text('Notes'),
                ),
              ],
              child: Text('Share'),
            ),
            VNLMenuButton(
              trailing: VNLMenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyP,
                  control: true,
                ),
              ),
              child: Text('Print'),
            ),
            VNLMenuButton(
              subMenu: [
                VNLMenuButton(
                  child: Text('Save and Exit'),
                ),
                VNLMenuButton(
                  child: Text('Discard and Exit'),
                ),
              ],
              child: Text('Exit'),
            ),
          ],
          child: Text('File'),
        ),
        const VNLMenuButton(
          subMenu: [
            VNLMenuButton(
              trailing: VNLMenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyZ,
                  control: true,
                ),
              ),
              child: Text('Undo'),
            ),
            VNLMenuButton(
              trailing: VNLMenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyZ,
                  control: true,
                  shift: true,
                ),
              ),
              child: Text('Redo'),
            ),
            VNLMenuDivider(),
            VNLMenuButton(
              subMenu: [
                VNLMenuButton(
                  child: Text('Search the Web'),
                ),
                VNLMenuDivider(),
                VNLMenuButton(
                  child: Text('Find...'),
                ),
                VNLMenuButton(
                  child: Text('Find Next'),
                ),
                VNLMenuButton(
                  child: Text('Find Previous'),
                ),
              ],
              child: Text('Find'),
            ),
            VNLMenuDivider(),
            VNLMenuButton(
              child: Text('Cut'),
            ),
            VNLMenuButton(
              child: Text('Copy'),
            ),
            VNLMenuButton(
              child: Text('Paste'),
            ),
          ],
          child: Text('Edit'),
        ),
        VNLMenuButton(
          subMenu: [
            VNLMenuCheckbox(
              value: _showBookmarksBar,
              onChanged: (context, value) {
                setState(() {
                  _showBookmarksBar = value;
                });
              },
              // Keep the submenu open while toggling for quicker multi-actions.
              autoClose: false,
              child: const Text('Always Show Bookmarks Bar'),
            ),
            VNLMenuCheckbox(
              value: _showFullURLs,
              onChanged: (context, value) {
                setState(() {
                  _showFullURLs = value;
                });
              },
              // Also keep open here to demonstrate autoClose control.
              autoClose: false,
              child: const Text('Always Show Full URLs'),
            ),
            const VNLMenuDivider(),
            const VNLMenuButton(
              trailing: VNLMenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyR,
                  control: true,
                ),
              ),
              child: Text('Reload'),
            ),
            const VNLMenuButton(
              enabled: false,
              trailing: VNLMenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyR,
                  control: true,
                  shift: true,
                ),
              ),
              child: Text('Force Reload'),
            ),
            const VNLMenuDivider(),
            const VNLMenuButton(
              child: Text('VNLToggle Full Screen'),
            ),
            const VNLMenuDivider(),
            const VNLMenuButton(
              child: Text('Hide Sidebar'),
            ),
          ],
          child: const Text('View'),
        ),
        VNLMenuButton(
          subMenu: [
            MenuRadioGroup<int>(
              value: _selectedProfile,
              onChanged: (context, value) {
                setState(() {
                  _selectedProfile = value;
                });
              },
              children: const [
                MenuRadio<int>(
                  value: 0,
                  // Disable auto-close to let users quickly toggle multiple options.
                  autoClose: false,
                  child: Text('Andy'),
                ),
                MenuRadio<int>(
                  value: 1,
                  autoClose: false,
                  child: Text('Benoit'),
                ),
                MenuRadio<int>(
                  value: 2,
                  autoClose: false,
                  child: Text('Luis'),
                ),
              ],
            ),
            const VNLMenuDivider(),
            const VNLMenuButton(
              child: Text('Edit...'),
            ),
            const VNLMenuDivider(),
            const VNLMenuButton(
              child: Text('Add Profile...'),
            ),
          ],
          child: const Text('Profiles'),
        ),
      ],
    );
  }
}
