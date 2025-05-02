# Hướng dẫn sử dụng hệ thống điều hướng tài liệu VNL UI

## 1. Tổng quan hệ thống

VNL UI cung cấp một hệ thống hoàn chỉnh để xây dựng trang tài liệu với điều hướng thông minh, gồm:
- Layout 3 panel responsive (sidebar trái, nội dung, sidebar phải)
- Theo dõi vị trí đọc hiện tại và highlight tương ứng trong menu
- Điều hướng nhanh thông qua "On This Page" sidebar
- Routing thông minh giữa các trang tài liệu

## 2. Các thành phần chính

### 2.1. PageStorage

`PageStorage` lưu trữ trạng thái cuộn và các trạng thái khác giữa các lần build lại widget.

```dart
// Khai báo PageStorage bucket toàn cục
final PageStorageBucket docsBucket = PageStorageBucket();

// Sử dụng trong widget tree
PageStorage(
  bucket: docsBucket,
  child: yourWidget,
)
```

### 2.2. StageContainer

Quản lý padding và kích thước tổng thể của layout theo kích thước màn hình:

```dart
StageContainer(
  builder: (context, padding) {
    return VNLScaffold(
      // Sử dụng padding từ StageContainer để điều chỉnh layout
      // ...
    );
  },
)
```

### 2.3. OnThisPage

Class theo dõi visibility của một phần nội dung trong trang:

```dart
class OnThisPage extends LabeledGlobalKey {
  final ValueNotifier<bool> isVisible = ValueNotifier(false);
  OnThisPage([super.debugLabel]);
}

// Khai báo OnThisPage keys
final Map<String, OnThisPage> sectionsOnThisPage = {
  'Giới thiệu': OnThisPage('introduction-section'),
  'Tính năng': OnThisPage('features-section'),
  // Các phần khác...
};
```

### 2.4. PageItemWidget

Widget bọc nội dung để theo dõi visibility:

```dart
class PageItemWidget extends StatelessWidget {
  final OnThisPage onThisPage;
  final Widget child;

  const PageItemWidget({
    super.key,
    required this.onThisPage,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: onThisPage,
      child: child,
      onVisibilityChanged: (info) {
        onThisPage.isVisible.value = info.visibleFraction >= 1;
      },
    );
  }
}
```

### 2.5. anchored extension

Extension tiện ích để dễ dàng áp dụng PageItemWidget:

```dart
extension CustomWidgetExtension on Widget {
  Widget anchored(OnThisPage onThisPage) {
    return PageItemWidget(
      onThisPage: onThisPage,
      child: this,
    );
  }
}

// Sử dụng:
yourWidget.anchored(sectionsOnThisPage['Phần nào đó']!)
```

### 2.6. DocsPage và Hệ thống Routing

DocsPage là container chính cho mỗi trang, chứa layout 3 panel và xử lý routing:

```dart
DocsPage({
  required this.name,     // Tên route để GoRouter sử dụng
  required this.child,    // Nội dung chính ở giữa
  this.onThisPage = const {},  // Các section trong trang
  this.navigationItems = const [],  // Items phụ trong breadcrumb
  this.scrollable = true,  // Có cho phép scroll nội dung hay không
})
```

Khi click vào menu trong sidebar trái, hệ thống routing hoạt động như sau:
```dart
void _onPressed() {
  if (widget.page.tag == VNLookFeatureTag.workInProgress) {
    showDialog(/* ... */);
    return;
  }
  context.goNamed(widget.page.name); // GoRouter navigation
}
```

### 2.7. FocusTraversalGroup

FocusTraversalGroup đóng vai trò quan trọng trong quản lý focus và accessibility:

```dart
// Sidebar trái
MediaQueryVisibility(
  minWidth: breakpointWidth,
  child: FocusTraversalGroup(
    child: SingleChildScrollView(/* ... */),
  ),
)

// Nội dung chính
Expanded(
  child: FocusTraversalGroup(
    child: /* nội dung */
  ),
)
```

Mục đích:
- Phân chia các vùng focus riêng biệt cho 3 panel
- Giới hạn phạm vi khi sử dụng phím Tab để điều hướng
- Cải thiện trải nghiệm sử dụng bàn phím và công cụ trợ năng

### 2.8. _DocsSecondarySidebarState

Xây dựng sidebar bên phải và xử lý điều hướng:

```dart
class _DocsSecondarySidebarState extends State<_DocsSecondarySidebar> {
  @override
  Widget build(BuildContext context) {
    // Xây dựng sidebar với các mục điều hướng
    for (var key in widget.onThisPage.keys) {
      side.add(SidebarButton(
        onPressed: () {
          // Scroll đến phần tương ứng khi nhấp vào mục
          Scrollable.ensureVisible(
            widget.onThisPage[key]!.currentContext!,
            duration: kDefaultDuration, 
            alignmentPolicy: ScrollPositionAlignmentPolicy.explicit
          );
        },
        selected: widget.isVisible(widget.onThisPage[key]!),
        child: Text(key),
      ));
    }
    // ...
  }
}
```

### 2.9. Cách tạo Sidebar trái và phải

Cả sidebar trái và phải đều sử dụng các widget types chung từ thư viện VNL UI, nhưng có một số điểm khác biệt về cấu trúc và mục đích.

#### Sidebar trái (Menu chính)

1. **Cấu trúc lớp**:
   ```dart
   // Lớp chính quản lý sidebar
   class _DocsSidebar extends StatefulWidget {
     final List<VNLookDocsSection> sections;
     final String pageName;
     
     @override
     State<_DocsSidebar> createState() => _DocsSidebarState();
   }
   
   // State tạo danh sách widget từ sections
   class _DocsSidebarState extends State<_DocsSidebar> {
     late List<Widget> children;
     
     @override
     void initState() {
       super.initState();
       children = [
         for (var section in widget.sections)
           _DocsSidebarSection(section: section, pageName: widget.pageName),
       ];
     }
     
     @override
     Widget build(BuildContext context) {
       return SidebarNav(children: children);
     }
   }
   ```

2. **Tạo các sections**:
   ```dart
   class _DocsSidebarSection extends StatefulWidget {
     final VNLookDocsSection section;
     final String pageName;
     
     @override
     State<_DocsSidebarSection> createState() => _DocsSidebarSectionState();
   }
   
   class _DocsSidebarSectionState extends State<_DocsSidebarSection> {
     late List<Widget> pages;
     
     @override
     void initState() {
       super.initState();
       pages = [
         for (var page in widget.section.pages)
           _DocsSidebarButton(page: page, pageName: widget.pageName),
       ];
     }
     
     @override
     Widget build(BuildContext context) {
       return SidebarSection(
         header: Text(widget.section.title),
         children: pages,
       );
     }
   }
   ```

3. **Item buttons**:
   ```dart
   class _DocsSidebarButton extends StatefulWidget {
     final VNLookDocsPage page;
     final String pageName;
     
     @override
     State<_DocsSidebarButton> createState() => _DocsSidebarButtonState();
   }
   
   class _DocsSidebarButtonState extends State<_DocsSidebarButton> {
     @override
     Widget build(BuildContext context) {
       return DocsNavigationButton(
         onPressed: _onPressed,
         selected: widget.page.name == widget.pageName,
         trailing: widget.page.tag?.buildBadge(context),
         child: Text(widget.page.title),
       );
     }
     
     void _onPressed() {
       // Routing đến trang mới
       context.goNamed(widget.page.name);
     }
   }
   ```

4. **Sử dụng trong DocsPage**:
   ```dart
   MediaQueryVisibility(
     minWidth: breakpointWidth,
     child: FocusTraversalGroup(
       child: SingleChildScrollView(
         key: const PageStorageKey('sidebar'),
         padding: EdgeInsets.only(top: 32, left: 24 + padding.left, bottom: 32) * theme.scaling,
         child: _DocsSidebar(sections: sections, pageName: widget.name),
       ),
     ),
   )
   ```

#### Sidebar phải (On This Page)

1. **Cấu trúc widget**:
   ```dart
   class _DocsSecondarySidebar extends StatefulWidget {
     final Map<String, OnThisPage> onThisPage;
     final bool Function(OnThisPage) isVisible;
     final EdgeInsets padding;
     
     @override
     State<_DocsSecondarySidebar> createState() => _DocsSecondarySidebarState();
   }
   ```

2. **Xây dựng sidebar**:
   ```dart
   class _DocsSecondarySidebarState extends State<_DocsSecondarySidebar> {
     final List<Widget> _sideChildren = [];
     
     @override
     void initState() {
       super.initState();
       var side = <Widget>[];
       // Tạo các buttons từ onThisPage map
       for (var key in widget.onThisPage.keys) {
         side.add(SidebarButton(
           onPressed: () {
             // Scroll đến vị trí của section
             Scrollable.ensureVisible(
               widget.onThisPage[key]!.currentContext!,
               duration: kDefaultDuration,
               alignmentPolicy: ScrollPositionAlignmentPolicy.explicit
             );
           },
           selected: widget.isVisible(widget.onThisPage[key]!),
           child: Text(key),
         ));
       }
       
       // Thêm section vào sidebar
       _sideChildren.add(SidebarSection(
         header: const Text('On This Page'),
         children: side,
       ));
     }
     
     @override
     Widget build(BuildContext context) {
       final theme = VNLTheme.of(context);
       return Container(
         width: (widget.padding.right + 180) * theme.scaling,
         alignment: Alignment.topLeft,
         child: FocusTraversalGroup(
           child: SingleChildScrollView(
             padding: const EdgeInsets.only(
               top: 32, right: 24, bottom: 32, left: 24,
             ) * theme.scaling,
             child: SidebarNav(children: _sideChildren),
           ),
         ),
       );
     }
   }
   ```

3. **Sử dụng trong DocsPage**:
   ```dart
   MediaQueryVisibility(
     minWidth: breakpointWidth2,
     child: _DocsSecondarySidebar(
       onThisPage: onThisPage,
       isVisible: isVisible,
       padding: padding,
     ),
   )
   ```

#### So sánh hai sidebar

1. **Điểm chung**:
   - Đều sử dụng `SidebarNav` làm widget container chính
   - Đều sử dụng `SidebarSection` để nhóm các mục menu
   - Đều sử dụng các loại button tương tự (SidebarButton hoặc dẫn xuất)
   - Đều được quản lý responsive với `MediaQueryVisibility`

2. **Khác biệt**:
   - **Sidebar trái**: Phức tạp hơn với nhiều lớp widget lồng nhau, dùng cho điều hướng giữa các trang
   - **Sidebar phải**: Đơn giản hơn, dùng cho điều hướng trong cùng một trang
   - **Chức năng**: Sidebar trái dùng `context.goNamed()` để điều hướng, sidebar phải dùng `Scrollable.ensureVisible()` để cuộn
   - **Responsive**: Sidebar phải biến mất ở kích thước màn hình nhỏ hơn (breakpointWidth2 = 1024px) so với sidebar trái (breakpointWidth = 768px)

## 3. Quy trình hoạt động

### 3.1. Cơ chế theo dõi visibility

1. **Đăng ký listeners trong initState**:
   ```dart
   @override
   void initState() {
     super.initState();
     for (final child in widget.onThisPage.values) {
       child.isVisible.addListener(_onVisibilityChanged);
     }
   }
   ```

2. **Xử lý khi visibility thay đổi**:
   ```dart
   void _onVisibilityChanged() {
     if (!mounted) return;
     setState(() {
       currentlyVisible = widget.onThisPage.values
         .where((element) => element.isVisible.value)
         .toList();
     });
   }
   ```

3. **Highlight menu tương ứng**:
   ```dart
   bool isVisible(OnThisPage onThisPage) {
     return currentlyVisible.isNotEmpty && currentlyVisible[0] == onThisPage;
   }
   ```

### 3.2. Flow routing và rebuild

1. **Khởi tạo**: Tạo map `onThisPage` với tên phần và OnThisPage keys tương ứng
2. **Gắn tracking**: Với mỗi phần nội dung, sử dụng `.anchored()` để bọc và theo dõi
3. **Menu selection**: Khi click vào menu, GoRouter điều hướng đến trang mới
4. **Rebuild thông minh**: Mặc dù DocsPage mới được tạo, Flutter tối ưu hiệu suất:
   - Sidebar trái chỉ cập nhật trạng thái `selected`
   - Nội dung chính thay đổi hoàn toàn
   - Sidebar phải được xây dựng lại dựa trên `onThisPage` mới

### 3.3. Cơ chế Flutter tái sử dụng UI

1. **Widget vs Element Tree**: 
   - Khi rebuild, Flutter so sánh widget mới với cũ
   - Chỉ cập nhật Element Tree khi cần thiết

2. **Tối ưu với const widgets**:
   ```dart
   const VNLDivider(),
   ```

3. **Keys cho phần tử động**:
   ```dart
   SingleChildScrollView(
     key: const PageStorageKey('sidebar'),
     // ...
   )
   ```

4. **StatefulWidget với state bền vững**:
   ```dart
   @override
   void initState() {
     super.initState();
     children = [
       for (var section in widget.sections)
         _DocsSidebarSection(section: section, pageName: widget.pageName),
     ];
   }
   ```

## 4. Ví dụ đầy đủ

```dart
// 1. Khai báo các OnThisPage keys
final Map<String, OnThisPage> sectionsOnThisPage = {
  'Giới thiệu': OnThisPage('introduction'),
  'Cài đặt': OnThisPage('installation'),
  'Sử dụng': OnThisPage('usage'),
};

// 2. Tạo DocsPage với layout 3 panel
class MyDocumentationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'my-component',
      onThisPage: sectionsOnThisPage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần Giới thiệu với tracked visibility
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Giới thiệu', style: TextStyle(fontSize: 24)),
                Text('Thông tin về component này...'),
              ],
            ),
          ).anchored(sectionsOnThisPage['Giới thiệu']!),
          
          // Phần Cài đặt
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cài đặt', style: TextStyle(fontSize: 24)),
                Text('Cách cài đặt...'),
              ],
            ),
          ).anchored(sectionsOnThisPage['Cài đặt']!),
          
          // Phần Sử dụng
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sử dụng', style: TextStyle(fontSize: 24)),
                Text('Hướng dẫn sử dụng...'),
              ],
            ),
          ).anchored(sectionsOnThisPage['Sử dụng']!),
        ],
      ),
    );
  }
}
```

## 5. Xử lý responsive

Hệ thống tự động điều chỉnh theo kích thước màn hình:
- Màn hình lớn (>1024px): Hiển thị đầy đủ 3 panel
- Màn hình trung bình (768-1024px): Ẩn sidebar phải
- Màn hình nhỏ (<768px): Ẩn cả hai sidebar, hiển thị menu button để mở drawer

Responsive strategy:
```dart
MediaQueryVisibility(
  minWidth: breakpointWidth,
  alternateChild: /* Mobile layout */,
  child: /* Desktop layout */,
)
```

## 6. Lưu ý quan trọng

- Đảm bảo mỗi phần nội dung đều được bọc bằng `.anchored()` với OnThisPage key đúng
- Đăng ký listeners cho tất cả OnThisPage keys trong initState và hủy trong dispose
- Layout nên sử dụng MediaQueryVisibility để tự động điều chỉnh theo kích thước
- Thiết kế nội dung theo mẫu để tận dụng tối đa hệ thống theo dõi visibility

## 7. Lợi ích

- Tạo trải nghiệm đọc tài liệu chuyên nghiệp
- Người dùng dễ dàng điều hướng trong nội dung dài
- Tự động highlight phần đang xem
- Fully responsive trên mọi kích thước màn hình
- Hiệu suất tốt nhờ cơ chế rebuilding thông minh

Với hệ thống này, bạn có thể xây dựng các trang tài liệu phức tạp với trải nghiệm người dùng tuyệt vời. 