import 'package:flutter/material.dart';

class MyElevatedButtonWidget extends StatefulWidget {
  final Widget label;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final Color? backGroundColor;
  const MyElevatedButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width,
    this.backGroundColor,
  }) : super(key: key);

  @override
  State<MyElevatedButtonWidget> createState() => _MyElevatedButtonWidgetState();
}

class _MyElevatedButtonWidgetState extends State<MyElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          primary: widget.backGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: widget.label,
      ),
    );
  }
}
