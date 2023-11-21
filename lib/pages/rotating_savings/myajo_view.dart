// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:faysal/models/disbursement_history_model.dart';
import 'package:faysal/models/rotational_savings.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/ajo_members.dart';
import 'package:faysal/pages/rotating_savings/creation/successful_creation.dart';
import 'package:faysal/pages/rotating_savings/disbursement/disbursement_info.dart';
import 'package:faysal/pages/rotating_savings/join_savings/widget/ajo_info_holder.dart';
import 'package:faysal/pages/rotating_savings/requests/get_savings_request.dart';

import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/constants.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SingleAjoView extends StatefulWidget {
  final MyRotationalSavingsModel savings;

  const SingleAjoView({super.key, required this.savings});

  @override
  State<SingleAjoView> createState() => _SingleAjoViewState();
}

class _SingleAjoViewState extends State<SingleAjoView> {
  late SavingsProvider provider;
  bool isLoading = false;
  bool isRefresh = false;

  bool starting = false;
  bool contribute = false;
  List<DisbursementHistoryModel> disbursementHistory = [];
  dynamic summary = {};

  @override
  void initState() {
    provider = Provider.of<SavingsProvider>(context, listen: false);
    provider.members = [];
    getData();
    super.initState();
  }

  Future getData() async {
    // print("in here");
    if (!isRefresh) {
      setState(() {
        isLoading = true;
      });
    }
    var summaryResponse = await GetRotationalSavingsRequest()
        .getMyRotationalSavingsSumarry(widget.savings.ajo.id.toString());
    summary = summaryResponse["data"];
    // print(summary);
    await provider.getAjoMembers(widget.savings.ajo.id);
    // print("members");
    var response = await GetRotationalSavingsRequest.getDisbursementHistory(
        widget.savings.ajo.id);
    // print(response);

    disbursementHistory = (response["data"]["disbursementHisoty"] as List)
        .map((e) => DisbursementHistoryModel.fromJson(e))
        .toList();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaleFactor:
              MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
      child: Scaffold(
          backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
          body: isLoading
              ? const LoadingScreen()
              : Consumer<SavingsProvider>(
                  builder: (context, savingsProvider, child) {
                  return WidgetBackgorund(
                      home: true,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          isRefresh = true;
                          await getData();
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: Column(children: [
                              const CustomNavBar(header: "Rotating Savings"),
                              Expanded(
                                  child: ScrollConfiguration(
                                      behavior: const ScrollBehavior()
                                          .copyWith(overscroll: false),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: size.width * 0.26 < 76
                                                      ? 76
                                                      : size.width * 0.2 > 99
                                                          ? 99
                                                          : size.width * 0.26,
                                                  height: size.width * 0.2,
                                                  padding: EdgeInsets.all(
                                                      size.width * 0.045),
                                                  margin: EdgeInsets.only(
                                                      top: size.height * 0.03),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: MyFaysalTheme.of(
                                                              context)
                                                          .accentColor),
                                                  child: SvgPicture.asset(
                                                      "assets/svg/multiuser.svg"),
                                                ),
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          size.width * 0.7),
                                                  child: AutoSizeText(
                                                    widget.savings.ajo.name,
                                                    maxLines: 1,
                                                    style: MyFaysalTheme.of(
                                                            context)
                                                        .splashHeaderText
                                                        .override(
                                                            fontSize: 20,
                                                            lineHeight: 2),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AjoInfoHolder(
                                                      title: "AjoID",
                                                      value: widget
                                                          .savings.ajo.ajoCode),
                                                  AjoInfoHolder(
                                                      title: "Max Hands",
                                                      value: widget
                                                          .savings.numberOfHand
                                                          .toString()),
                                                  const AjoInfoHolder(
                                                      title: "Ajo Type",
                                                      value: "Community"),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                widget.savings.ajo.userId ==
                                                            Provider.of<ProfileProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .userProfile
                                                                .id &&
                                                        widget.savings.ajo
                                                                .isActive ==
                                                            1
                                                    ? Expanded(
                                                        child: GestureDetector(
                                                        onTap: () async {
                                                          if (starting) return;
                                                          setState(() {
                                                            starting = true;
                                                          });
                                                          var result =
                                                              await provider
                                                                  .startAjo(
                                                                      widget
                                                                          .savings
                                                                          .id,
                                                                      context);
                                                          if (result) {
                                                            widget.savings.ajo
                                                                .isActive = 2;
                                                          }
                                                          setState(() {
                                                            starting = false;
                                                          });
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              double.maxFinite,
                                                          height: 50,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 30),
                                                          decoration: BoxDecoration(
                                                              color: MyFaysalTheme
                                                                      .of(
                                                                          context)
                                                                  .primaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: starting
                                                              ? ConstrainedBox(
                                                                  constraints: const BoxConstraints(
                                                                      maxHeight:
                                                                          23,
                                                                      maxWidth:
                                                                          23),
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: MyFaysalTheme.of(
                                                                            context)
                                                                        .secondaryColor,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "Start Ajo",
                                                                  style: MyFaysalTheme.of(
                                                                          context)
                                                                      .promtHeaderText
                                                                      .override(
                                                                          color: MyFaysalTheme.of(context)
                                                                              .secondaryColor,
                                                                          fontSize:
                                                                              18),
                                                                ),
                                                        ),
                                                      ))
                                                    : const Offstage(),
                                                widget.savings.ajo.isActive == 2
                                                    ? Expanded(
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            var result =
                                                                await showAjoBreakdown(
                                                                    () {},
                                                                    widget
                                                                        .savings);

                                                            if (result == null) return;
                                                              
                                                            setState(() {
                                                              contribute = true;
                                                            });

                                                            await Provider.of<
                                                                        SavingsProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .makeContribution(
                                                                    widget
                                                                        .savings
                                                                        .ajo
                                                                        .id,
                                                                    context,
                                                                    widget
                                                                        .savings
                                                                        .ajo
                                                                        .name);
                                                            if (mounted) {
                                                              setState(() {
                                                                contribute =
                                                                    false;
                                                              });
                                                            }
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: double
                                                                .maxFinite,
                                                            height: 50,
                                                            margin:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    7,
                                                                    30,
                                                                    0,
                                                                    30),
                                                            decoration: BoxDecoration(
                                                                color: MyFaysalTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child: contribute
                                                                ? ConstrainedBox(
                                                                    constraints: const BoxConstraints(
                                                                        maxHeight:
                                                                            23,
                                                                        maxWidth:
                                                                            23),
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: MyFaysalTheme.of(
                                                                              context)
                                                                          .secondaryColor,
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    "Contribute",
                                                                    style: MyFaysalTheme.of(
                                                                            context)
                                                                        .promtHeaderText
                                                                        .override(
                                                                            color:
                                                                                MyFaysalTheme.of(context).secondaryColor,
                                                                            fontSize: 18),
                                                                  ),
                                                          ),
                                                        ),
                                                      )
                                                    : const Offstage(),
                                              ],
                                            ),
                                            Container(
                                              width: double.maxFinite,
                                              padding: const EdgeInsets.all(24),
                                              decoration: BoxDecoration(
                                                  color:
                                                      MyFaysalTheme.of(context)
                                                          .secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              margin: EdgeInsets.only(
                                                  top: widget.savings.ajo
                                                                  .userId ==
                                                              Provider.of<ProfileProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .userProfile
                                                                  .id &&
                                                          widget.savings.ajo
                                                                  .isActive ==
                                                              1
                                                      ? 0
                                                      : 30),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Ajo Target",
                                                                style: MyFaysalTheme.of(
                                                                        context)
                                                                    .promtHeaderText
                                                                    .override(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            5.0),
                                                                child:
                                                                    ConstrainedBox(
                                                                  constraints: BoxConstraints(
                                                                      maxWidth:
                                                                          size.width *
                                                                              0.4),
                                                                  child:
                                                                      AutoSizeText
                                                                          .rich(
                                                                    TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                              text: getCurrency(),
                                                                              style: const TextStyle(fontFamily: "Poppins")),
                                                                          TextSpan(
                                                                              text: NumberFormat().format(double.parse(summary["rotating_savings_target"].toString())))
                                                                        ]),
                                                                    maxLines: 1,
                                                                    style: MyFaysalTheme.of(
                                                                            context)
                                                                        .splashHeaderText
                                                                        .override(
                                                                            fontSize:
                                                                                size.width * 0.07),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () => Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                AjoDisbursementInfo(model: disbursementHistory))),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                  height:
                                                                      size.width *
                                                                          0.1,
                                                                  padding: EdgeInsets
                                                                      .all(size
                                                                              .width *
                                                                          0.02),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: MyFaysalTheme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                  child:
                                                                      SvgPicture
                                                                          .string(
                                                                    '<svg width="15" height="14" viewBox="0 0 15 14" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7.62156 12.0225C9.03605 12.0225 10.3926 11.4606 11.3928 10.4604C12.393 9.46017 12.9549 8.10362 12.9549 6.68913C12.9549 5.27464 12.393 3.91809 11.3928 2.91789C10.3926 1.9177 9.03605 1.35579 7.62156 1.35579C6.20707 1.35579 4.85052 1.9177 3.85033 2.91789C2.85013 3.91809 2.28823 5.27464 2.28823 6.68913C2.28823 8.10362 2.85013 9.46017 3.85033 10.4604C4.85052 11.4606 6.20707 12.0225 7.62156 12.0225ZM7.62156 13.3558C3.93956 13.3558 0.954895 10.3711 0.954895 6.68913C0.954895 3.00713 3.93956 0.0224609 7.62156 0.0224609C11.3036 0.0224609 14.2882 3.00713 14.2882 6.68913C14.2882 10.3711 11.3036 13.3558 7.62156 13.3558ZM6.9549 0.689128H8.28823V7.35579H6.9549V0.689128ZM6.9549 6.02246H13.6216V7.35579H6.9549V6.02246Z" fill="#0A221C"/></svg>',
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 20.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              child:
                                                                  LinearProgressIndicator(
                                                                value: (double.parse(summary["present_total_savings"].toString()) /
                                                                            double.parse(summary["rotating_savings_target"]
                                                                                .toString()) *
                                                                            1)
                                                                        .isNaN
                                                                    ? 1
                                                                    : (double.parse(summary["present_total_savings"]
                                                                            .toString()) /
                                                                        double.parse(
                                                                            summary["rotating_savings_target"].toString()) *
                                                                        1),
                                                                minHeight: 7.5,
                                                                color: MyFaysalTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                backgroundColor:
                                                                    MyFaysalTheme.of(
                                                                            context)
                                                                        .scaffolbackgeroundColor,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                              child:
                                                                  AutoSizeText
                                                                      .rich(
                                                                TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            " ${(double.parse(summary["present_total_savings"].toString()) / double.parse(summary["rotating_savings_target"].toString()) * 100).isNaN ? "0" : (double.parse(summary["present_total_savings"].toString()) / double.parse(summary["rotating_savings_target"].toString()) * 100).toString()}% saved of ",
                                                                      ),
                                                                      TextSpan(
                                                                          text:
                                                                              getCurrency(),
                                                                          style:
                                                                              const TextStyle(fontFamily: "Poppins")),
                                                                      TextSpan(
                                                                          text:
                                                                              "${NumberFormat().format(double.parse(summary["rotating_savings_target"].toString()))} target")
                                                                    ]),
                                                                style: MyFaysalTheme.of(
                                                                        context)
                                                                    .splashHeaderText
                                                                    .override(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                                width: double.maxFinite,
                                                margin: const EdgeInsets.only(
                                                    top: 15, bottom: 15),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 25,
                                                        horizontal: 15),
                                                decoration: BoxDecoration(
                                                    color: MyFaysalTheme.of(
                                                            context)
                                                        .secondaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 22),
                                                        child: InkWell(
                                                          onTap: () =>
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          AjoMembers(
                                                                            model:
                                                                                provider.allAjoMemebers,
                                                                            ajoName:
                                                                                widget.savings.ajo,
                                                                            isCreator:
                                                                                false,
                                                                          ))),
                                                          child: Row(
                                                            children: [
                                                              AutoSizeText(
                                                                  "Members",
                                                                  style: MyFaysalTheme.of(
                                                                          context)
                                                                      .splashHeaderText
                                                                      .override(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.037,
                                                                      )),
                                                              Container(
                                                                  width: 15,
                                                                  height: 15,
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  padding:
                                                                      const EdgeInsets.all(
                                                                          2),
                                                                  decoration: const BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Color(
                                                                          0xff64857D)),
                                                                  child: const FittedBox(
                                                                      child: Icon(
                                                                          Icons
                                                                              .arrow_forward_ios_rounded)))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      provider.allAjoMemebers
                                                              .isEmpty
                                                          ? Center(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        20.0),
                                                                child: Column(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      "assets/svg/empty.svg",
                                                                      width: size
                                                                              .width *
                                                                          0.27,
                                                                      color: MyFaysalTheme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 10.0,
                                                                              bottom: 5),
                                                                          child:
                                                                              Text(
                                                                            "Oops, Nothing here :(",
                                                                            style:
                                                                                MyFaysalTheme.of(context).splashHeaderText.override(fontSize: size.width * 0.045),
                                                                          ),
                                                                        ),
                                                                        ConstrainedBox(
                                                                            constraints:
                                                                                BoxConstraints(maxWidth: size.width * 0.55),
                                                                            child: Text(
                                                                              "There seems to be no member in this community savings at the moment",
                                                                              textAlign: TextAlign.center,
                                                                              style: MyFaysalTheme.of(context).text1.override(fontSize: size.width * 0.033, color: Colors.white.withOpacity(0.3)),
                                                                            )),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Wrap(
                                                              alignment:
                                                                  WrapAlignment
                                                                      .start,
                                                              spacing: 20,
                                                              children:
                                                                  List.generate(
                                                                      provider.allAjoMemebers.length <
                                                                              4
                                                                          ? provider
                                                                              .allAjoMemebers
                                                                              .length
                                                                          : 4,
                                                                      (index) =>
                                                                          Column(
                                                                            children: [
                                                                              Container(
                                                                                width: size.width * 0.22 < 30
                                                                                    ? 30
                                                                                    : size.width * 0.22 > 60
                                                                                        ? 60
                                                                                        : size.width * 0.22,
                                                                                height: size.width * 0.18,
                                                                                decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                    image: provider.allAjoMemebers[index].userData.avatar.isEmpty
                                                                                        ? DecorationImage(image: AssetImage("assets/avatar/avatar${generateAvatar(provider.allAjoMemebers[index].userData.id.toString())}.png"))
                                                                                        : DecorationImage(
                                                                                            image: CachedNetworkImageProvider(
                                                                                            "$imageUrl/${provider.allAjoMemebers[index].userData.avatar}",
                                                                                          ))
                                                                                    //  image: DecorationImage(image: AssetImage("assets/avatar/avatar${generateAvatar(provider.allAjoMemebers[index].id)}.png")
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                provider.allAjoMemebers[index].userData.name.split(" ").first.capitalize(),
                                                                                style: MyFaysalTheme.of(context).promtHeaderText.override(color: Colors.white, fontSize: size.width * 0.033),
                                                                              )
                                                                            ],
                                                                          )),
                                                            )
                                                    ])),
                                            Container(
                                              width: double.maxFinite,
                                              padding: const EdgeInsets.all(24),
                                              margin: const EdgeInsets.only(
                                                  bottom: 15),
                                              decoration: BoxDecoration(
                                                  color:
                                                      MyFaysalTheme.of(context)
                                                          .secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Ajo Details",
                                                        style: MyFaysalTheme.of(
                                                                context)
                                                            .promtHeaderText
                                                            .override(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 12.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Amount accumulated",
                                                              style: MyFaysalTheme.of(context).text1.override(
                                                                  fontSize:
                                                                      size.width *
                                                                          0.04,
                                                                  color: MyFaysalTheme.of(
                                                                          context)
                                                                      .primaryText
                                                                      .withOpacity(
                                                                          0.3)),
                                                            ),
                                                            ConstrainedBox(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxWidth:
                                                                          size.width *
                                                                              0.53),
                                                              child:
                                                                  AutoSizeText
                                                                      .rich(
                                                                TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          text:
                                                                              getCurrency(),
                                                                          style:
                                                                              const TextStyle(fontFamily: "Poppins")),
                                                                      TextSpan(
                                                                          text:
                                                                              NumberFormat().format((double.parse(summary["present_total_savings"].toString()))))
                                                                    ]),
                                                                maxLines: 1,
                                                                style: MyFaysalTheme.of(
                                                                        context)
                                                                    .text1
                                                                    .override(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.045),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 12.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Saving Amount",
                                                              style: MyFaysalTheme.of(context).text1.override(
                                                                  fontSize:
                                                                      size.width *
                                                                          0.04,
                                                                  color: MyFaysalTheme.of(
                                                                          context)
                                                                      .primaryText
                                                                      .withOpacity(
                                                                          0.3)),
                                                            ),
                                                            ConstrainedBox(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxWidth:
                                                                          size.width *
                                                                              0.53),
                                                              child:
                                                                  AutoSizeText
                                                                      .rich(
                                                                TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          text:
                                                                              getCurrency(),
                                                                          style:
                                                                              const TextStyle(fontFamily: "Poppins")),
                                                                      TextSpan(
                                                                          text: NumberFormat().format((double.parse(widget.savings.ajo.amount) *
                                                                              widget.savings.numberOfHand)))
                                                                    ]),
                                                                maxLines: 1,
                                                                style: MyFaysalTheme.of(
                                                                        context)
                                                                    .text1
                                                                    .override(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.045),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 12.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Frequency",
                                                              style: MyFaysalTheme.of(context).text1.override(
                                                                  fontSize:
                                                                      size.width *
                                                                          0.04,
                                                                  color: MyFaysalTheme.of(
                                                                          context)
                                                                      .primaryText
                                                                      .withOpacity(
                                                                          0.3)),
                                                            ),
                                                            ConstrainedBox(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxWidth:
                                                                          size.width *
                                                                              0.4),
                                                              child: Text(
                                                                  Provider.of<SavingsProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .frequency
                                                                      .where((element) =>
                                                                          element
                                                                              .id ==
                                                                          widget
                                                                              .savings
                                                                              .ajo
                                                                              .frequencyId)
                                                                      .toList()
                                                                      .first
                                                                      .name,
                                                                  style: MyFaysalTheme.of(
                                                                          context)
                                                                      .text1
                                                                      .override(
                                                                          fontSize:
                                                                              size.width * 0.045)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 12.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Coordinator Fee",
                                                              style: MyFaysalTheme.of(context).text1.override(
                                                                  fontSize:
                                                                      size.width *
                                                                          0.04,
                                                                  color: MyFaysalTheme.of(
                                                                          context)
                                                                      .primaryText
                                                                      .withOpacity(
                                                                          0.3)),
                                                            ),
                                                            ConstrainedBox(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxWidth:
                                                                          size.width *
                                                                              0.53),
                                                              child:
                                                                  AutoSizeText
                                                                      .rich(
                                                                TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          text:
                                                                              getCurrency(),
                                                                          style:
                                                                              const TextStyle(fontFamily: "Poppins")),
                                                                      TextSpan(
                                                                          text: NumberFormat().format((double.parse(widget.savings.ajo.coordinatorFee) *
                                                                              widget.savings.numberOfHand)))
                                                                    ]),
                                                                maxLines: 1,
                                                                style: MyFaysalTheme.of(
                                                                        context)
                                                                    .text1
                                                                    .override(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.045),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 12.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Disbursement date",
                                                              style: MyFaysalTheme.of(context).text1.override(
                                                                  fontSize:
                                                                      size.width *
                                                                          0.04,
                                                                  color: MyFaysalTheme.of(
                                                                          context)
                                                                      .primaryText
                                                                      .withOpacity(
                                                                          0.3)),
                                                            ),
                                                            ConstrainedBox(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxWidth:
                                                                          size.width *
                                                                              0.53),
                                                              child:
                                                                  AutoSizeText(
                                                                widget
                                                                        .savings
                                                                        .ajo
                                                                        .nextDisbursemetDate
                                                                        .isEmpty
                                                                    ? "Not Determined"
                                                                    : DateFormat
                                                                            .yMMMEd()
                                                                        .format(DateTime.parse(widget
                                                                            .savings
                                                                            .ajo
                                                                            .nextDisbursemetDate)),
                                                                maxLines: 1,
                                                                style: MyFaysalTheme.of(
                                                                        context)
                                                                    .text1
                                                                    .override(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.045),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )))
                            ])),
                      ));
                })),
    );
  }

  navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SuccessfulSavingsCreation(
                header: "Successfully joined Ajo",
                message: "You are now a member and can save to Loop Ajo",
              )),
    );
  }
}

// Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Text(
//                                                           "Amount accumulated",
//                                                           style: MyFaysalTheme
//                                                                   .of(context)
//                                                               .text1
//                                                               .override(
//                                                                   fontSize:
//                                                                       size.width *
//                                                                           0.04,
//                                                                   color: MyFaysalTheme.of(
//                                                                           context)
//                                                                       .primaryText
//                                                                       .withOpacity(
//                                                                           0.3)),
//                                                         ),
//                                                         ConstrainedBox(
//                                                           constraints:
//                                                               BoxConstraints(
//                                                                   maxWidth:
//                                                                       size.width *
//                                                                           0.53),
//                                                           child:
//                                                               AutoSizeText.rich(
//                                                             TextSpan(children: [
//                                                               TextSpan(
//                                                                   text:
//                                                                       getCurrency(),
//                                                                   style: const TextStyle(
//                                                                       fontFamily:
//                                                                           "Poppins")),
//                                                               TextSpan(
//                                                                   text: NumberFormat().format((double.parse(widget
//                                                                           .savings
//                                                                           .ajo
//                                                                           .amount) *
//                                                                       widget
//                                                                           .savings
//                                                                           .numberOfHand)))
//                                                             ]),
//                                                             maxLines: 1,
//                                                             style: MyFaysalTheme
//                                                                     .of(context)
//                                                                 .text1
//                                                                 .override(
//                                                                     fontSize:
//                                                                         size.width *
//                                                                             0.045),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
                                                  
