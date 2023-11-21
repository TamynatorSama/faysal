import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/models/rotational_savings.dart';
import 'package:faysal/pages/topup/widgets/topup_button.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AjoContributionBreakdown extends StatefulWidget {
  final VoidCallback call;
  final MyRotationalSavingsModel model;
  const AjoContributionBreakdown(
      {super.key, required this.call, required this.model});

  @override
  State<AjoContributionBreakdown> createState() =>
      _AjoContributionBreakdownState();
}

class _AjoContributionBreakdownState extends State<AjoContributionBreakdown> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: size.height * 0.4,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              color: MyFaysalTheme.of(context).secondaryColor,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              color: Colors.white.withOpacity(0.4),
                              size: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior:
                            const ScrollBehavior().copyWith(overscroll: false),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6),
                                      child: AutoSizeText(
                                        "Contribution Breakdown",
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: MyFaysalTheme.of(context)
                                            .splashHeaderText
                                            .override(fontSize: 20),
                                      )),
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.58),
                                      child: AutoSizeText(
                                        "Save to ${widget.model.ajo.name}",
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: MyFaysalTheme.of(context)
                                            .text1
                                            .override(
                                                fontSize: 15,
                                                color: Colors.white
                                                    .withOpacity(0.5)),
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Amount",
                                        style: MyFaysalTheme.of(context)
                                            .text1
                                            .override(
                                                color: Colors.white
                                                    .withOpacity(0.3)),
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: size.width * 0.53),
                                        child: AutoSizeText.rich(
                                          TextSpan(children: [
                                            TextSpan(
                                                text: getCurrency(),
                                                style: const TextStyle(
                                                    fontFamily: "Poppins")),
                                            TextSpan(
                                                text: NumberFormat().format(
                                                    double.parse(widget
                                                        .model.ajo.amount)))
                                          ]),
                                          maxLines: 1,
                                          style: MyFaysalTheme.of(context)
                                              .splashHeaderText
                                              .override(
                                                  fontSize: size.width * 0.06),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Amount",
                                          style: MyFaysalTheme.of(context)
                                              .text1
                                              .override(
                                                  color: Colors.white
                                                      .withOpacity(0.3)),
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: size.width * 0.53),
                                          child: AutoSizeText(
                                            NumberFormat().format(
                                                widget.model.numberOfHand),
                                            style: MyFaysalTheme.of(context)
                                                .splashHeaderText
                                                .override(
                                                    fontSize:
                                                        size.width * 0.06),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "To Pay",
                                    style: MyFaysalTheme.of(context)
                                        .promtHeaderText
                                        .override(
                                            color: Colors.white, fontSize: 17),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: size.width * 0.53),
                                    child: AutoSizeText.rich(
                                      TextSpan(children: [
                                        TextSpan(
                                            text: getCurrency(),
                                            style: const TextStyle(
                                                fontFamily: "Poppins")),
                                        TextSpan(
                                            text: NumberFormat().format(
                                                double.parse(widget
                                                        .model.ajo.amount) *
                                                    widget.model.numberOfHand))
                                      ]),
                                      maxLines: 1,
                                      style: MyFaysalTheme.of(context)
                                          .splashHeaderText
                                          .override(
                                              fontSize: size.width * 0.06),
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    TopUpButton(
                                      reuse: true,
                                      text: "Pay from Wallet",
                                      color: MyFaysalTheme.of(context).primaryColor,
                                      call: (){
                                        Navigator.pop(context,true);
                                      },
                                    )
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 20.0),
                                    //   child: TopupWalletBtn(
                                    //     icon:
                                    //         '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="18" cy="5" r="3"></circle><circle cx="6" cy="12" r="3"></circle><circle cx="18" cy="19" r="3"></circle><line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line><line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line></svg>',
                                    //     text: "Share Account Details",
                                    //     call: () async {},
                                    //   ),
                                    // )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
