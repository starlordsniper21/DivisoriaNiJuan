// ignore_for_file: file_names, deprecated_member_use

import 'package:divisorianijuanmain/consts/consts.dart';

Widget buttonOur({color, String? title, textColor, onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}
