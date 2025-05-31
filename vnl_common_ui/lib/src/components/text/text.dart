import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart'
    as m
    show SelectableText, VNLTextButton, Colors, ButtonStyle, MaterialTapTargetSize;

import '../../../vnl_ui.dart';

abstract class VNLTextModifier extends StatelessWidget {
  const VNLTextModifier({super.key});

  @override
  Widget build(BuildContext context);

  Widget call() => this;
}

extension TextExtension on Widget {
  VNLTextModifier get sans => VNLWrappedText(style: (context, theme) => theme.typography.sans, child: this);

  VNLTextModifier get mono => VNLWrappedText(style: (context, theme) => theme.typography.mono, child: this);

  VNLTextModifier get xSmall => VNLWrappedText(style: (context, theme) => theme.typography.xSmall, child: this);

  VNLTextModifier get small => VNLWrappedText(style: (context, theme) => theme.typography.small, child: this);

  VNLTextModifier get base => VNLWrappedText(style: (context, theme) => theme.typography.base, child: this);

  VNLTextModifier get large => VNLWrappedText(style: (context, theme) => theme.typography.large, child: this);

  VNLTextModifier get xLarge => VNLWrappedText(style: (context, theme) => theme.typography.xLarge, child: this);

  VNLTextModifier get x2Large => VNLWrappedText(style: (context, theme) => theme.typography.x2Large, child: this);

  VNLTextModifier get x3Large => VNLWrappedText(style: (context, theme) => theme.typography.x3Large, child: this);

  VNLTextModifier get x4Large => VNLWrappedText(style: (context, theme) => theme.typography.x4Large, child: this);

  VNLTextModifier get x5Large => VNLWrappedText(style: (context, theme) => theme.typography.x5Large, child: this);

  VNLTextModifier get x6Large => VNLWrappedText(style: (context, theme) => theme.typography.x6Large, child: this);

  VNLTextModifier get x7Large => VNLWrappedText(style: (context, theme) => theme.typography.x7Large, child: this);

  VNLTextModifier get x8Large => VNLWrappedText(style: (context, theme) => theme.typography.x8Large, child: this);

  VNLTextModifier get x9Large => VNLWrappedText(style: (context, theme) => theme.typography.x9Large, child: this);

  VNLTextModifier get thin => VNLWrappedText(style: (context, theme) => theme.typography.thin, child: this);

  VNLTextModifier get extraLight => VNLWrappedText(style: (context, theme) => theme.typography.extraLight, child: this);

  VNLTextModifier get light => VNLWrappedText(style: (context, theme) => theme.typography.light, child: this);

  VNLTextModifier get normal => VNLWrappedText(style: (context, theme) => theme.typography.normal, child: this);

  VNLTextModifier get medium => VNLWrappedText(style: (context, theme) => theme.typography.medium, child: this);

  VNLTextModifier get semiBold => VNLWrappedText(style: (context, theme) => theme.typography.semiBold, child: this);

  VNLTextModifier get bold => VNLWrappedText(style: (context, theme) => theme.typography.bold, child: this);

  VNLTextModifier get extraBold => VNLWrappedText(style: (context, theme) => theme.typography.extraBold, child: this);

  VNLTextModifier get black => VNLWrappedText(style: (context, theme) => theme.typography.black, child: this);

  VNLTextModifier get italic => VNLWrappedText(style: (context, theme) => theme.typography.italic, child: this);

  VNLTextModifier get underline =>
      VNLWrappedText(style: (context, theme) => const TextStyle(decoration: TextDecoration.underline), child: this);

  VNLTextModifier get muted =>
      VNLWrappedText(style: (context, theme) => TextStyle(color: theme.colorScheme.mutedForeground), child: this);

  VNLTextModifier get primaryForeground =>
      VNLWrappedText(style: (context, theme) => TextStyle(color: theme.colorScheme.primaryForeground), child: this);

  VNLTextModifier get secondaryForeground =>
      VNLWrappedText(style: (context, theme) => TextStyle(color: theme.colorScheme.secondaryForeground), child: this);

  VNLTextModifier get h1 => VNLWrappedText(style: (context, theme) => theme.typography.h1, child: this);

  VNLTextModifier get h2 => VNLWrappedText(
    style: (context, theme) => theme.typography.h2,
    wrapper:
        (context, child) => Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: VNLTheme.of(context).colorScheme.border, width: 1)),
          ),
          child: child,
        ),
    child: this,
  );

  VNLTextModifier get h3 => VNLWrappedText(style: (context, theme) => theme.typography.h3, child: this);

  VNLTextModifier get h4 => VNLWrappedText(style: (context, theme) => theme.typography.h4, child: this);

  VNLTextModifier get p => VNLWrappedText(
    style: (context, theme) => theme.typography.p,
    child: this,
    wrapper: (context, child) {
      return Padding(padding: const EdgeInsets.only(top: 24), child: child);
    },
  );

  VNLTextModifier get firstP => VNLWrappedText(style: (context, theme) => theme.typography.p, child: this);

  VNLTextModifier get blockQuote => VNLWrappedText(
    style: (context, theme) => theme.typography.blockQuote,
    wrapper:
        (context, child) => Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: VNLTheme.of(context).colorScheme.border, width: 2)),
          ),
          padding: const EdgeInsets.only(left: 16),
          child: child,
        ),
    child: this,
  );

  VNLTextModifier get li => VNLWrappedText(
    wrapper: (context, child) {
      VNLUnorderedListData? data = Data.maybeOf(context);
      int depth = data?.depth ?? 0;
      TextStyle style = DefaultTextStyle.of(context).style;
      double size = (style.fontSize ?? 12) / 16 * 6;
      return IntrinsicWidth(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ((style.fontSize ?? 12) * (style.height ?? 1)) * 1.2,
              child: getBullet(context, depth, size),
            ),
            const SizedBox(width: 8),
            Expanded(child: Data.inherit(data: VNLUnorderedListData(depth: depth + 1), child: child)),
          ],
        ),
      );
    },
    child: this,
  );

  VNLTextModifier get inlineCode => VNLWrappedText(
    style: (context, theme) => theme.typography.inlineCode,
    wrapper: (context, child) {
      final style = DefaultTextStyle.of(context).style;
      final double paddingVertical = style.fontSize! * 0.2;
      final double paddingHorizontal = style.fontSize! * 0.3;
      final VNLThemeData themeData = VNLTheme.of(context);
      return Container(
        padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
        decoration: BoxDecoration(
          color: VNLTheme.of(context).colorScheme.muted,
          borderRadius: BorderRadius.circular(themeData.radiusSm),
        ),
        child: child,
      );
    },
    child: this,
  );

  VNLTextModifier get lead => VNLWrappedText(style: (context, theme) => theme.typography.lead, child: this).muted;

  VNLTextModifier get textLarge => VNLWrappedText(style: (context, theme) => theme.typography.textLarge, child: this);

  VNLTextModifier get textSmall => VNLWrappedText(style: (context, theme) => theme.typography.textSmall, child: this);

  VNLTextModifier get textMuted =>
      VNLWrappedText(style: (context, theme) => theme.typography.textMuted, child: this).muted;

  VNLTextModifier get singleLine =>
      VNLWrappedText(softWrap: (context, theme) => false, maxLines: (context, theme) => 1, child: this);

  VNLTextModifier get ellipsis => VNLWrappedText(overflow: (context, theme) => TextOverflow.ellipsis, child: this);

  VNLTextModifier get textCenter => VNLWrappedText(textAlign: (context, theme) => TextAlign.center, child: this);

  VNLTextModifier get textRight => VNLWrappedText(textAlign: (context, theme) => TextAlign.right, child: this);

  VNLTextModifier get textLeft => VNLWrappedText(textAlign: (context, theme) => TextAlign.left, child: this);

  VNLTextModifier get textJustify => VNLWrappedText(textAlign: (context, theme) => TextAlign.justify, child: this);

  VNLTextModifier get textStart => VNLWrappedText(textAlign: (context, theme) => TextAlign.start, child: this);

  VNLTextModifier get textEnd => VNLWrappedText(textAlign: (context, theme) => TextAlign.end, child: this);

  VNLTextModifier get modify =>
      VNLWrappedText(style: (context, theme) => TextStyle(color: theme.colorScheme.primaryForeground), child: this);

  VNLTextModifier get foreground =>
      VNLWrappedText(style: (context, theme) => TextStyle(color: theme.colorScheme.foreground), child: this);

  Widget then(InlineSpan span) {
    if (this is RichText) {
      final text = this as RichText;
      return _RichTextThenWidget(text: text, then: [span]);
    }
    if (this is VNLSelectableText) {
      final text = this as VNLSelectableText;
      return _SelectableTextThenWidget(text: text, then: [span]);
    }
    if (this is Text) {
      final text = this as Text;
      return _TextThenWidget(text: text, then: [span]);
    }
    if (this is _RichTextThenWidget) {
      final text = this as _RichTextThenWidget;
      return _RichTextThenWidget(text: text.text, then: [...text.then, span]);
    }
    if (this is _TextThenWidget) {
      final text = this as _TextThenWidget;
      return _TextThenWidget(text: text.text, then: [...text.then, span]);
    }
    if (this is _SelectableTextThenWidget) {
      final text = this as _SelectableTextThenWidget;
      return _SelectableTextThenWidget(text: text.text, then: [...text.then, span]);
    }
    InlineSpan currentSpan = WidgetSpan(child: this);
    return RichText(text: TextSpan(children: [currentSpan, span]));
  }

  Widget thenText(String text) {
    return then(TextSpan(text: text));
  }

  Widget thenInlineCode(String text) {
    return then(WidgetSpan(alignment: PlaceholderAlignment.middle, child: Text(text).inlineCode()));
  }

  Widget thenButton({required VoidCallback onPressed, required Widget child}) {
    return then(
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Builder(
          builder: (context) {
            final defaultTextStyle = DefaultTextStyle.of(context);
            return VNLLinkButton(
              onPressed: onPressed,
              child: Builder(
                builder: (context) {
                  final buttonTextStyle = DefaultTextStyle.of(context);
                  return DefaultTextStyle(
                    style: defaultTextStyle.style.copyWith(decoration: buttonTextStyle.style.decoration),
                    overflow: defaultTextStyle.overflow,
                    maxLines: defaultTextStyle.maxLines,
                    softWrap: defaultTextStyle.softWrap,
                    textAlign: defaultTextStyle.textAlign,
                    textHeightBehavior: defaultTextStyle.textHeightBehavior,
                    textWidthBasis: defaultTextStyle.textWidthBasis,
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TextThenWidget extends StatelessWidget {
  final Text text;
  final List<InlineSpan> then;

  const _TextThenWidget({required this.text, required this.then});

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = text.style;
    if (text.style == null || text.style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(text.style);
    }
    if (MediaQuery.boldTextOf(context)) {
      effectiveTextStyle = effectiveTextStyle!.merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);
    Widget result = RichText(
      textAlign: text.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: text.textDirection,
      locale: text.locale,
      softWrap: text.softWrap ?? defaultTextStyle.softWrap,
      overflow: text.overflow ?? effectiveTextStyle?.overflow ?? defaultTextStyle.overflow,
      textScaler: text.textScaler ?? TextScaler.noScaling,
      maxLines: text.maxLines ?? defaultTextStyle.maxLines,
      strutStyle: text.strutStyle,
      textWidthBasis: text.textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior:
          text.textHeightBehavior ?? defaultTextStyle.textHeightBehavior ?? DefaultTextHeightBehavior.maybeOf(context),
      selectionRegistrar: registrar,
      selectionColor:
          text.selectionColor ?? DefaultSelectionStyle.of(context).selectionColor ?? DefaultSelectionStyle.defaultColor,
      text: TextSpan(
        style: effectiveTextStyle,
        children: [text.data == null ? text.textSpan! : TextSpan(text: text.data), ...then],
      ),
    );
    if (registrar != null) {
      result = MouseRegion(
        cursor: DefaultSelectionStyle.of(context).mouseCursor ?? SystemMouseCursors.text,
        child: result,
      );
    }
    if (text.semanticsLabel != null) {
      result = Semantics(
        textDirection: text.textDirection,
        label: text.semanticsLabel,
        child: ExcludeSemantics(child: result),
      );
    }
    return result;
  }
}

class _RichTextThenWidget extends StatelessWidget {
  final RichText text;
  final List<InlineSpan> then;

  const _RichTextThenWidget({required this.text, required this.then});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: text.textAlign,
      textDirection: text.textDirection,
      locale: text.locale,
      softWrap: text.softWrap,
      overflow: text.overflow,
      textWidthBasis: text.textWidthBasis,
      textHeightBehavior: text.textHeightBehavior,
      maxLines: text.maxLines,
      strutStyle: text.strutStyle,
      selectionColor: text.selectionColor,
      selectionRegistrar: text.selectionRegistrar,
      textScaler: text.textScaler,
      text: TextSpan(children: [text.text, ...then]),
    );
  }
}

class _SelectableTextThenWidget extends StatelessWidget {
  final VNLSelectableText text;
  final List<InlineSpan> then;

  const _SelectableTextThenWidget({required this.text, required this.then});

  @override
  Widget build(BuildContext context) {
    String? stringData = text.data;
    TextSpan? textData = text.textSpan;
    return m.SelectableText.rich(
      TextSpan(text: stringData, children: [if (textData != null) textData, ...then]),
      style: text.style,
      contextMenuBuilder: text.contextMenuBuilder,
      minLines: text.minLines,
      semanticsLabel: text.semanticsLabel,
      textScaler: text.textScaler,
      selectionHeightStyle: text.selectionHeightStyle,
      selectionWidthStyle: text.selectionWidthStyle,
      textAlign: text.textAlign,
      textDirection: text.textDirection,
      textWidthBasis: text.textWidthBasis,
      textHeightBehavior: text.textHeightBehavior,
      maxLines: text.maxLines,
      strutStyle: text.strutStyle,
      onTap: text.onTap,
      scrollPhysics: text.scrollPhysics,
      showCursor: text.showCursor,
      cursorWidth: text.cursorWidth,
      cursorHeight: text.cursorHeight,
      cursorRadius: text.cursorRadius,
      cursorColor: text.cursorColor,
      dragStartBehavior: text.dragStartBehavior,
      enableInteractiveSelection: text.enableInteractiveSelection,
      autofocus: text.autofocus,
      focusNode: text.focusNode,
    );
  }
}

Widget getBullet(BuildContext context, int depth, double size) {
  final themeData = VNLTheme.of(context);
  if (depth == 0) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: themeData.colorScheme.foreground, shape: BoxShape.circle),
      ),
    );
  }
  if (depth == 1) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: themeData.colorScheme.foreground, width: 1),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
  return Center(
    child: Container(width: size, height: size, decoration: BoxDecoration(color: themeData.colorScheme.foreground)),
  );
}

class VNLUnorderedListData {
  const VNLUnorderedListData({
    this.depth = 0,
    this.items = const [],
    this.marker,
    this.markerAlignment = PlaceholderAlignment.middle,
    this.markerPadding = const EdgeInsets.only(right: 4),
  });

  final int depth;
  final List<InlineSpan> items;
  final Widget? marker;
  final PlaceholderAlignment markerAlignment;
  final EdgeInsets markerPadding;
}

typedef WrappedTextDataBuilder<T> = T Function(BuildContext context, VNLThemeData theme);
typedef WidgetTextWrapper = Widget Function(BuildContext context, Widget child);
typedef TextStyleBuilder = TextStyle Function(BuildContext context, VNLThemeData theme);

class VNLWrappedText extends StatelessWidget implements VNLTextModifier {
  final Widget child;
  final WrappedTextDataBuilder<TextStyle?>? style;
  final WrappedTextDataBuilder<TextAlign?>? textAlign;
  final WrappedTextDataBuilder<bool?>? softWrap;
  final WrappedTextDataBuilder<TextOverflow?>? overflow;
  final WrappedTextDataBuilder<int?>? maxLines;
  final WrappedTextDataBuilder<TextWidthBasis?>? textWidthBasis;
  final WidgetTextWrapper? wrapper;

  const VNLWrappedText({
    super.key,
    required this.child,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textWidthBasis,
    this.wrapper,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VNLTheme.of(context);
    return DefaultTextStyle.merge(
      child: wrapper?.call(context, child) ?? child,
      style: style?.call(context, theme),
      textAlign: textAlign?.call(context, theme),
      softWrap: softWrap?.call(context, theme),
      overflow: overflow?.call(context, theme),
      maxLines: maxLines?.call(context, theme),
      textWidthBasis: textWidthBasis?.call(context, theme),
    );
  }

  @override
  Widget call() => this;

  VNLWrappedText copyWith({
    WrappedTextDataBuilder<TextStyle>? style,
    WrappedTextDataBuilder<TextAlign>? textAlign,
    WrappedTextDataBuilder<bool>? softWrap,
    WrappedTextDataBuilder<TextOverflow>? overflow,
    WrappedTextDataBuilder<int>? maxLines,
    WrappedTextDataBuilder<TextWidthBasis>? textWidthBasis,
    WidgetTextWrapper? wrapper,
    Widget? child,
  }) {
    return VNLWrappedText(
      wrapper: wrapper ?? this.wrapper,
      style: style ?? this.style,
      textAlign: textAlign ?? this.textAlign,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      maxLines: maxLines ?? this.maxLines,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      child: child ?? this.child,
    );
  }

  VNLWrappedText copyWithStyle(WrappedTextDataBuilder<TextStyle> style) {
    return VNLWrappedText(
      wrapper: wrapper,
      style: (context, theme) => style(context, theme).merge(this.style?.call(context, theme)),
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      child: child,
    );
  }
}

class VNLTextModifierImpl extends StatelessWidget implements VNLTextModifier {
  const VNLTextModifierImpl({super.key, required this.style, required this.child});

  final TextStyleBuilder style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = VNLTheme.of(context);
    return DefaultTextStyle.merge(style: style(context, theme), child: child);
  }

  @override
  Widget call() => this;
}

extension VNLTextModifierLinkExtension on Widget {
  VNLTextModifier get link => VNLTextModifierImpl(
    style: (context, theme) => const TextStyle(decoration: TextDecoration.underline),
    child: this,
  );
}
