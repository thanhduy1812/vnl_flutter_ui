# VNLook Page Creation Guidelines

This document outlines the recommended practices and structure for creating new pages in the VNLook application following the MVVM pattern.

## Page Location and Structure

All pages MUST be created in the `lib/pages` directory following this structure:

```
lib/
└── pages/
    ├── base/                 # Base classes and shared components
    │   ├── view_model/
    │   ├── view_controller/
    │   └── view/
    ├── home/                 # Example feature module
    │   ├── view_model/
    │   ├── view_controller/
    │   ├── view/
    │   └── model/
    └── new_feature/          # New feature module
        ├── view_model/
        ├── view_controller/
        ├── view/
        └── model/
```

### Rules for Creating New Pages:

1. **Location**: All pages MUST be created under `lib/pages/`
2. **Module Organization**:
   - Each feature should have its own directory under `pages/`
   - Feature names should be in snake_case
   - Common/shared components go in `pages/base/`
3. **Module Independence**:
   - Each feature module should be independent
   - Shared functionality should be moved to `base/`
4. **File Organization**:
   - All files related to a feature must be in its directory
   - No feature-specific code in `base/`

## Page Structure

When creating a new page in a feature module, follow this structure:

```
page_name/
├── view_model/
│   ├── page_name_view_model.dart
│   ├── page_name_header_view_model.dart
│   └── page_name_content_view_model.dart
├── view_controller/
│   └── page_name_view_controller.dart
├── view/
│   ├── page_name_header_view.dart
│   ├── page_name_content_view.dart
│   └── page_name_view.dart
└── model/
    └── page_specific_model.dart
```

## Base Classes

### 1. ViewController (PageViewController)

All page view controllers should extend `PageViewController` with a specific ViewModel type:

```dart
class NewPageViewController extends PageViewController<NewPageViewModel> {
  static String get route => "newPageRoute";

  const NewPageViewController({super.key, required super.viewModel});

  @override
  Widget buildBody(BuildContext pageContext) {
    return NewPageView(viewModel: NewPageViewModel());
  }

  @protected
  @override
  List<Widget> buildHeaders(BuildContext pageContext) {
    return [
      NewPageHeaderView(viewModel: NewPageHeaderViewModel()),
    ];
  }

  @protected
  @override
  List<Widget> buildFooters(BuildContext pageContext) {
    return [
      // Add footer widgets here
    ];
  }
}
```

### 2. ViewModels

Each view should have its own ViewModel that extends `BaseViewModel`:

```dart
// Main page ViewModel
class NewPageViewModel extends PageViewModel {
  NewPageViewModel() {
    title = 'Home';
  }

  // Add page-specific properties and methods
  void someBusinessLogic() {
    // Implement business logic
    reloadView();
  }
}

// Header ViewModel
class NewPageHeaderViewModel extends BaseViewModel {
  final ValueNotifier<String> headerTitle = ValueNotifier("");
  final ValueNotifier<bool> isExpanded = ValueNotifier(false);

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
    reloadView();
  }
}

// Content ViewModel
class NewPageContentViewModel extends BaseViewModel {
  final ValueNotifier<List<String>> items = ValueNotifier([]);

  Future<void> loadItems() async {
    // Load content data
    reloadView();
  }
}
```

### 3. Views

Each view should have its own ViewModel type:

```dart
class NewPageHeaderView extends BaseView<NewPageHeaderViewModel> {
  const NewPageHeaderView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.isExpanded,
      builder: (context, isExpanded, child) {
        return Container(
          // Header UI implementation using its own ViewModel
        );
      }
    );
  }
}

class NewPageContentView extends BaseView<NewPageContentViewModel> {
  const NewPageContentView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: viewModel.items,
      builder: (context, items, child) {
        return Container(
          // Content UI implementation using its own ViewModel
        );
      }
    );
  }
}
```

### 4. Main View

The main view coordinates child views with their respective ViewModels:

```dart
class NewPageView extends BaseView<NewPageViewModel> {
  const NewPageView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: [
        NewPageContentView(
          viewModel: NewPageContentViewModel(),
        ),
      ],
    );
  }
}
```

## Best Practices

1. **ViewModel Responsibilities**

   - Each ViewModel handles its own view's business logic
   - Manage view-specific state
   - Process data relevant to the view
   - Communicate with services/repositories if needed
   - Notify its view of changes using `reloadView()`

2. **ViewController Responsibilities**

   - Handle navigation
   - Manage page lifecycle
   - Configure page layout (headers, footers)
   - Create and provide ViewModels to views
   - Coordinate between different views when needed

3. **View Responsibilities**

   - Present UI elements
   - Handle user input
   - Forward actions to its own ViewModel
   - Respond to its ViewModel changes
   - No direct communication with other views

4. **View Naming Guidelines**
   - Use descriptive names with "View" suffix
   - Corresponding ViewModel should have "ViewModel" suffix
   - Name should reflect the view's purpose (e.g., `ProfileHeaderView`, `ProfileHeaderViewModel`)
   - Keep views focused on a single responsibility

## State Management

1. **Using ViewModel State**

   ```dart
   // In ViewModel
   final ValueNotifier<String> messageNotifier = ValueNotifier("");

   void updateMessage(String newMessage) {
     messageNotifier.value = newMessage;
     reloadView();
   }
   ```

2. **Accessing ViewModel in Views**
   ```dart
   // In View
   Widget buildWidget(BuildContext context) {
     return ValueListenableBuilder<String>(
       valueListenable: viewModel.messageNotifier,
       builder: (context, value, child) {
         return Text(value);
       },
     );
   }
   ```

## Communication Between ViewModels

When views need to communicate:

1. Use callbacks defined in ViewModels
2. Use event bus for decoupled communication
3. Parent ViewModel can coordinate child ViewModels
4. Avoid direct communication between sibling ViewModels

```dart
// Parent-Child communication example
class ParentViewModel extends BaseViewModel {
  final childViewModel = ChildViewModel();

  void handleChildEvent() {
    childViewModel.onParentAction();
  }
}
```

## Error Handling

1. **In ViewModel**

   ```dart
   Future<void> loadData() async {
     try {
       // Load data
     } catch (e) {
       // Handle error
       Logger.e("Error loading data", error: e);
     }
   }
   ```

2. **Loading States**

   ```dart
   // Show loading in specific view
   viewModel.loadingProgressIndeterminate = true;
   viewModel.reloadView();

   // Hide loading
   viewModel.loadingProgressIndeterminate = false;
   viewModel.reloadView();
   ```

## Testing

1. Create unit tests for each ViewModel
2. Create widget tests for each View
3. Mock dependencies appropriately
4. Test error scenarios
5. Test ViewModel communication

## Memory Management

1. Properly dispose of controllers and listeners in each ViewModel
2. Use weak references when appropriate
3. Clean up resources in `onDispose()`
4. Ensure child ViewModels are disposed when parent is disposed

Remember to follow these guidelines when creating new pages to maintain consistency and maintainability across the application.
