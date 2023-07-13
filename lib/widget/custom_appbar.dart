import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.backgroundColor,
    this.systemOverlayStyle = SystemUiOverlayStyle.dark,
    this.iconTheme,
    this.actionsIconTheme,
    this.titleTextStyle,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight = 60.0,
    this.leadingWidth,
  })  : preferredSize = Size.fromHeight(toolbarHeight ??
            kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)),
        super(key: key);

  final Widget? leading;

  final bool automaticallyImplyLeading;

  final Widget? title;

  final List<Widget>? actions;

  final Widget? flexibleSpace;

  final PreferredSizeWidget? bottom;

  final double? elevation;

  final Color? shadowColor;

  final ShapeBorder? shape;

  final Color? backgroundColor;

  final SystemUiOverlayStyle? systemOverlayStyle;

  final IconThemeData? iconTheme;

  final IconThemeData? actionsIconTheme;

  final TextStyle? titleTextStyle;

  final bool primary;

  final bool? centerTitle;

  final bool excludeHeaderSemantics;

  final double? titleSpacing;

  final double toolbarOpacity;

  final double bottomOpacity;

  @override
  final Size preferredSize;

  final double? toolbarHeight;

  final double? leadingWidth; // default is 56.0

  @override
  Widget build(BuildContext context) {
    final titleRow = <Widget>[];
    if (title != null) {
      titleRow.add(title!);
    }
    return AppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Container(
        height: toolbarHeight,
        padding: EdgeInsets.only(top: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: title == null
              ? [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Image.asset(
                      'assets/logo/logo.png',
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                  )
                ]
              : titleRow,
        ),
      ),
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      backgroundColor: backgroundColor ?? Color.fromARGB(255, 101, 168, 223),
      systemOverlayStyle: systemOverlayStyle,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      titleTextStyle: titleTextStyle,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
    );
  }
}
