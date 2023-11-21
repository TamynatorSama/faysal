import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class TwoInfoDisplay extends StatelessWidget {
  final String firstVal;
  final String secondVal;
  const TwoInfoDisplay({super.key, required this.firstVal,required this.secondVal });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      height: 90,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: size.width < 327 ? 15 : 25),
      margin: const EdgeInsets.only(top: 15, bottom: 30),
      decoration: BoxDecoration(
        color: MyFaysalTheme.of(context).secondaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width * 0.2),
                  child: AutoSizeText(
                    "Account No.",
                    maxLines: 1,
                    style: MyFaysalTheme.of(context).text1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.008),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: size.width * 0.25),
                    child: AutoSizeText(
                      firstVal,
                      maxLines: 1,
                      style:
                          MyFaysalTheme.of(context).splashHeaderText.override(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            width: 1,
            color: MyFaysalTheme.of(context).primaryColor,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      "Faysal ID",
                      maxLines: 1,
                      style: MyFaysalTheme.of(context).text1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.008),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: size.width * 0.25),
                        child: AutoSizeText(
                          secondVal,
                          maxLines: 1,
                          style: MyFaysalTheme.of(context)
                              .splashHeaderText
                              .override(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
