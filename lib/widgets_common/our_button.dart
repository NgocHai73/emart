import 'package:emart/consts/consts.dart';

Widget ourButton(
    {required Color color,
    required String? title,
    required Color textColor,
    required Null Function() onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color, padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
