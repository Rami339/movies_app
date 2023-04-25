import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/colors_app.dart';

Widget defaultText({
  required String text,
  required FontWeight fontWeight,
  required double fontSize,
  Color? color,
  TextOverflow? overflow,
int? maxLines,
}) {
  return Text(
    maxLines:maxLines ,
    overflow: overflow,
    text,
    style: TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    ),
  );
}

Widget defaultTextButton({
  required Function()? function,
  required Widget widget,
}) {
  return TextButton(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
    ),
    onPressed: function,
    child: widget,
  );
}

Widget defaultIcon({
  required IconData icon,
  Color? color,
  double? size,
}) {
  return Icon(
    icon,
    color: color,
    size: size,
  );
}

Widget defaultBackButton({
  required Function()? function,
}) {
  return IconButton(
    onPressed: function,
    icon: const Icon(Icons.chevron_left_outlined),
    color: whiteColor,
    iconSize: 40,
  );
}

void removeScreen(BuildContext context) {
  return Navigator.pop(context);
}
