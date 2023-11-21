// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:faysal/models/ajo_member_model.dart';
import 'package:faysal/models/disbursement_history_model.dart';
import 'package:faysal/models/rotational_savings.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/pages/rotating_savings/creation/successful_creation.dart';
import 'package:faysal/pages/rotating_savings/widget/user_info_dialog.dart';

import 'package:faysal/provider/savings_provider.dart';
import 'package:faysal/utils/constants.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AjoMembers extends StatefulWidget {
  final List<MemberModel> model;
  final RotationalSavingsModel ajoName;
  final bool isCreator;

  const AjoMembers(
      {super.key,
      required this.model,
      required this.ajoName,
      required this.isCreator});

  @override
  State<AjoMembers> createState() => _AjoMembersState();
}

class _AjoMembersState extends State<AjoMembers> {
  late SavingsProvider provider;
  bool isLoading = false;
  bool starting = false;
  bool contribute = false;
  List<DisbursementHistoryModel> disbursementHistory = [];

  @override
  void initState() {
    provider = Provider.of<SavingsProvider>(context, listen: false);
    provider.members = [];
    // getData();
    super.initState();
  }

  // getData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   // await provider.getAjoMembers(widget.savings.ajo.id);
  //   // var response = await GetRotationalSavingsRequest.getDisbursementHistory(
  //   //     widget.savings.ajo.id);

  //   // disbursementHistory = (response["data"]["disbursementHisoty"] as List)
  //   //     .map((e) => DisbursementHistoryModel.fromJson(e))
  //   //     .toList();
  //   if (mounted) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
        body: isLoading
            ? const LoadingScreen()
            : Consumer<SavingsProvider>(
                builder: (context, savingsProvider, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
                  child: WidgetBackgorund(
                      home: true,
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
                                                  widget.ajoName.name,
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
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: double.maxFinite,
                                                    margin: const EdgeInsets.only(
                                                        top: 15, bottom: 15),
                                                    padding: const EdgeInsets
                                                            .symmetric(
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
                                                            child: AutoSizeText(
                                                                "Members",
                                                                style: MyFaysalTheme
                                                                        .of(context)
                                                                    .splashHeaderText
                                                                    .override(
                                                                      fontSize:
                                                                          size.width *
                                                                              0.037,
                                                                    )),
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
                                                                          width: size.width *
                                                                              0.27,
                                                                          color: MyFaysalTheme.of(context)
                                                                              .primaryColor,
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding:
                                                                                  const EdgeInsets.only(top: 10.0, bottom: 5),
                                                                              child:
                                                                                  Text(
                                                                                "Oops, Nothing here :(",
                                                                                style: MyFaysalTheme.of(context).splashHeaderText.override(fontSize: size.width * 0.045),
                                                                              ),
                                                                            ),
                                                                            ConstrainedBox(
                                                                                constraints: BoxConstraints(maxWidth: size.width * 0.55),
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
                                                                  children: List
                                                                      .generate(
                                                                          provider.allAjoMemebers.length <
                                                                                  4
                                                                              ? provider
                                                                                  .allAjoMemebers.length
                                                                              : 4,
                                                                          (index) {
                                                                            return Padding(
                                                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                                                child: GestureDetector(
                                                                                  onTap: () async {
                                                                                    var response = await showDialog(
                                                                                        context: context,
                                                                                        builder: (context) => BackdropFilter(
                                                                                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                                                                              child: Dialog(
                                                                                                insetPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                                                                                                backgroundColor: Colors.transparent,
                                                                                                child: MemberInfo(
                                                                                                  model: widget.model[index],
                                                                                                  isCordinator: widget.isCreator,
                                                                                                  ajoId: widget.ajoName.id,
                                                                                                ),
                                                                                              ),
                                                                                            ));

                                                                                            if(response !=null && response){
                                                                                              widget.model[index].membership = "approved";
                                                                                            }
                                                                                            if(response !=null && !response){
                                                                                              widget.model[index].membership = "rejected";
                                                                                            }
                                                                                            setState(() {
                                                                                              
                                                                                            });
                                                                                  },
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Container(
                                                                                            width: size.width * 0.22 < 30
                                                                                                ? 30
                                                                                                : size.width * 0.22 > 50
                                                                                                    ? 50
                                                                                                    : size.width * 0.22,
                                                                                            height: size.width * 0.18,
                                                                                            decoration: BoxDecoration(shape: BoxShape.circle, 
                                                                                            image: widget.model[index].userData.avatar.isEmpty? DecorationImage(
                                  image: AssetImage("assets/avatar/avatar${generateAvatar(widget.model[index].userData.id.toString())}.png")):DecorationImage(
                                  image: CachedNetworkImageProvider("$imageUrl/${widget.model[index].userData.avatar}",) )
                                                                                           ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(left: 8.0),
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                ConstrainedBox(
                                                                                                  constraints: BoxConstraints(maxWidth: size.width * 0.4),
                                                                                                  child: Text(
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    widget.model[index].userData.name.capitalize(" "),
                                                                                                    style: MyFaysalTheme.of(context).promtHeaderText.override(color: Colors.white, fontSize: size.width * 0.033),
                                                                                                  ),
                                                                                                ),
                                                                                                ConstrainedBox(
                                                                                                  constraints: BoxConstraints(maxWidth: size.width * 0.4),
                                                                                                  child: Text(
                                                                                                    widget.model[index].userData.email,
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    style: MyFaysalTheme.of(context).text1.override(color: Colors.white.withOpacity(0.6), fontSize: size.width * 0.033, lineHeight: 1.6),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      Container(
                                                                                        width: size.width * 0.15,
                                                                                        padding: const EdgeInsets.all(2),
                                                                                        height: 15,
                                                                                        decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(5),
                                                                                            color: widget.ajoName.user.email == widget.model[index].userData.email
                                                                                                ? const Color(0xffE86B35)
                                                                                                : widget.model[index].membership.toLowerCase() == "request"
                                                                                                    ? const Color.fromARGB(255, 177, 139, 1)
                                                                                                    : const Color.fromARGB(255, 0, 47, 26)),
                                                                                        child: FittedBox(
                                                                                            child: Text(
                                                                                          widget.ajoName.user.email == widget.model[index].userData.email ? "Owner" : widget.model[index].membership,
                                                                                          style: MyFaysalTheme.of(context).splashHeaderText,
                                                                                        )),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                          }),
                                                                )
                                                        ])),
                                              ])
                                        ],
                                      ),
                                    )))
                          ]))),
                );
              }));
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
