import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class AjoInfoHolder extends StatelessWidget {
  final String title;
  final String value;
  const AjoInfoHolder({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,style: MyFaysalTheme.of(context).promtHeaderText.override(color: Colors.white.withOpacity(0.2),fontSize: size.width * 0.04),),
        Text(value,style: MyFaysalTheme.of(context).promtHeaderText.override(color: Colors.white,fontSize: size.width * 0.051),)
      ],
    );
  }
}