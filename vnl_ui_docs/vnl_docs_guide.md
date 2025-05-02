# Hướng dẫn sử dụng hệ thống điều hướng tài liệu VNL UI

## 1. Tổng quan hệ thống

VNL UI cung cấp một hệ thống hoàn chỉnh để xây dựng trang tài liệu với điều hướng thông minh, gồm:
- Layout 3 panel responsive (sidebar trái, nội dung, sidebar phải)
- Theo dõi vị trí đọc hiện tại và highlight tương ứng trong menu
- Điều hướng nhanh thông qua "On This Page" sidebar

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

### 2.6. _DocsSecondarySidebarState

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

## 3. Quy trình hoạt động

1. **Khởi tạo**: Tạo map `onThisPage` với tên phần và OnThisPage keys tương ứng
2. **Gắn tracking**: Với mỗi phần nội dung, sử dụng `.anchored()` để bọc và theo dõi
3. **Theo dõi visibility**: VisibilityDetector cập nhật trạng thái `isVisible` khi scrolling
4. **Sidebar hiển thị**: Sidebar phải hiển thị tất cả các phần với highlight phần đang xem
5. **Điều hướng**: Khi click vào mục sidebar, trang cuộn đến phần tương ứng

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

## 6. Lưu ý quan trọng

- Đảm bảo mỗi phần nội dung đều được bọc bằng `.anchored()` với OnThisPage key đúng
- Đăng ký listeners cho tất cả OnThisPage keys trong initState và hủy trong dispose
- Layout nên sử dụng MediaQueryVisibility để tự động điều chỉnh theo kích thước

## 7. Lợi ích

- Tạo trải nghiệm đọc tài liệu chuyên nghiệp
- Người dùng dễ dàng điều hướng trong nội dung dài
- Tự động highlight phần đang xem
- Fully responsive trên mọi kích thước màn hình

Với hệ thống này, bạn có thể xây dựng các trang tài liệu phức tạp với trải nghiệm người dùng tuyệt vời. 