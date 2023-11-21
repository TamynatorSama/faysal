import 'package:faysal/models/disbursement_history_model.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AjoDisbursementInfo extends StatelessWidget {
  final List<DisbursementHistoryModel> model;
  const AjoDisbursementInfo({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
        body: WidgetBackgorund(
          child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(children: [
                const CustomNavBar(header: "Disbusement Info"),
                Expanded(
                    child: ScrollConfiguration(
                        behavior:
                            const ScrollBehavior().copyWith(overscroll: false),
                        child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: Column(
                                  children: List.generate(
                                      model.length,
                                      (index) => Container(
                                            margin:
                                                const EdgeInsets.only(top: 30,),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                              color: MyFaysalTheme.of(context)
                                                  .secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, bottom: 8),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          const EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: MyFaysalTheme.of(
                                                                  context)
                                                              .primaryColor),
                                                      child: SvgPicture.string(
                                                        '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 48 48"><g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="4"><path d="M24 14a5 5 0 1 0 0-10a5 5 0 0 0 0 10Zm3 6h-6c-.929 0-1.393 0-1.784.038a8 8 0 0 0-7.178 7.178C12 27.607 12 28.07 12 29h24c0-.929 0-1.393-.038-1.784a8 8 0 0 0-7.178-7.178C28.393 20 27.93 20 27 20Z"/><path d="M41 26.784c1.902 1.224 3 2.669 3 4.216c0 4.418-8.954 8-20 8S4 35.418 4 31c0-1.547 1.098-2.992 3-4.216"/><path d="m19 34l5 5l-5 5"/></g></svg>',
                                                        width: 23,
                                                        height: 23,
                                                        color: MyFaysalTheme.of(
                                                                context)
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("Turn",
                                                              style: MyFaysalTheme.of(
                                                                      context)
                                                                  .splashHeaderText
                                                                  .override(
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.5),
                                                                      fontSize:
                                                                          13)),
                                                          Text(
                                                            model[index].turn,
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .splashHeaderText
                                                                .override(
                                                                    fontSize: 15,
                                                                    lineHeight:
                                                                        1.7),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: MyFaysalTheme.of(context)
                                                    .primaryText
                                                    .withOpacity(0.5),
                                                thickness: 1.3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, bottom: 8),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          const EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: MyFaysalTheme.of(
                                                                  context)
                                                              .primaryColor),
                                                      child: SvgPicture.string(
                                                        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 3H2v15h7c1.7 0 3 1.3 3 3V7c0-2.2-1.8-4-4-4Z"></path><path d="m16 12 2 2 4-4"></path><path d="M22 6V3h-6c-2.2 0-4 1.8-4 4v14c0-1.7 1.3-3 3-3h7v-2.3"></path></svg>',
                                                        width: 23,
                                                        height: 23,
                                                        color: MyFaysalTheme.of(
                                                                context)
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Status",
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .splashHeaderText
                                                                .override(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.5),
                                                                    fontSize: 13),
                                                          ),
                                                          Text(
                                                            model[index].status,
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .splashHeaderText
                                                                .override(
                                                                    fontSize: 15,
                                                                    lineHeight:
                                                                        1.7),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: MyFaysalTheme.of(context)
                                                    .primaryText
                                                    .withOpacity(0.5),
                                                thickness: 1.3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0, bottom: 2),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          const EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: MyFaysalTheme.of(
                                                                  context)
                                                              .primaryColor),
                                                      child: SvgPicture.string(
                                                        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line><path d="M17 14h-6"></path><path d="M13 18H7"></path><path d="M7 14h.01"></path><path d="M17 18h.01"></path></svg>',
                                                        width: 23,
                                                        height: 23,
                                                        color: MyFaysalTheme.of(
                                                                context)
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Date",
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .splashHeaderText
                                                                .override(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.5),
                                                                    fontSize: 13),
                                                          ),
                                                          Text(
                                                            model[index].date,
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .splashHeaderText
                                                                .override(
                                                                    fontSize: 15,
                                                                    lineHeight:
                                                                        1.7),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: MyFaysalTheme.of(context)
                                                    .primaryText
                                                    .withOpacity(0.5),
                                                thickness: 1.3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0, bottom: 2),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          const EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: MyFaysalTheme.of(
                                                                  context)
                                                              .primaryColor),
                                                      child: SvgPicture.string(
                                                        '<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M10.05 4.575a1.575 1.575 0 10-3.15 0v3m3.15-3v-1.5a1.575 1.575 0 013.15 0v1.5m-3.15 0l.075 5.925m3.075.75V4.575m0 0a1.575 1.575 0 013.15 0V15M6.9 7.575a1.575 1.575 0 10-3.15 0v8.175a6.75 6.75 0 006.75 6.75h2.018a5.25 5.25 0 003.712-1.538l1.732-1.732a5.25 5.25 0 001.538-3.712l.003-2.024a.668.668 0 01.198-.471 1.575 1.575 0 10-2.228-2.228 3.818 3.818 0 00-1.12 2.687M6.9 7.575V12m6.27 4.318A4.49 4.49 0 0116.35 15m.002 0h-.002" /></svg>',
                                                        width: 23,
                                                        height: 23,
                                                        color: MyFaysalTheme.of(
                                                                context)
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Number of hands",
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .splashHeaderText
                                                                .override(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.5),
                                                                    fontSize: 13),
                                                          ),
                                                          Text(
                                                            model[index]
                                                                .numberOfHands
                                                                .toString(),
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .splashHeaderText
                                                                .override(
                                                                    fontSize: 15,
                                                                    lineHeight:
                                                                        1.7),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: MyFaysalTheme.of(context)
                                                    .primaryText
                                                    .withOpacity(0.5),
                                                thickness: 1.3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0, bottom: 2),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 33,
                                                      width: 33,
                                                      padding:
                                                          const EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: MyFaysalTheme.of(
                                                                  context)
                                                              .primaryColor),
                                                      child: SvgPicture.string(
                                                        '<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0115.797 2.101c.727.198 1.453-.342 1.453-1.096V18.75M3.75 4.5v.75A.75.75 0 013 6h-.75m0 0v-.375c0-.621.504-1.125 1.125-1.125H20.25M2.25 6v9m18-10.5v.75c0 .414.336.75.75.75h.75m-1.5-1.5h.375c.621 0 1.125.504 1.125 1.125v9.75c0 .621-.504 1.125-1.125 1.125h-.375m1.5-1.5H21a.75.75 0 00-.75.75v.75m0 0H3.75m0 0h-.375a1.125 1.125 0 01-1.125-1.125V15m1.5 1.5v-.75A.75.75 0 003 15h-.75M15 10.5a3 3 0 11-6 0 3 3 0 016 0zm3 0h.008v.008H18V10.5zm-12 0h.008v.008H6V10.5z" /></svg>',
                                                        width: 23,
                                                        height: 23,
                                                        color: MyFaysalTheme.of(
                                                                context)
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "amount",
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .splashHeaderText
                                                                .override(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.5),
                                                                    fontSize: 13),
                                                          ),
                                                          Text(
                                                            model[index].amount,
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .splashHeaderText
                                                                .override(
                                                                    fontSize: 15,
                                                                    lineHeight:
                                                                        1.7),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          ))),
                            ))))
              ])),
        ));
  }
}
