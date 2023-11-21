import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class TopupWalletInfo extends StatelessWidget {
  final String header;
  final String value;
  const TopupWalletInfo({super.key, required this.header,required this.value});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.58),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              AutoSizeText(
                header,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: MyFaysalTheme.of(context)
                    .text1
                    .override(fontSize: 14, color: Colors.white.withOpacity(0.5)),
              ),
              AutoSizeText(
                value,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: MyFaysalTheme.of(context)
                    .splashHeaderText
                    .override(fontSize: 21,lineHeight: 1.5),
              ),
            ],
          ),
        ));
  }
}
