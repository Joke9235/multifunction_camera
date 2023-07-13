import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? text;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;
  final bool? isOutline;
  final Color? outlineColor;
  final VoidCallback? clickCallback;
  final bool? isEnable;
  final bool? isLoading;
  final bool? isShadow;
  final bool isNextLine;

  const CustomButton({
    Key? key,
    this.height = 44.0,
    this.width = 200.0,
    this.text,
    this.margin,
    this.color,
    this.borderRadius,
    this.gradient,
    this.isOutline = false,
    this.outlineColor = Colors.blue,
    this.clickCallback,
    this.isEnable = true,
    this.isLoading = false,
    this.isShadow = false,
    this.isNextLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.linear,
      duration: Duration(milliseconds: 260),
      height: height,
      width: width,
      margin: margin ?? EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: isEnable!
          ? BoxDecoration(
              color: color ?? Color.fromARGB(255, 243, 226, 76),
              borderRadius: borderRadius ?? BorderRadius.circular(25.0),
              boxShadow: isShadow!
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        offset: Offset(0, 7),
                        blurRadius: 7,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.22),
                        offset: Offset(0, -2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
              gradient: gradient ?? null,
            )
          : BoxDecoration(
              color: Color(0xffD9DBDD),
              borderRadius: borderRadius ?? BorderRadius.circular(5.0),
              border: isOutline!
                  ? Border.all(
                      color: Colors.white,
                      width: 1,
                    )
                  : null,
              boxShadow: isShadow!
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.22),
                        offset: Offset(0, -2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
              gradient: null,
            ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          splashFactory:
              isEnable! ? InkSplash.splashFactory : NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(5.0),
          ),
          primary: Colors.transparent, // 设为透明色
          onPrimary: Colors.blue.withOpacity(0.36),
          elevation: 1, // 正常时阴影隐藏
          shadowColor: Colors.transparent,
          minimumSize: Size(96, 44),
          side: isOutline!
              ? isEnable!
                  ? BorderSide(color: this.outlineColor!, width: 1)
                  : BorderSide(color: Colors.transparent, width: 1)
              : BorderSide(color: Colors.transparent, width: 0),
        ),
        onPressed: isEnable! ? clickCallback ?? () {} : () {},
        child: isLoading!
            ? LayoutBuilder(builder: (context, constraints) {
                print(constraints.maxHeight);
                return SizedBox(
                  width: constraints.maxHeight / 2,
                  height: constraints.maxHeight / 2,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff3394D4)),
                    backgroundColor: Color(0xff3394D4).withOpacity(0.6),
                    strokeWidth: 1.0,
                  ),
                );
              })
            : isNextLine
                ? Container(
                    alignment: Alignment.center,
                    child: text ??
                        Text(
                          'button',
                          style: TextStyle(
                              color: isOutline!
                                  ? (isEnable!
                                      ? Color(0xff3394D4)
                                      : Colors.grey)
                                  : Colors.white,
                              fontSize: 14.0),
                        ),
                  )
                : Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: text ??
                          Text(
                            'button',
                            style: TextStyle(
                                color: isOutline!
                                    ? (isEnable!
                                        ? Color(0xff3394D4)
                                        : Colors.grey)
                                    : Colors.white,
                                fontSize: 14.0),
                          ),
                    ),
                  ),
      ),
    );
  }
}
