import 'package:emart/consts/consts.dart';

@override
Widget detailsCard(
    {required String? count, required String? title, required double width}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(68)
      .padding(const EdgeInsets.all(4))
      .make();
}
