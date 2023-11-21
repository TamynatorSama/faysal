// import 'package:faysal/pages/topup/airtime/airtime.dart';
// import 'package:faysal/pages/topup/data/data.dart';
import 'package:faysal/pages/bills/pay_tv_bills.dart';
import 'package:faysal/pages/bills/pay_utility_bill.dart';
import 'package:faysal/pages/bills/widget/bill_listing_card.dart';
import 'package:faysal/provider/bills_provider.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class BillsDialog extends StatefulWidget {
  const BillsDialog({super.key});

  @override
  State<BillsDialog> createState() => _BillsDialogState();
}

class _BillsDialogState extends State<BillsDialog>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  late BillProivder _billProivder;


  @override
  void initState() {
    _billProivder = Provider.of<BillProivder>(context,listen: false);
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
      child: Container(
        width: double.maxFinite,
        height: size.height * 0.6,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
            color: MyFaysalTheme.of(context).secondaryColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pay Bills",
                    style: MyFaysalTheme.of(context).splashHeaderText,
                  ),
                  IconButton(
                          onPressed: ()=>Navigator.pop(context),
                          icon: Icon(
                            Icons.close,
                            color: Colors.white.withOpacity(0.4),
                            size: 18,
                          ),
                        )
                ],
              ),
            ),
    
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width * 0.55),
              child: TabBar(
                  controller: controller,
                  indicatorColor: MyFaysalTheme.of(context).primaryColor,
                  labelStyle: MyFaysalTheme.of(context)
                      .promtHeaderText
                      .override(fontSize: 14),
                  labelColor: MyFaysalTheme.of(context).primaryColor,
                  unselectedLabelColor: Colors.white.withOpacity(0.5),
                  tabs: const [
                    Tab(
                      text: "Utility Bills",
                    ),
                    Tab(
                      text: "TV Bills",
                    )
                  ]),
            ),
    
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Divider(
                height: 0,
                color: MyFaysalTheme.of(context).primaryColor,
              ),
            ),
    
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: MyFaysalTheme.of(context).splashHeaderText.override(
                      fontSize: size.width * 0.04,
                      color: Colors.white.withOpacity(0.3)),
                  filled: true,
                  contentPadding: const EdgeInsets.all(15),
                  prefixIcon: Container(
                      padding: EdgeInsets.all(
                          size.width * 0.03 < 15 ? 15 : size.width * 0.03),
                      child: SvgPicture.asset("assets/svg/Search.svg",
                          color: Colors.white.withOpacity(0.3))),
                  // prefixIconConstraints: const BoxConstraints(maxHeight: 50,maxWidth: 50),
                  // prefix: Padding(
                  //   padding: const EdgeInsets.only(right: 8.0),
                  //   child: SvgPicture.asset("assets/svg/Search.svg"),
                  // ),
                  fillColor: const Color(0xff123F33),
                  border: InputBorder.none,
                ),
                style: MyFaysalTheme.of(context)
                    .splashHeaderText
                    .override(fontSize: size.width * 0.045),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
    
            Expanded(
              child: TabBarView(controller: controller, children: [
                SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 20,
                    children: [
                      BillListingCard(
                        isUtility: true,
                          bill: "Eko Electricity",
                          call: () {
                             _billProivder.electricityProvider = "eko-electric";
                             Navigator.push(context, PageTransition(child: const PayUtilityBills(imageIndex: 1), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/electricity1.png"),
                      BillListingCard(
                        isUtility: true,
                          bill: "IBEDC",
                          call: () {
                            _billProivder.electricityProvider = "ibadan-electric";
                             Navigator.push(context, PageTransition(child: const PayUtilityBills(imageIndex: 2), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/electricity2.png"),
                      BillListingCard(
                        isUtility: true,
                          bill: "Ikeja Electric",
                          call: () {
                            _billProivder.electricityProvider = "ikeja-electric";
                             Navigator.push(context, PageTransition(child: const PayUtilityBills(imageIndex: 3), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/electricity3.png"),
                      BillListingCard(
                        isUtility: true,
                          bill: "AEDC",
                          call: () {
                            _billProivder.electricityProvider = "abuja-electric";
                             Navigator.push(context, PageTransition(child: const PayUtilityBills(imageIndex: 4), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/electricity4.png"),
                      BillListingCard(
                        isUtility: true,
                          bill: "KEDCO",
                          call: () {
                            _billProivder.electricityProvider = "kano-electric";
                             Navigator.push(context, PageTransition(child: const PayUtilityBills(imageIndex: 5), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/electricity5.png"),
                      BillListingCard(
                        isUtility: true,
                          bill: "PHED",
                          call: () {
                            _billProivder.electricityProvider = "portharcourt-electric";
                             Navigator.push(context, PageTransition(child: const PayUtilityBills(imageIndex: 6), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/electricity6.png"),
                      BillListingCard(
                        isUtility: true,
                          bill: "Kaduna Electric",
                          call: () {
                            _billProivder.electricityProvider = "kaduna-electric";
                             Navigator.push(context, PageTransition(child: const PayUtilityBills(imageIndex: 7), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/electricity7.png"),
                          BillListingCard(
                            isUtility: true,
                          bill: "JED",
                          call: () {
                            _billProivder.electricityProvider = "jos-electric";
                             Navigator.push(context, PageTransition(child: const PayUtilityBills(imageIndex: 8), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/electricity8.png"),
                          BillListingCard(
                            isUtility: true,
                          bill: "EEDC",
                          call: () {
                            _billProivder.electricityProvider = "enugu-electric";
                             Navigator.push(context, PageTransition(child: const PayUtilityBills(imageIndex: 9), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/electricity9.png"),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 20,
                    children: [
                      BillListingCard(
                          bill: "DSTV",
                          isUtility: false,
                          call: () {
                            _billProivder.provider = "dstv";
                            Navigator.push(context, PageTransition(child: const PayTvBills(), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/dstv.png"),
                      BillListingCard(
                          bill: "GOTV",
                          isUtility: false,
                          call: () {
                            _billProivder.provider = "gotv";
                            Navigator.push(context, PageTransition(child: const PayTvBills(), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/gotv.png"),
                      BillListingCard(
                          bill: "Startimes",
                          isUtility: false,
                          call: () {
                            _billProivder.provider = "startimes";
                            Navigator.push(context, PageTransition(child: const PayTvBills(), type: PageTransitionType.rightToLeft));
                          },
                          imageAssset: "assets/images/start.png"),
                    ],
                  ),
                )
              ]),
            )
            // FittedBox(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       GestureDetector(
            //         onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const Airtime())),
            //         child: Row(
            //           children: [
            //             Container(
            //                 width: size.longestSide * 0.062,
            //                 height: size.longestSide * 0.062,
            //                 constraints: const BoxConstraints(
            //                     maxHeight: 46,
            //                     maxWidth: 46,
            //                     minHeight: 30,
            //                     minWidth: 30),
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(16),
            //                     color: MyFaysalTheme.of(context).primaryColor),
            //                 child: Icon(Icons.phone_iphone,
            //                     color: MyFaysalTheme.of(context).secondaryColor,
            //                     size: size.longestSide * 0.04 > 32
            //                         ? 26
            //                         : size.longestSide * 0.04 < 24
            //                             ? 23
            //                             : size.longestSide * 0.04)),
            //             Padding(
            //               padding: const EdgeInsets.only(left:15.0),
            //               child: Text(
            //                 "Airtime",
            //                 style: MyFaysalTheme.of(context)
            //                     .splashHeaderText
            //                     .override(fontSize: 20),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     Padding(
            //       padding: const EdgeInsets.only(top:10.0),
            //       child: GestureDetector(
            //         onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const Data())),
            //         child: Row(
            //             children: [
            //               Container(
            //                   width: size.longestSide * 0.062,
            //                   height: size.longestSide * 0.062,
            //                   constraints: const BoxConstraints(
            //                       maxHeight: 46,
            //                       maxWidth: 46,
            //                       minHeight: 30,
            //                       minWidth: 30),
            //                   decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(16),
            //                       color: MyFaysalTheme.of(context).primaryColor),
            //                   child: Icon(Icons.wifi_tethering ,
            //                       color: MyFaysalTheme.of(context).secondaryColor,
            //                       size: size.longestSide * 0.04 > 32
            //                           ? 26
            //                           : size.longestSide * 0.04 < 24
            //                               ? 23
            //                               : size.longestSide * 0.04)),
            //               Padding(
            //                 padding: const EdgeInsets.only(left:15.0),
            //                 child: Text(
            //                   "Data Bundle",
            //                   style: MyFaysalTheme.of(context)
            //                       .splashHeaderText
            //                       .override(fontSize: 20),
            //                 ),
            //               )
            //             ],
            //           ),
            //       ),
            //     ),
    
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
