import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InformationColumn extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback call;
  final String icon;

  const InformationColumn(
      {super.key, required this.title, required this.value, required this.call,required this.icon});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return Padding(
    //   padding: const EdgeInsets.only(bottom:8.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(title,style: MyFaysalTheme.of(context).text1.override(color: MyFaysalTheme.of(context).primaryText.withOpacity(0.5)),),
    //       Text(
    //         value,
    //         style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: MediaQuery.of(context).size.width * 0.043 < 13 ? 13: MediaQuery.of(context).size.width * 0.043 > 21 ? 21:MediaQuery.of(context).size.width * 0.043 ,lineHeight: 1.7),)
    //     ],
    //   ),
    // );
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: call,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Row(
                children: [
                  Container(
                    width: size.longestSide * 0.07,
                    height: size.longestSide * 0.07,
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(
                        maxHeight: 56, maxWidth: 56, minHeight: 40, minWidth: 40),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyFaysalTheme.of(context).scaffolbackgeroundColor),
                    child: SvgPicture.asset(icon,
                        color: MyFaysalTheme.of(context).primaryText,
                       ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,style: MyFaysalTheme.of(context).promtHeaderText.override(fontSize: size.width * 0.045,color: MyFaysalTheme.of(context).primaryText),),
                        Text(value,style: MyFaysalTheme.of(context).text1.override(fontSize: size.width * 0.034,lineHeight: 2),)
                      ],
                    ),
                  )
                ],
              ),
            Icon(Icons.arrow_forward_ios_rounded,color: MyFaysalTheme.of(context).primaryText, size: size.longestSide * 0.02,)
          ],
        ),
      ),
    );
  }
}
