// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/models/rotational_savings.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/creation/successful_creation.dart';
import 'package:faysal/pages/rotating_savings/join_savings/widget/ajo_info_holder.dart';
import 'package:faysal/pages/rotating_savings/requests/get_savings_request.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/dynamic_links.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SingleJoinView extends StatefulWidget {
  final RotationalSavingsModel? savings;
  final String? ajoCode;

  const SingleJoinView({
    super.key,
    this.savings,
    this.ajoCode,
  });

  @override
  State<SingleJoinView> createState() => _SingleJoinViewState();
}

class _SingleJoinViewState extends State<SingleJoinView> {
  late SavingsProvider provider;
  bool isLoading = false;
  bool isJoining = false;
  dynamic summary = {};
  RotationalSavingsModel? model;

  @override
  void initState() {
    if (widget.savings != null) {
      model = widget.savings;
    }
    provider = Provider.of<SavingsProvider>(context, listen: false);
    getData();
    super.initState();
  }

  getData() async {
    // print("got here");
    setState(() {
      isLoading = true;
    });
    if (widget.ajoCode != null && widget.ajoCode!.isNotEmpty) {
      var response = await GetRotationalSavingsRequest()
          .getRotationalSavings(widget.ajoCode);
      if (response["status"] == true && (response["data"] as List).isNotEmpty) {
        var modelList = (response["data"] as List)
            .map((e) => RotationalSavingsModel.fromJson(e))
            .toList();
        model = modelList.first;
      } else {
        showToast(context, "Invalid Rotational savings code");
        if (DynamicLinkHandler().fromLogin) {
          Navigator.pushReplacementNamed(context, '/ajo');
        }
        else{
          Navigator.pop(context);
        }
        
      }
    }
    var summaryResponse = await GetRotationalSavingsRequest()
        .getMyRotationalSavingsSumarry(model!.id.toString());
    summary = summaryResponse["data"];

    if (provider.frequency.isEmpty) {
      await provider.getFrequency();
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (DynamicLinkHandler().fromLogin) {
          Navigator.pushReplacementNamed(context, '/ajo');
        }
        return true;
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
            textScaleFactor:
                MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
        child: Scaffold(
            backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
            body: isLoading
                ? const LoadingScreen()
                : WidgetBackgorund(
                    home: true,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Column(children: [
                          CustomNavBar(
                            header: "Rotating Savings",
                            customCall: DynamicLinkHandler().fromLogin
                                ? () {
                                    Navigator.pushReplacementNamed(
                                        context, '/ajo');
                                  }
                                : null,
                          ),
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
                                                  size.width * 0.05),
                                              margin: EdgeInsets.only(
                                                  top: size.height * 0.03),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      MyFaysalTheme.of(context)
                                                          .accentColor),
                                              child: SvgPicture.asset(
                                                  "assets/svg/multiuser.svg"),
                                            ),
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxWidth: size.width * 0.7),
                                              child: AutoSizeText(
                                                model!.name,
                                                maxLines: 1,
                                                style: MyFaysalTheme.of(context)
                                                    .splashHeaderText
                                                    .override(
                                                        fontSize: 20,
                                                        lineHeight: 2),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AjoInfoHolder(
                                                  title: "AjoID",
                                                  value: model!.ajoCode),
                                              AjoInfoHolder(
                                                  title: "Max Hands",
                                                  value: model!.numberOfHand
                                                      .toString()),
                                              const AjoInfoHolder(
                                                  title: "Ajo Type",
                                                  value: "Community"),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (isJoining) return;
                                            var hands =
                                                await showNumberOfHandsDialog(
                                                    model!.numberOfHand);

                                            if (hands == null) return;

                                            setState(() {
                                              isJoining = true;
                                            });

                                            var response =
                                                await provider.joinSavings(
                                                    context,
                                                    hands,
                                                    model!.id.toString());

                                            setState(() {
                                              isJoining = false;
                                            });

                                            if (response) {
                                              navigate();
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.maxFinite,
                                            height: 50,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 30),
                                            decoration: BoxDecoration(
                                                color: MyFaysalTheme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: isJoining
                                                ? ConstrainedBox(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxHeight: 23,
                                                            maxWidth: 23),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: MyFaysalTheme.of(
                                                              context)
                                                          .secondaryColor,
                                                    ),
                                                  )
                                                : Text(
                                                    "Join Ajo",
                                                    style: MyFaysalTheme.of(
                                                            context)
                                                        .promtHeaderText
                                                        .override(
                                                            color: MyFaysalTheme
                                                                    .of(context)
                                                                .secondaryColor,
                                                            fontSize: 18),
                                                  ),
                                          ),
                                        ),
                                        Container(
                                          width: double.maxFinite,
                                          padding: const EdgeInsets.all(24),
                                          decoration: BoxDecoration(
                                              color: MyFaysalTheme.of(context)
                                                  .secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Ajo Target",
                                                    style: MyFaysalTheme.of(
                                                            context)
                                                        .promtHeaderText
                                                        .override(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0),
                                                    child: ConstrainedBox(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth:
                                                                  size.width *
                                                                      0.53),
                                                      child: AutoSizeText.rich(
                                                        TextSpan(children: [
                                                          TextSpan(
                                                              text:
                                                                  getCurrency(),
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      "Poppins")),
                                                          TextSpan(
                                                              text: NumberFormat()
                                                                  .format(double
                                                                      .parse(summary[
                                                                              "rotating_savings_target"]
                                                                          .toString())))
                                                        ]),
                                                        maxLines: 1,
                                                        style: MyFaysalTheme.of(
                                                                context)
                                                            .splashHeaderText
                                                            .override(
                                                                fontSize:
                                                                    size.width *
                                                                        0.07),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20.0),
                                                    child: Column(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child:
                                                              LinearProgressIndicator(
                                                            value: (double.parse(summary["present_total_savings"]
                                                                            .toString()) /
                                                                        double.parse(summary["rotating_savings_target"]
                                                                            .toString()) *
                                                                        1)
                                                                    .isNaN
                                                                ? 1
                                                                : (double.parse(
                                                                        summary["present_total_savings"]
                                                                            .toString()) /
                                                                    double.parse(
                                                                        summary["rotating_savings_target"]
                                                                            .toString()) *
                                                                    1),
                                                            minHeight: 7.5,
                                                            color: MyFaysalTheme
                                                                    .of(context)
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
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              AutoSizeText.rich(
                                                                TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          text:
                                                                              getCurrency(),
                                                                          style:
                                                                              const TextStyle(fontFamily: "Poppins")),
                                                                      TextSpan(
                                                                          text:
                                                                              NumberFormat().format(double.parse(summary["present_total_savings"].toString())))
                                                                    ]),
                                                                maxLines: 1,
                                                                style: MyFaysalTheme.of(
                                                                        context)
                                                                    .splashHeaderText
                                                                    .override(
                                                                        fontSize:
                                                                            12,
                                                                        color: MyFaysalTheme.of(context)
                                                                            .primaryText
                                                                            .withOpacity(0.3)),
                                                              ),
                                                              // Text(
                                                              //   "50 Hands",
                                                              //   style: MyFaysalTheme.of(
                                                              //           context)
                                                              //       .splashHeaderText
                                                              //       .override(
                                                              //           fontSize: 12,
                                                              //           color: MyFaysalTheme.of(
                                                              //                   context)
                                                              //               .primaryText
                                                              //               .withOpacity(
                                                              //                   0.3)),
                                                              // ),
                                                              AutoSizeText.rich(
                                                                TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          text:
                                                                              getCurrency(),
                                                                          style:
                                                                              const TextStyle(fontFamily: "Poppins")),
                                                                      TextSpan(
                                                                          text:
                                                                              NumberFormat().format(double.parse(summary["rotating_savings_target"].toString())))
                                                                    ]),
                                                                maxLines: 1,
                                                                style: MyFaysalTheme.of(
                                                                        context)
                                                                    .splashHeaderText
                                                                    .override(
                                                                        fontSize:
                                                                            12,
                                                                        color: MyFaysalTheme.of(context)
                                                                            .primaryText
                                                                            .withOpacity(0.3)),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            size.height * 0.04),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Ajo Target",
                                                          style: MyFaysalTheme
                                                                  .of(context)
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
                                                                constraints: BoxConstraints(
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
                                                                                NumberFormat().format(double.parse(summary["present_total_savings"].toString())))
                                                                      ]),
                                                                  maxLines: 1,
                                                                  style: MyFaysalTheme.of(
                                                                          context)
                                                                      .text1
                                                                      .override(
                                                                          fontSize:
                                                                              size.width * 0.05),
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
                                                                constraints: BoxConstraints(
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
                                                                                NumberFormat().format((double.parse(model!.amount) * model!.numberOfHand)))
                                                                      ]),
                                                                  maxLines: 1,
                                                                  style: MyFaysalTheme.of(
                                                                          context)
                                                                      .text1
                                                                      .override(
                                                                          fontSize:
                                                                              size.width * 0.05),
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
                                                                constraints: BoxConstraints(
                                                                    maxWidth:
                                                                        size.width *
                                                                            0.4),
                                                                child: Text(
                                                                    provider
                                                                        .frequency
                                                                        .where((element) =>
                                                                            element.id ==
                                                                            model!
                                                                                .frequencyId)
                                                                        .toList()
                                                                        .first
                                                                        .name,
                                                                    style: MyFaysalTheme.of(
                                                                            context)
                                                                        .text1
                                                                        .override(
                                                                            fontSize:
                                                                                size.width * 0.05)),
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
                                                                constraints: BoxConstraints(
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
                                                                                NumberFormat().format((double.parse(model!.coordinatorFee) * model!.numberOfHand)))
                                                                      ]),
                                                                  maxLines: 1,
                                                                  style: MyFaysalTheme.of(
                                                                          context)
                                                                      .text1
                                                                      .override(
                                                                          fontSize:
                                                                              size.width * 0.05),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.maxFinite,
                                          padding: const EdgeInsets.all(24),
                                          margin: const EdgeInsets.only(
                                              bottom: 20, top: 20),
                                          decoration: BoxDecoration(
                                              color: MyFaysalTheme.of(context)
                                                  .secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Coordinator Details",
                                                    style: MyFaysalTheme.of(
                                                            context)
                                                        .promtHeaderText
                                                        .override(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12.0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.longestSide *
                                                                  0.05,
                                                          height:
                                                              size.longestSide *
                                                                  0.05,
                                                          alignment:
                                                              Alignment.center,
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxHeight: 56,
                                                                  maxWidth: 56,
                                                                  minHeight: 40,
                                                                  minWidth: 40),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: MyFaysalTheme
                                                                      .of(context)
                                                                  .accentColor),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/svg/user.svg",
                                                            color: MyFaysalTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Name",
                                                                style: MyFaysalTheme.of(
                                                                        context)
                                                                    .promtHeaderText
                                                                    .override(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.042,
                                                                        color: MyFaysalTheme.of(context)
                                                                            .primaryText),
                                                              ),
                                                              Text(
                                                                model!
                                                                    .user.name,
                                                                style: MyFaysalTheme.of(context).text1.override(
                                                                    fontSize:
                                                                        size.width *
                                                                            0.03,
                                                                    lineHeight:
                                                                        1.5,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.5)),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12.0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.longestSide *
                                                                  0.05,
                                                          height:
                                                              size.longestSide *
                                                                  0.05,
                                                          alignment:
                                                              Alignment.center,
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxHeight: 56,
                                                                  maxWidth: 56,
                                                                  minHeight: 40,
                                                                  minWidth: 40),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: MyFaysalTheme
                                                                      .of(context)
                                                                  .accentColor),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/svg/user.svg",
                                                            color: MyFaysalTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Email",
                                                                style: MyFaysalTheme.of(
                                                                        context)
                                                                    .promtHeaderText
                                                                    .override(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.042,
                                                                        color: MyFaysalTheme.of(context)
                                                                            .primaryText),
                                                              ),
                                                              Text(
                                                                model!
                                                                    .user.email,
                                                                style: MyFaysalTheme.of(context).text1.override(
                                                                    fontSize:
                                                                        size.width *
                                                                            0.03,
                                                                    lineHeight:
                                                                        1.5,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.5)),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12.0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.longestSide *
                                                                  0.05,
                                                          height:
                                                              size.longestSide *
                                                                  0.05,
                                                          alignment:
                                                              Alignment.center,
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxHeight: 56,
                                                                  maxWidth: 56,
                                                                  minHeight: 40,
                                                                  minWidth: 40),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: MyFaysalTheme
                                                                      .of(context)
                                                                  .accentColor),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/svg/user.svg",
                                                            color: MyFaysalTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Phone Number",
                                                                style: MyFaysalTheme.of(
                                                                        context)
                                                                    .promtHeaderText
                                                                    .override(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.042,
                                                                        color: MyFaysalTheme.of(context)
                                                                            .primaryText),
                                                              ),
                                                              Text(
                                                                model!
                                                                    .user.phone,
                                                                style: MyFaysalTheme.of(context).text1.override(
                                                                    fontSize:
                                                                        size.width *
                                                                            0.03,
                                                                    lineHeight:
                                                                        1.5,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.5)),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )))
                        ])))),
      ),
    );
  }

  navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SuccessfulSavingsCreation(
                header: "Successfully joined Ajo",
                message: "You are now a member and can save to Loop Ajo",
                call: DynamicLinkHandler().fromLogin
                                ? () {
                                    Navigator.pushReplacementNamed(
                                        context, '/ajo');
                                  }
                                : null,
              )),
    );
  }
}
