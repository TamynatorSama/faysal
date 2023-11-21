import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';

class BillListingCard extends StatelessWidget {
  final String imageAssset;
  final String bill;
  final VoidCallback call;
  final bool isUtility;
  const BillListingCard(
      {super.key,
      required this.bill,
      required this.call,
      required this.isUtility,
      required this.imageAssset});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
      child: InkWell(
        onTap: call,
        child: Row(
          children: [
            Container(
              width: size.longestSide * 0.05,
              height: size.longestSide * 0.05,
              alignment: Alignment.center,
              constraints: const BoxConstraints(
                  maxHeight: 50, maxWidth: 50, minHeight: 40, minWidth: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: AssetImage(imageAssset), fit: BoxFit.cover)),
            ),
            // images/Transfer.svg
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(bill,
                  style: MyFaysalTheme.of(context)
                      .promtHeaderText
                      .override(color: Colors.white, fontSize: 17)),
            ),
          ],
        ),
      ),
    );
  }
}
