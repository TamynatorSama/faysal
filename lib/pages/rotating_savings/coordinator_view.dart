// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/main.dart';
import 'package:faysal/models/rotational_savings.dart';
import 'package:faysal/pages/rotating_savings/ajo_members.dart';
import 'package:faysal/pages/rotating_savings/creation/successful_creation.dart';
import 'package:faysal/pages/rotating_savings/join_savings/widget/ajo_info_holder.dart';
import 'package:faysal/pages/rotating_savings/requests/get_savings_request.dart';

import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/dynamic_links.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SavingsCoordinatorView extends StatefulWidget {
  final RotationalSavingsModel savings;

  const SavingsCoordinatorView({super.key, required this.savings});

  @override
  State<SavingsCoordinatorView> createState() => _SavingsCoordinatorViewState();
}

class _SavingsCoordinatorViewState extends State<SavingsCoordinatorView> {
  late SavingsProvider provider;
  bool isLoading = false;
  bool delete = false;
  bool starting = false;
  dynamic summary = {};
  bool contribute = false;

  @override
  void initState() {
    provider = Provider.of<SavingsProvider>(context, listen: false);
    provider.members = [];
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    var summaryResponse = await GetRotationalSavingsRequest()
        .getMyRotationalSavingsSumarry(widget.savings.id.toString());
        summary = summaryResponse["data"];
        // print(summary);
    await provider.getAjoMembers(widget.savings.id);
    // print("member");
    await GetRotationalSavingsRequest.getDisbursementHistory(
        widget.savings.id);
        // print("non");

    if (mounted) {
      setState(() {
        isLoading = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
      child: Scaffold(
          backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
          body: isLoading
              ? const LoadingScreen()
              : Consumer<SavingsProvider>(
                  builder: (context, savingsProvider, child) {
                    // print((DateTime.parse(widget.savings.startedAt).difference(DateTime.now()).inDays/(DateTime.parse(widget.savings.startedAt).difference(DateTime.parse(widget.savings.createdAt)).inDays)));
                  return WidgetBackgorund(
                      home: true,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Column(children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top < 30
                                      ? MediaQuery.of(context).size.height < 600
                                          ? 10
                                          : MediaQuery.of(context).size.height *
                                              0.05
                                      : MediaQuery.of(context).padding.top),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      splashColor: MyFaysalTheme.of(context)
                                          .scaffolbackgeroundColor,
                                      hoverColor: MyFaysalTheme.of(context)
                                          .scaffolbackgeroundColor,
                                      highlightColor: MyFaysalTheme.of(context)
                                          .scaffolbackgeroundColor,
                                      // splashColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                        color: Colors.white,
                                        size: MediaQuery.of(context).size.width *
                                            0.045,
                                      )),
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth:
                                              MediaQuery.of(context).size.width *
                                                  0.7),
                                      child: AutoSizeText(
                                        "Rotating Savings",
                                        style: MyFaysalTheme.of(context)
                                            .splashHeaderText
                                            .override(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.058),
                                      )),
                                  PopupMenuButton(
                                      color: MyFaysalTheme.of(context)
                                          .secondaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      onSelected: (value) async {
                                        if (value == Actions.delete) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await provider.deleteAjo(
                                              widget.savings.id,
                                              context,
                                              widget.savings);
                                          // if (result) {
                                            
                                          // }
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pop(MyApp.navigationKey.currentContext!);
                                        } else {
                                          String link = await DynamicLinkHandler().createLinkAjo(widget.savings.ajoCode);
                                          FlutterShare.share(title: "${widget.savings.user.name} invites you to join ${widget.savings.name} rotational savings on faysal",linkUrl: link);
                                        }
                                      },
                                      padding: const EdgeInsets.all(0),
                                      position: PopupMenuPosition.under,
                                      icon: SvgPicture.string(
                                        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="1"></circle><circle cx="12" cy="5" r="1"></circle><circle cx="12" cy="19" r="1"></circle></svg>',
                                        color:
                                            MyFaysalTheme.of(context).primaryText,
                                      ),
                                      itemBuilder: ((context) =>
                                          [...popupItems(context)])),
                                ],
                              ),
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
                                                  widget.savings.name,
                                                  maxLines: 1,
                                                  style: MyFaysalTheme.of(context)
                                                      .splashHeaderText
                                                      .override(
                                                          fontSize: 20,
                                                          lineHeight: 2),
                                                ),
                                              ),
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
                                                    value:
                                                        widget.savings.ajoCode),
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
                                              widget.savings.userId ==
                                                          Provider.of<ProfileProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .userProfile
                                                              .id &&
                                                      widget.savings.isActive == 1
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
                                                                    widget.savings
                                                                        .id,
                                                                    context);
                                                        if (result) {
                                                          widget.savings
                                                              .isActive = 2;
                                                        }
                                                        setState(() {
                                                          starting = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: double.maxFinite,
                                                        height: 50,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 30),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                MyFaysalTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8)),
                                                        child: starting
                                                            ? ConstrainedBox(
                                                                constraints:
                                                                    const BoxConstraints(
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
                                                                style: MyFaysalTheme
                                                                        .of(
                                                                            context)
                                                                    .promtHeaderText
                                                                    .override(
                                                                        color: MyFaysalTheme.of(
                                                                                context)
                                                                            .secondaryColor,
                                                                        fontSize:
                                                                            18),
                                                              ),
                                                      ),
                                                    ))
                                                  : const Offstage(),
                                            ],
                                          ),
                                          Container(
                                            width: double.maxFinite,
                                            padding: const EdgeInsets.all(24),
                                            decoration: BoxDecoration(
                                                color: MyFaysalTheme.of(context)
                                                    .secondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            margin: EdgeInsets.only(
                                                top: widget.savings.userId ==
                                                            Provider.of<ProfileProvider>(
                                                                    context,
                                                                    listen: false)
                                                                .userProfile
                                                                .id &&
                                                        widget.savings
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
                                                      CrossAxisAlignment.start,
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
                                                              style: MyFaysalTheme
                                                                      .of(context)
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
                                                                      top: 5.0),
                                                              child:
                                                                  ConstrainedBox(
                                                                constraints:
                                                                    BoxConstraints(
                                                                        maxWidth:
                                                                            size.width *
                                                                                0.4),
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
                                                                            text: NumberFormat().format(double.parse(summary["rotating_savings_target"].toString())))
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
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(5),
                                                            child:
                                                                LinearProgressIndicator(
                                                              value: (double.parse(summary["present_total_savings"].toString()) / double.parse(summary["rotating_savings_target"].toString())*1).isNaN ? 1:(double.parse(summary["present_total_savings"].toString()) / double.parse(summary["rotating_savings_target"].toString())*1),
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
                                                            child: AutoSizeText
                                                                        .rich(
                                                                  TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                                " ${ (double.parse(summary["present_total_savings"].toString()) / double.parse(summary["rotating_savings_target"].toString())*100).isNaN ? "0":(double.parse(summary["present_total_savings"].toString()) / double.parse(summary["rotating_savings_target"].toString())*100).toString()}% saved of ",
                                                                        ),
                                                                        TextSpan(
                                                                            text:
                                                                                getCurrency(),
                                                                            style:
                                                                                const TextStyle(fontFamily: "Poppins")),
                                                                        TextSpan(
                                                                            text: "${NumberFormat().format(double.parse(summary["rotating_savings_target"].toString()) )} target"
                                                                            )
                                                                      ]),
                                                                      style: MyFaysalTheme
                                                                      .of(context)
                                                                  .splashHeaderText
                                                                  .override(
                                                                    fontSize: 12,
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
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 25, horizontal: 15),
                                              decoration: BoxDecoration(
                                                  color: MyFaysalTheme.of(context)
                                                      .secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 22),
                                                  child: InkWell(
                                                     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AjoMembers(model: provider.allAjoMemebers,ajoName: widget.savings,isCreator: true,))),
                                                    child: Row(
                                                      children: [
                                                        AutoSizeText("Members",
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
                                                                .only(left: 10),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            decoration:
                                                                const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0xff64857D)),
                                                            child: const FittedBox(
                                                                child: Icon(Icons
                                                                    .arrow_forward_ios_rounded)))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                provider.allAjoMemebers.isEmpty
                                                    ? Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 20.0),
                                                          child: Column(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/svg/empty.svg",
                                                                width:
                                                                    size.width *
                                                                        0.27,
                                                                color: MyFaysalTheme
                                                                        .of(context)
                                                                    .primaryColor,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 10.0,
                                                                        bottom:
                                                                            5),
                                                                    child: Text(
                                                                      "Oops, Nothing here :(",
                                                                      style: MyFaysalTheme.of(
                                                                              context)
                                                                          .splashHeaderText
                                                                          .override(
                                                                              fontSize:
                                                                                  size.width * 0.05),
                                                                    ),
                                                                  ),
                                                                  ConstrainedBox(
                                                                      constraints:
                                                                          BoxConstraints(
                                                                              maxWidth:
                                                                                  size.width * 0.55),
                                                                      child: Text(
                                                                        "There seems to be no community savings at the moment",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: MyFaysalTheme.of(context).text1.override(
                                                                            fontSize: size.width *
                                                                                0.033,
                                                                            color: Colors
                                                                                .white
                                                                                .withOpacity(0.3)),
                                                                      )),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Wrap(
                                                      spacing: size.width * 0.03,
                                                        children: List.generate(
                                                            provider.allAjoMemebers
                                                                        .length <
                                                                    4
                                                                ? provider
                                                                    .allAjoMemebers
                                                                    .length
                                                                : 4,
                                                                
                                                            (index) => Column(
                                                                  children: [
                                                                    Container(
                                                                      width: size.width *
                                                                                  0.22 <
                                                                              30
                                                                          ? 30
                                                                          : size.width * 0.22 >
                                                                                  60
                                                                              ? 60
                                                                              : size.width *
                                                                                  0.22,
                                                                      height: size
                                                                              .width *
                                                                          0.18,
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image: DecorationImage(
                                                                              image:
                                                                                  AssetImage("assets/avatar/avatar${generateAvatar(provider.allAjoMemebers[index].id)}.png"))),
                                                                    ),
                                                                    Text(
                                                                      provider
                                                                          .allAjoMemebers[
                                                                              index]
                                                                          .userData
                                                                          .name
                                                                          .split(
                                                                              " ")
                                                                          .first
                                                                          .capitalize(),
                                                                      style: MyFaysalTheme.of(
                                                                              context)
                                                                          .promtHeaderText
                                                                          .override(
                                                                              color:
                                                                                  Colors.white,
                                                                              fontSize: size.width * 0.033),
                                                                    )
                                                                  ],
                                                                )),
                                                      )
                                              ])),
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
                                                      "Ajo Details",
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
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Amount accumulated",
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .text1
                                                                .override(
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
                                                                AutoSizeText.rich(
                                                              TextSpan(children: [
                                                                TextSpan(
                                                                    text:
                                                                        getCurrency(),
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            "Poppins")),
                                                                TextSpan(
                                                                    text: NumberFormat().format((double.parse(widget
                                                                            .savings
                                                                            .amount) *
                                                                        widget
                                                                            .savings
                                                                            .numberOfHand)))
                                                              ]),
                                                              maxLines: 1,
                                                              style: MyFaysalTheme
                                                                      .of(context)
                                                                  .text1
                                                                  .override(
                                                                      fontSize:
                                                                          size.width *
                                                                              0.04),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Saving Amount",
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .text1
                                                                .override(
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
                                                                AutoSizeText.rich(
                                                              TextSpan(children: [
                                                                TextSpan(
                                                                    text:
                                                                        getCurrency(),
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            "Poppins")),
                                                                TextSpan(
                                                                    text: NumberFormat().format((double.parse(widget
                                                                            .savings
                                                                            .amount) *
                                                                        widget
                                                                            .savings
                                                                            .numberOfHand)))
                                                              ]),
                                                              maxLines: 1,
                                                              style: MyFaysalTheme
                                                                      .of(context)
                                                                  .text1
                                                                  .override(
                                                                      fontSize:
                                                                          size.width *
                                                                              0.04),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Frequency",
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .text1
                                                                .override(
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
                                                                            .frequencyId)
                                                                    .toList()
                                                                    .first
                                                                    .name,
                                                                style: MyFaysalTheme
                                                                        .of(
                                                                            context)
                                                                    .text1
                                                                    .override(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.04)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Coordinator Fee",
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .text1
                                                                .override(
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
                                                                AutoSizeText.rich(
                                                              TextSpan(children: [
                                                                TextSpan(
                                                                    text:
                                                                        getCurrency(),
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            "Poppins")),
                                                                TextSpan(
                                                                    text: NumberFormat().format((double.parse(widget
                                                                            .savings
                                                                            .coordinatorFee) *
                                                                        widget
                                                                            .savings
                                                                            .numberOfHand)))
                                                              ]),
                                                              maxLines: 1,
                                                              style: MyFaysalTheme
                                                                      .of(context)
                                                                  .text1
                                                                  .override(
                                                                      fontSize:
                                                                          size.width *
                                                                              0.04),
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
                                          GestureDetector(
                                          onTap: () async {
                                            if (delete) return;
                                            setState(() {
                                            delete = true;
                                          });
                                          await provider.deleteAjo(
                                              widget.savings.id,
                                              context,
                                              widget.savings);
                                              Navigator.pop(context);
                                          // if (result) {
                                            
                                          // }
                                          setState(() {
                                            delete = false;
                                          });
                                          },
                                          child: Container(
                                            alignment:
                                                Alignment.center,
                                            width: double.maxFinite,
                                            height: 50,
                                            margin: const EdgeInsets
                                                    .symmetric(
                                                vertical: 30),
                                            decoration: BoxDecoration(
                                                color:
                                                    MyFaysalTheme.of(
                                                            context)
                                                        .accentColor,
                                                borderRadius:
                                                    BorderRadius
                                                        .circular(8)),
                                            child: delete
                                                ? ConstrainedBox(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxHeight:
                                                                23,
                                                            maxWidth:
                                                                23),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: MyFaysalTheme.of(
                                                              context)
                                                          .primaryText,
                                                    ),
                                                  )
                                                : Text(
                                                    "Delete Ajo",
                                                    style: MyFaysalTheme
                                                            .of(
                                                                context)
                                                        .promtHeaderText
                                                        .override(
                                                            color: MyFaysalTheme.of(
                                                                    context)
                                                                .primaryText,
                                                            fontSize:
                                                                18),
                                                  ),
                                          ),
                                                    )
                                                  
                                        ],
                                      ),
                                    )))
                          ])));
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

List<PopupMenuItem> popupItems(BuildContext context) {
  return [
    PopupMenuItem(
        value: Actions.share,
        child: Row(
          children: [
            SvgPicture.string(
              '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="18" cy="5" r="3"></circle><circle cx="6" cy="12" r="3"></circle><circle cx="18" cy="19" r="3"></circle><line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line><line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line></svg>',
              color: MyFaysalTheme.of(context).primaryText,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                "Share Code",
                style: MyFaysalTheme.of(context)
                    .splashHeaderText
                    .override(fontSize: 14),
              ),
            ),
          ],
        )),

    // PopupMenuItem(
    //     value: Actions.delete,
    //     child: Row(
    //       children: [
    //         SvgPicture.string(
    //           '<svg width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6.25 2.66732V1.75065C6.25 1.50754 6.34658 1.27438 6.51849 1.10247C6.69039 0.930561 6.92355 0.833984 7.16667 0.833984H10.8333C11.0764 0.833984 11.3096 0.930561 11.4815 1.10247C11.6534 1.27438 11.75 1.50754 11.75 1.75065V2.66732H15.4167C15.9029 2.66732 16.3692 2.86047 16.713 3.20429C17.0568 3.54811 17.25 4.01442 17.25 4.50065V5.41732C17.25 5.90355 17.0568 6.36986 16.713 6.71368C16.3692 7.0575 15.9029 7.25065 15.4167 7.25065H15.2948L14.6714 16.6007C14.6249 17.2967 14.3156 17.949 13.8063 18.4255C13.2969 18.9021 12.6254 19.1672 11.9278 19.1673H6.0905C5.39353 19.1673 4.72257 18.9027 4.21327 18.4269C3.70396 17.9511 3.39431 17.2997 3.34692 16.6043L2.70892 7.25065H2.58333C2.0971 7.25065 1.63079 7.0575 1.28697 6.71368C0.943154 6.36986 0.75 5.90355 0.75 5.41732V4.50065C0.75 4.01442 0.943154 3.54811 1.28697 3.20429C1.63079 2.86047 2.0971 2.66732 2.58333 2.66732H6.25ZM15.4167 4.50065H2.58333V5.41732H15.4167V4.50065ZM4.54592 7.25065L5.17567 16.4797C5.19147 16.7115 5.29473 16.9287 5.46456 17.0873C5.6344 17.2459 5.85813 17.3341 6.0905 17.334H11.9278C12.1605 17.334 12.3845 17.2456 12.5544 17.0866C12.7242 16.9276 12.8273 16.71 12.8427 16.4778L13.4568 7.25065H4.54683H4.54592ZM7.16667 8.16732C7.40978 8.16732 7.64294 8.26389 7.81485 8.4358C7.98676 8.60771 8.08333 8.84087 8.08333 9.08398V15.5007C8.08333 15.7438 7.98676 15.9769 7.81485 16.1488C7.64294 16.3207 7.40978 16.4173 7.16667 16.4173C6.92355 16.4173 6.69039 16.3207 6.51849 16.1488C6.34658 15.9769 6.25 15.7438 6.25 15.5007V9.08398C6.25 8.84087 6.34658 8.60771 6.51849 8.4358C6.69039 8.26389 6.92355 8.16732 7.16667 8.16732ZM10.8333 8.16732C11.0764 8.16732 11.3096 8.26389 11.4815 8.4358C11.6534 8.60771 11.75 8.84087 11.75 9.08398V15.5007C11.75 15.7438 11.6534 15.9769 11.4815 16.1488C11.3096 16.3207 11.0764 16.4173 10.8333 16.4173C10.5902 16.4173 10.3571 16.3207 10.1852 16.1488C10.0132 15.9769 9.91667 15.7438 9.91667 15.5007V9.08398C9.91667 8.84087 10.0132 8.60771 10.1852 8.4358C10.3571 8.26389 10.5902 8.16732 10.8333 8.16732Z" fill="white"/></svg>',
    //           color: MyFaysalTheme.of(context).primaryText,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 12.0),
    //           child: Text(
    //             "Delete Savings",
    //             style: MyFaysalTheme.of(context)
    //                 .splashHeaderText
    //                 .override(fontSize: 14),
    //           ),
    //         ),
    //       ],
    //     )),
  
  ];
}

enum Actions { share, edit, delete }
