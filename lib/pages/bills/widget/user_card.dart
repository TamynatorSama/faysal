import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/pages/bills/requests/model/verified_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserDetailsCard extends StatelessWidget {
  final VerifieduserCardModel model;
  final bool? isUtility;
  const UserDetailsCard({
    super.key,
    required this.model,
    this.isUtility
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MyFaysalTheme.of(context).secondaryColor,
        ),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Opacity(
                opacity: 0.1,
                child: FittedBox(child: SvgPicture.asset("assets/svg/smallbg.svg",color: Colors.grey,width: MediaQuery.of(context).size.width * 0.8,)))),
            Row(
              children: [
                Container(
                  width: 3,
                  height: 80,
                  color: MyFaysalTheme.of(context).primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( isUtility ==null? "Customer's name":"Meter name",
                              style: MyFaysalTheme.of(context)
                                  .promtHeaderText
                                  .override(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.3))),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: size.width * 0.65),
                            child: Text(
                              model.customerName,
                              overflow: TextOverflow.ellipsis,
                              style: MyFaysalTheme.of(context)
                                        .splashHeaderText
                                        .override(
                                            fontSize: size.width * 0.04,
                                            lineHeight: 1.7
                                          )
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(isUtility ==null?  "Customer's number":"Meter Number",
                                style: MyFaysalTheme.of(context)
                                    .promtHeaderText
                                    .override(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(0.3))),
                            Text(
                              model.customerNumber,
                              style: MyFaysalTheme.of(context)
                                      .splashHeaderText
                                      .override(
                                          fontSize: size.width * 0.04,
                                          lineHeight: 1.7
                                        )
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Text(isUtility ==null? "Current Bouquet":"Address",
                                  style: MyFaysalTheme.of(context)
                                      .promtHeaderText
                                      .override(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white.withOpacity(0.3))),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.8,
                              ),
                              child: AutoSizeText(
                                  model.currentBouquet,
                                  maxLines: 2,
                                  style: MyFaysalTheme.of(context)
                                      .splashHeaderText
                                      .override(
                                          fontSize: size.width * 0.04,
                                        )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
