import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/pages/history/history.dart';
import 'package:faysal/pages/home/widgets/action_widget.dart';
import 'package:faysal/pages/transfer/transfer_main.dart';
import 'package:faysal/provider/bills_provider.dart';
import 'package:faysal/provider/history_provider.dart';
import 'package:faysal/provider/profile_provider.dart';
import 'package:faysal/provider/recharge_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faysal/provider/trasfer_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/pages/home/widgets/notification_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _balanceController;
  int page = 0;

  @override
  void initState() {
    _balanceController = PageController(keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).copyWith(textScaleFactor: 1.2).size;
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      return Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top < 30
                ? size.height * 0.1 > 70
                    ? 70
                    : size.height * 0.1
                : MediaQuery.of(context).padding.top + 20,
            left: 24,
            right: 24),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "Welcome Back",
                  style: MyFaysalTheme.of(context)
                      .splashHeaderText
                      .override(fontSize: size.width > 600 ?size.width *0.035:16),
                ),
                Text(
                  provider.userProfile.name.capitalize(" ").split(" ").first,
                  style: MyFaysalTheme.of(context)
                      .splashHeaderText
                      .override(lineHeight: 1.3),
                ),
                Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: size.width > 600 ? size.height *0.17:  110,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width < 327 ? 15 : 25),
                      margin: const EdgeInsets.only(top: 40, bottom: 30),
                      decoration: BoxDecoration(
                        color: MyFaysalTheme.of(context).secondaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: PageView(
                        controller: _balanceController,
                        onPageChanged: (controlledPage){
                          page = controlledPage;
                          setState(() {
                            
                          });

                          
                        },
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    "Available balance",
                                    maxLines: 1,
                                    style: MyFaysalTheme.of(context).text1.override(fontSize: size.width > 600 ?size.width *0.03:null),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.008),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: size.width * 0.5),
                                      child: AutoSizeText(
                                        "${getCurrency()}${NumberFormat().format(provider.userProfile.balance)}",
                                        maxLines: 1,
                                        style: MyFaysalTheme.of(context)
                                            .splashHeaderText
                                            .override(fontFamily: "Poppins",fontSize: size.width > 600 ?size.width *0.05:null),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Provider.of<TransferProvider>(context,
                                              listen: false)
                                          .populateBank(true);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TransferMain()));
                                    },
                                    child: Container(
                                      width: size.width * 0.1,
                                      height: size.width * 0.1,
                                      padding:
                                          EdgeInsets.all(size.width * 0.02),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: MyFaysalTheme.of(context)
                                              .primaryColor),
                                      child: SvgPicture.string(
                                        '<svg width="14" height="15" viewBox="0 0 14 15" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M11.0291 4.25667L6.56369 8.72209C6.69611 8.91167 6.80869 9.11642 6.89911 9.33342L8.01328 12.0162L11.0291 4.25609V4.25667ZM5.77794 7.93634L10.2439 3.47034L2.48386 6.48617L5.16661 7.60092C5.38195 7.69022 5.58693 7.80269 5.77794 7.93634ZM12.5551 3.35017L9.03936 12.3953C8.81769 12.967 8.17778 13.2604 7.61078 13.051C7.47266 13 7.34659 12.9209 7.24048 12.8188C7.13438 12.7167 7.05052 12.5938 6.99419 12.4578L5.88003 9.775C5.66324 9.2522 5.24783 8.83679 4.72503 8.62L2.04169 7.50584C1.48519 7.27425 1.23086 6.63084 1.47469 6.06734C1.53448 5.92965 1.62093 5.80515 1.72906 5.70103C1.83718 5.59691 1.96485 5.51522 2.10469 5.46067L11.1499 1.94375C11.3464 1.86455 11.5619 1.84489 11.7695 1.88723C11.9771 1.92957 12.1677 2.03203 12.3176 2.18187C12.4674 2.33171 12.5699 2.5223 12.6122 2.72992C12.6546 2.93755 12.6349 3.15305 12.5557 3.34959L12.5551 3.35017Z" fill="black"/></svg>',
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => showTopupWalletDialog(),
                                    child: Container(
                                      width: size.width * 0.1,
                                      height: size.width * 0.1,
                                      margin: const EdgeInsets.only(left: 10),
                                      padding:
                                          EdgeInsets.all(size.width * 0.03),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: MyFaysalTheme.of(context)
                                              .primaryColor),
                                      child: SvgPicture.asset(
                                          "assets/svg/Vector.svg"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Provider.of<TransferProvider>(context,
                                              listen: false)
                                          .populateBank(true);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TransferMain()));
                                    },
                                    child: Container(
                                      width: size.width * 0.1,
                                      height: size.width * 0.1,
                                      padding:
                                          EdgeInsets.all(size.width * 0.02),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: MyFaysalTheme.of(context)
                                              .primaryColor),
                                      child: SvgPicture.string(
                                        '<svg width="14" height="15" viewBox="0 0 14 15" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M11.0291 4.25667L6.56369 8.72209C6.69611 8.91167 6.80869 9.11642 6.89911 9.33342L8.01328 12.0162L11.0291 4.25609V4.25667ZM5.77794 7.93634L10.2439 3.47034L2.48386 6.48617L5.16661 7.60092C5.38195 7.69022 5.58693 7.80269 5.77794 7.93634ZM12.5551 3.35017L9.03936 12.3953C8.81769 12.967 8.17778 13.2604 7.61078 13.051C7.47266 13 7.34659 12.9209 7.24048 12.8188C7.13438 12.7167 7.05052 12.5938 6.99419 12.4578L5.88003 9.775C5.66324 9.2522 5.24783 8.83679 4.72503 8.62L2.04169 7.50584C1.48519 7.27425 1.23086 6.63084 1.47469 6.06734C1.53448 5.92965 1.62093 5.80515 1.72906 5.70103C1.83718 5.59691 1.96485 5.51522 2.10469 5.46067L11.1499 1.94375C11.3464 1.86455 11.5619 1.84489 11.7695 1.88723C11.9771 1.92957 12.1677 2.03203 12.3176 2.18187C12.4674 2.33171 12.5699 2.5223 12.6122 2.72992C12.6546 2.93755 12.6349 3.15305 12.5557 3.34959L12.5551 3.35017Z" fill="black"/></svg>',
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => showTopupWalletDialog(),
                                    child: Container(
                                      width: size.width * 0.1,
                                      height: size.width * 0.1,
                                      margin: const EdgeInsets.only(left: 10),
                                      padding:
                                          EdgeInsets.all(size.width * 0.03),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: MyFaysalTheme.of(context)
                                              .primaryColor),
                                      child: SvgPicture.asset(
                                          "assets/svg/Vector.svg"),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    "Rotational Savings",
                                    maxLines: 1,
                                    style: MyFaysalTheme.of(context).text1,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.008),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: size.width * 0.5),
                                      child: AutoSizeText(
                                        "${getCurrency()}${NumberFormat().format(provider.userProfile.ajoBalance)}",
                                        maxLines: 1,
                                        style: MyFaysalTheme.of(context)
                                            .splashHeaderText
                                            .override(fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 35,
                      right:1,
                      // left: page == 1?1:null,
                      child: InkWell(
                        onTap: () {
                          if (_balanceController.page == 0) {
                            _balanceController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          } else {
                            _balanceController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          }
                        },
                        child: Container(
                            width: size.width * 0.06,
                            height: size.width * 0.06,
                            padding: EdgeInsets.all(size.width * 0.01),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyFaysalTheme.of(context).primaryColor),
                            child: FittedBox(
                                child: Icon(
                              page == 0
                                  ? Icons.arrow_forward_ios_rounded
                                  : Icons.arrow_back_ios_new_rounded,
                              color: MyFaysalTheme.of(context).secondaryColor,
                            ))),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<BillProivder>(context, listen: false).getAllVariations(context);
                        showBillDialog();
                      },
                      child: Column(
                        children: [
                          Container(
                            width: size.longestSide * 0.065,
                            height: size.longestSide * 0.065,
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                                maxHeight: 56,
                                maxWidth: 56,
                                minHeight: 40,
                                minWidth: 40),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color:
                                    MyFaysalTheme.of(context).secondaryColor),
                            child: Icon(Icons.credit_card,
                                color: MyFaysalTheme.of(context).primaryText,
                                size: size.longestSide * 0.04 > 32
                                    ? 26
                                    : size.longestSide * 0.04 < 24
                                        ? 23
                                        : size.longestSide * 0.04),
                          ),
                          // images/Transfer.svg
                          Text("Bills",
                              style: MyFaysalTheme.of(context)
                                  .text1
                                  .override(lineHeight: 2)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/ajo'),
                      child: Column(
                        children: [
                          Container(
                              width: size.longestSide * 0.062,
                              height: size.longestSide * 0.062,
                              constraints: const BoxConstraints(
                                  maxHeight: 56,
                                  maxWidth: 70,
                                  minHeight: 40,
                                  minWidth: 40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color:
                                      MyFaysalTheme.of(context).secondaryColor),
                              child: Icon(Icons.lock,
                                  color: MyFaysalTheme.of(context).primaryText,
                                  size: size.longestSide * 0.04 > 32
                                      ? 26
                                      : size.longestSide * 0.04 < 24
                                          ? 23
                                          : size.longestSide * 0.04)),
                          SizedBox(
                            width: 58,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: FittedBox(
                                child: Text("Rotating \nsavings",
                                    textAlign: TextAlign.center,
                                    style: MyFaysalTheme.of(context)
                                        .text1
                                        .override(
                                            fontSize: size.width * 0.033 > 15
                                                ? 15
                                                : size.width * 0.033)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const HistoryWidget(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Column(
                        children: [
                          Container(
                              width: size.longestSide * 0.062,
                              height: size.longestSide * 0.062,
                              constraints: const BoxConstraints(
                                  maxHeight: 56,
                                  maxWidth: 56,
                                  minHeight: 40,
                                  minWidth: 40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color:
                                      MyFaysalTheme.of(context).secondaryColor),
                              child: Icon(Icons.history_rounded,
                                  color: MyFaysalTheme.of(context).primaryText,
                                  size: size.longestSide * 0.04 > 32
                                      ? 26
                                      : size.longestSide * 0.04 < 24
                                          ? 23
                                          : size.longestSide * 0.04)
                              // Icons.sync_alt_outlined
                              ),
                          Text("History",
                              style: MyFaysalTheme.of(context)
                                  .text1
                                  .override(lineHeight: 2)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<RechargeProvider>(context, listen: false).getAllVariations(context,true);
                        showTopupDialog();
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> const Airtime()));
                      },
                      child: Column(
                        children: [
                          Container(
                              width: size.longestSide * 0.062,
                              height: size.longestSide * 0.062,
                              constraints: const BoxConstraints(
                                  maxHeight: 56,
                                  maxWidth: 56,
                                  minHeight: 40,
                                  minWidth: 40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color:
                                      MyFaysalTheme.of(context).secondaryColor),
                              child: Icon(Icons.phone_iphone,
                                  color: MyFaysalTheme.of(context).primaryText,
                                  size: size.longestSide * 0.04 > 32
                                      ? 26
                                      : size.longestSide * 0.04 < 24
                                          ? 23
                                          : size.longestSide * 0.04)),
                          Text("Airtime",
                              style: MyFaysalTheme.of(context)
                                  .text1
                                  .override(lineHeight: 2)),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04 > 20
                          ? 20
                          : MediaQuery.of(context).size.width * 0.04,
                      vertical: MediaQuery.of(context).size.height * 0.5 > 20
                          ? 20
                          : MediaQuery.of(context).size.height * 0.05),
                  margin: const EdgeInsets.fromLTRB(0, 30.0, 0, 80.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyFaysalTheme.of(context).secondaryColor,
                  ),
                  child: Column(
                    children: [
                      Consumer<HistoryProvider>(
                          builder: (context, history, child) {
                        if (history.notification.isEmpty &&
                            history.history.isEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Recent activities",
                                  style: MyFaysalTheme.of(context)
                                      .splashHeaderText
                                      .override(fontSize: 16)),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/empty.svg",
                                        width: size.width * 0.27,
                                        color: MyFaysalTheme.of(context)
                                            .primaryColor,
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 5),
                                            child: AutoSizeText(
                                              "Oops, Nothing here :(",
                                              maxFontSize: 23,
                                              textAlign: TextAlign.center,
                                              style: MyFaysalTheme.of(context)
                                                  .splashHeaderText
                                                  .override(
                                                      fontSize:
                                                          size.width * 0.05),
                                            ),
                                          ),
                                          ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxWidth: size.width * 0.55),
                                              child: AutoSizeText(
                                                "You don't seems to have any notifications",
                                                maxFontSize: 12,
                                                textAlign: TextAlign.center,
                                                style: MyFaysalTheme.of(context)
                                                    .text1
                                                    .override(
                                                        fontSize:
                                                            size.width * 0.033,
                                                        color: Colors.white
                                                            .withOpacity(0.3)),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          if (history.notification.isEmpty || (history.notification.length <2 && history.history.length>=2)) {
                            return Column(
                              children: List.generate(
                                  history.history.length > 7
                                      ? 7
                                      : history.history.length + 1, (index) {
                                if (index == 0) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Row(
                                      children: [
                                        Text("Recent activities",
                                            style: MyFaysalTheme.of(context)
                                                .splashHeaderText
                                                .override(fontSize: 16)),
                                      ],
                                    ),
                                  );
                                }

                                return NotificationCard(
                                  title: history.history[index - 1].narration,
                                  date: history.history[index - 1].createdAt,
                                );
                              }),
                            );
                          } else {
                            return Column(
                              children: List.generate(
                                  history.notification.length > 5
                                      ? 5
                                      : history.notification.length + 1,
                                  (index) {
                                if (index == 0) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Row(
                                      children: [
                                        Text("Recent activities",
                                            style: MyFaysalTheme.of(context)
                                                .splashHeaderText
                                                .override(fontSize: 16)),
                                      ],
                                    ),
                                  );
                                }

                                return NotificationCard(
                                  title: history.notification[index - 1].title,
                                  date:
                                      history.notification[index - 1].createdAt,
                                );
                              }),
                            );
                          }
                        }
                      }),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text("Promos & Discounts",
                                    style: MyFaysalTheme.of(context)
                                        .splashHeaderText
                                        .override(fontSize: 16)),
                              ],
                            ),
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 15),
                              
                              enlargeCenterPage: true,
                              viewportFraction: 1
                              ),
                            items: [
                              InkWell(
                              onTap: () => Navigator.pushNamed(context, '/ajo'),
                              child: const ActionWidget(image:"assets/images/home_actions.png",text: "Save up for raining days; Create or Join a Rotational Savings Community to get started ",header: "Rotating Savings",)),
                              const ActionWidget(header: "Faysal Card",image: "assets/images/atm2.png",text: "Take control of your finances with the magical Faysal cards.",)
                            ],
                          ),
                          // InkWell(
                          //     onTap: () => Navigator.pushNamed(context, '/ajo'),
                          //     child: const ActionWidget())
                        ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

String getCurrency() {
  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  return format.currencySymbol;
}
