import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class ProviderDisplay extends StatelessWidget {
  final String image;
  final String network;
  final bool isSelected;
  const ProviderDisplay({super.key,required this.image,required this.network,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width * 0.15,
          height: size.width * 0.15,
          decoration:
          
              BoxDecoration(
                border: isSelected? Border.all(width: 2,color: MyFaysalTheme.of(context).accentColor) :null,
                shape: BoxShape.circle, image: DecorationImage(image: AssetImage(image),fit: BoxFit.cover)),
        ),
        Text(
          network,
          style: MyFaysalTheme.of(context).text1.override(lineHeight: 1.7,fontSize: size.width * 0.033),
        )
      ],
    );
  }
}
