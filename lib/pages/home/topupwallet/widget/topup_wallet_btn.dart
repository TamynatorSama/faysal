

import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopupWalletBtn extends StatelessWidget {

  final String icon;
  final String text;
  final VoidCallback call;
  const TopupWalletBtn({super.key,required this.call,required this.text,required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:call,
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(color: MyFaysalTheme.of(context).primaryColor,width: 1.4),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.string(icon,color: MyFaysalTheme.of(context).primaryColor,width: MediaQuery.of(context).size.width * 0.07,),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(text,style: MyFaysalTheme.of(context).text1.override(color: MyFaysalTheme.of(context).primaryColor,fontSize:MediaQuery.of(context).size.width * 0.035)),
            )
          ],
        ),
      ),
    );
  }
}