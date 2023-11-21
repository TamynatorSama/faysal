import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class ActionWidget extends StatelessWidget {
  final String image;
  final String text;
  final String header;
  const ActionWidget({super.key, required this.image, required this.text, required this.header });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          width: double.maxFinite,
          height: 170,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffFFDF6C),
              image: DecorationImage(
                  image: AssetImage(image),fit: BoxFit.cover)),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
          color: MyFaysalTheme.of(context).secondaryColor
          ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(header,style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: size.width * 0.04,color: MyFaysalTheme.of(context).accentColor ),),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width * 0.5),
                child: Text(text,style: MyFaysalTheme.of(context).text1.override(fontSize: size.width * 0.034 ),)),
            ),
            ],
          ),
          ),
          ],
          )),
    );
  }
}
