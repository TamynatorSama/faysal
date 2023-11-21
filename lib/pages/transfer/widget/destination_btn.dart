import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DestinationButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback call;

  const DestinationButton({super.key, required this.call,required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: call,
        child: Column(
          children: [
            Container(
              width: size.width * 0.17,
              height: size.width * 0.17,
              padding: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyFaysalTheme.of(context).primaryColor),
              child: SvgPicture.asset(
                icon,
              ),
            ),
            AutoSizeText(
              title,
              maxLines: 1,
              style: MyFaysalTheme.of(context)
                  .splashHeaderText
                  .override(fontSize: 17, lineHeight: 2.3),
            )
          ],
        ),
      ),
    );
  }
}
