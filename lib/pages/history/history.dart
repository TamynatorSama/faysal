import 'package:faysal/models/history_model.dart';
import 'package:faysal/pages/notification/notificarion_card.dart';
import 'package:faysal/pages/onboarding/widget/nav_bar.dart';
import 'package:faysal/provider/history_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_share/flutter_share.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:typed_data';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  bool isLoading = false;
  bool isRefresh = false;

  @override
  void initState() {
    if (Provider.of<HistoryProvider>(context, listen: false).history.isEmpty) {
      getHistoryData();
    }
    super.initState();
  }

  Future getHistoryData() async {
    if (!isRefresh) {
      setState(() {
        isLoading = true;
      });
    }
    await Provider.of<HistoryProvider>(context, listen: false)
        .populateHistory();
    setState(() {
      isLoading = false;
    });
  }

  GlobalKey screenShotKey = GlobalKey();

  HistoryModel? selectedModel;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Consumer<HistoryProvider>(builder: (context, provider, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
        child: Scaffold(
          backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
          body: isLoading
              ? const LoadingScreen()
              : Stack(
                  children: [
                    selectedModel == null
                        ? const Offstage()
                        : Opacity(
                            // opacity: 1,
                            opacity: 0.01,
                            child: RepaintBoundary(
                              key: screenShotKey,
                              child: Container(
                                color: MyFaysalTheme.of(context).secondaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 50),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/test.png",
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                          Text(
                                            "Transaction Details",
                                            textAlign: TextAlign.center,
                                            style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.7,fontSize:size.width * 0.05)
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Transaction Details",
                                        textAlign: TextAlign.center,
                                        style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 4,fontSize:13)
                                        
                                      ),
                                      Text(
                                        "NGN ${NumberFormat().format(double.parse(selectedModel!.amount))}.00",
                                        textAlign: TextAlign.center,
                                        style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.3,fontSize:20)
                                        
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 40.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Beneficiary Details",
                                                  textAlign: TextAlign.center,
                                                  style: MyFaysalTheme.of(context).text1.override(fontSize: 10)
                                                  
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      selectedModel!.receiverName,
                                                      textAlign: TextAlign.center,
                                                      style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.3,fontSize:13)
                                                     
                                                    ),
                                                    Text(
                                                      selectedModel!.historyAddtionalInfo.type.isNotEmpty? "${selectedModel!.historyAddtionalInfo.type} | ${selectedModel!.historyAddtionalInfo.productName}":"${selectedModel!.receiverBank} | ${selectedModel!.receiverAcctNo}",
                                                      textAlign: TextAlign.end,
                                                      style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.3,fontSize:9),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: MyFaysalTheme.of(context).primaryColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Sender Details",
                                                  textAlign: TextAlign.center,
                                                  style: MyFaysalTheme.of(context).text1.override(fontSize: 10),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    FittedBox(
                                                      child: SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.6,
                                                        child: Text(
                                                          selectedModel!
                                                              .senderName,
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.3,fontSize:13),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${selectedModel!.senderBank} | ${selectedModel!.senderAcctNo}",
                                                      textAlign: TextAlign.end,
                                                      style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.3,fontSize:9),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: MyFaysalTheme.of(context).primaryColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Payment Date",
                                                  textAlign: TextAlign.center,
                                                  style: MyFaysalTheme.of(context).text1.override(fontSize: 10),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      DateFormat.yMMMEd().format(
                                                          DateTime.parse(
                                                              selectedModel!
                                                                  .createdAt)),
                                                      textAlign: TextAlign.end,
                                                      style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.3,fontSize:13),
                                                    ),
                                                    Text(
                                                      DateFormat.jm().format(
                                                          DateTime.parse(
                                                              selectedModel!
                                                                  .createdAt)),
                                                      textAlign: TextAlign.end,
                                                      style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.3,fontSize:9),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: MyFaysalTheme.of(context).primaryColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Description",
                                                  textAlign: TextAlign.center,
                                                  style: MyFaysalTheme.of(context).text1.override(fontSize: 10),
                                                ),
                                                FittedBox(
                                                  child: SizedBox(
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.6,
                                                    child: Text(
                                                      selectedModel!.narration,
                                                      textAlign: TextAlign.end,
                                                      style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.3,fontSize:13),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: MyFaysalTheme.of(context).primaryColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Transaction Type",
                                                  textAlign: TextAlign.center,
                                                  style: MyFaysalTheme.of(context).text1.override(fontSize: 10),
                                                ),
                                                Text(
                                                  selectedModel!.type
                                                      .capitalize(),
                                                  textAlign: TextAlign.end,
                                                  style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.3,fontSize:13),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: MyFaysalTheme.of(context).primaryColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Reference",
                                                  textAlign: TextAlign.center,
                                                  style: MyFaysalTheme.of(context).text1.override(fontSize: 10),
                                                ),
                                                Text(
                                                  selectedModel!.ref,
                                                  textAlign: TextAlign.end,
                                                  style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.3,fontSize:13),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: MyFaysalTheme.of(context).primaryColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Transaction Mode",
                                                  textAlign: TextAlign.center,
                                                  style: MyFaysalTheme.of(context).text1.override(fontSize: 10),
                                                ),
                                                Text(
                                                  selectedModel!.historyAddtionalInfo.type.isNotEmpty ?"Bill Payment" :
                                                  selectedModel!.isInternal
                                                      ? "Faysal - Faysal"
                                                      : selectedModel!
                                                                  .transferIn &&
                                                              selectedModel!.type
                                                                      .toLowerCase() ==
                                                                  "credit"
                                                          ? "Bank Account - Faysal"
                                                          : "Faysal - Bank Account",
                                                  textAlign: TextAlign.end,
                                                  style: MyFaysalTheme.of(context).splashHeaderText.override(lineHeight: 1.3,fontSize:13),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: MyFaysalTheme.of(context).primaryColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                    
                    WidgetBackgorund(
                      home: true,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          isRefresh = true;
                          await getHistoryData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Column(
                            children: [
                              InkWell(
                                  onTap: sendReceipt,
                                  child: const CustomNavBar(header: "History")),
                             provider.history.isEmpty
                              ? Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                                child: Text(
                                                  "Oops, Nothing here :(",
                                                  style: MyFaysalTheme.of(context)
                                                      .splashHeaderText
                                                      .override(
                                                          fontSize:
                                                              size.width * 0.05),
                                                ),
                                              ),
                                              ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          size.width * 0.55),
                                                  child: Text(
                                                    "You have not performed any transactions",
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        MyFaysalTheme.of(context)
                                                            .text1
                                                            .override(
                                                                fontSize:
                                                                    size.width *
                                                                        0.033,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.3)),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              :Expanded(
                                child: ScrollConfiguration(
                                  behavior: const ScrollBehavior()
                                      .copyWith(overscroll: false),
                                  child: SingleChildScrollView(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    child: Column(
                                      children: [
                                        provider.history
                                                .where((element) =>
                                                    DateTime.parse(
                                                            element.createdAt)
                                                        .day ==
                                                    DateTime.now().day)
                                                .toList()
                                                .isEmpty
                                            ? const Offstage()
                                            : Container(
                                                width: double.maxFinite,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: size.width < 327
                                                        ? 15
                                                        : 25),
                                                margin: EdgeInsets.only(
                                                    top: size.height * 0.03),
                                                decoration: BoxDecoration(
                                                  color: MyFaysalTheme.of(context)
                                                      .secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: List.generate(
                                                      provider.history
                                                              .where((element) =>
                                                                  DateTime.parse(
                                                                          element
                                                                              .createdAt)
                                                                      .day ==
                                                                  DateTime.now()
                                                                      .day)
                                                              .toList()
                                                              .length +
                                                          1, (index) {
                                                    List<HistoryModel> today = provider
                                                        .history
                                                        .where((element) =>
                                                            DateTime.parse(element
                                                                    .createdAt)
                                                                .day ==
                                                            DateTime.now().day)
                                                        .toList();
                                                    if (index == 0) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                bottom: 15.0),
                                                        child: Text("Today",
                                                            style: MyFaysalTheme
                                                                    .of(context)
                                                                .splashHeaderText
                                                                .override(
                                                                    fontSize:
                                                                        12)),
                                                      );
                                                    }
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedModel =
                                                              today[index - 1];
                                                        });
                                                        showSingleHistoryView(
                                                            today[index - 1],
                                                            sendReceipt);
                                                      },
                                                      child: TransactionCard(
                                                        date: today[index - 1]
                                                            .createdAt,
                                                        narration:
                                                            today[index - 1]
                                                                .narration,
                                                        amount: today[index - 1]
                                                            .amount,
                                                        credit: today[index - 1]
                                                                .type ==
                                                            "credit",
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                        Container(
                                          width: double.maxFinite,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15,
                                              horizontal:
                                                  size.width < 327 ? 15 : 25),
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.03),
                                          decoration: BoxDecoration(
                                            color: MyFaysalTheme.of(context)
                                                .secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Wrap(
                                            runSpacing: 25,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.start,
                                            children: [
                                              provider.history
                                                      .where((element) =>
                                                          DateTime.parse(element
                                                                  .createdAt)
                                                              .day ==
                                                          DateTime.now()
                                                              .subtract(
                                                                  const Duration(
                                                                      days: 1))
                                                              .day)
                                                      .toList()
                                                      .isEmpty
                                                  ? const Offstage()
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: List.generate(
                                                          provider.history
                                                                  .where((element) =>
                                                                      DateTime.parse(element
                                                                              .createdAt)
                                                                          .day ==
                                                                      DateTime.now()
                                                                          .subtract(const Duration(
                                                                              days:
                                                                                  1))
                                                                          .day)
                                                                  .toList()
                                                                  .length +
                                                              1, (index) {
                                                        List<HistoryModel> yesterday = provider
                                                            .history
                                                            .where((element) =>
                                                                DateTime.parse(element
                                                                        .createdAt)
                                                                    .day ==
                                                                DateTime.now()
                                                                    .subtract(
                                                                        const Duration(
                                                                            days:
                                                                                1))
                                                                    .day)
                                                            .toList();
                                                        if (index == 0) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 15.0),
                                                            child: Text(
                                                                "yesterday",
                                                                style: MyFaysalTheme
                                                                        .of(
                                                                            context)
                                                                    .splashHeaderText
                                                                    .override(
                                                                        fontSize:
                                                                            12)),
                                                          );
                                                        }
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedModel =
                                                                  yesterday[
                                                                      index - 1];
                                                            });
                                                            showSingleHistoryView(
                                                                yesterday[
                                                                    index - 1],
                                                                sendReceipt);
                                                          },
                                                          child: TransactionCard(
                                                            date: yesterday[
                                                                    index - 1]
                                                                .createdAt,
                                                            narration: yesterday[
                                                                    index - 1]
                                                                .narration,
                                                            amount: yesterday[
                                                                    index - 1]
                                                                .amount,
                                                            credit: yesterday[
                                                                        index - 1]
                                                                    .type ==
                                                                "credit",
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                             provider
                                                      .history
                                                      .where((element) =>
                                                          DateTime.parse(element.createdAt)
                                                              .isBefore(DateTime.now()
                                                                  .subtract(const Duration(
                                                                      days:
                                                                          1))) &&
                                                          DateTime.parse(element.createdAt)
                                                              .isAfter(DateTime.now()
                                                                  .subtract(
                                                                      const Duration(days: 7))))
                                                      .toList().isEmpty?const Offstage() :Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                    provider.history
                                                            .where((element) =>
                                                                DateTime.parse(element.createdAt).isBefore(
                                                                    DateTime.now().subtract(
                                                                        const Duration(
                                                                            days:
                                                                                1))) &&
                                                                DateTime.parse(element
                                                                        .createdAt)
                                                                    .isAfter(DateTime.now()
                                                                        .subtract(const Duration(days: 7))))
                                                            .toList()
                                                            .length +
                                                        1, (index) {
                                                  List<HistoryModel> today = provider
                                                      .history
                                                      .where((element) =>
                                                          DateTime.parse(element.createdAt)
                                                              .isBefore(DateTime.now()
                                                                  .subtract(const Duration(
                                                                      days:
                                                                          1))) &&
                                                          DateTime.parse(element.createdAt)
                                                              .isAfter(DateTime.now()
                                                                  .subtract(
                                                                      const Duration(days: 7))))
                                                      .toList();
                                                  if (index == 0) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 15.0),
                                                      child: Text("Last 7 Days",
                                                          style: MyFaysalTheme.of(
                                                                  context)
                                                              .splashHeaderText
                                                              .override(
                                                                  fontSize: 12)),
                                                    );
                                                  }
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedModel =
                                                            today[index - 1];
                                                      });
                                                      showSingleHistoryView(
                                                          today[index - 1],
                                                          sendReceipt);
                                                    },
                                                    child: TransactionCard(
                                                      date: today[index - 1]
                                                          .createdAt,
                                                      narration: today[index - 1]
                                                          .narration,
                                                      amount:
                                                          today[index - 1].amount,
                                                      credit:
                                                          today[index - 1].type ==
                                                              "credit",
                                                    ),
                                                  );
                                                }),
                                              ),
                                              provider
                                                      .history
                                                      .where((element) => DateTime
                                                              .parse(element
                                                                  .createdAt)
                                                          .isBefore(DateTime.now()
                                                              .subtract(
                                                                  const Duration(
                                                                      days: 7))))
                                                      .toList().isEmpty?const Offstage() :Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                    provider.history
                                                            .where((element) => DateTime
                                                                    .parse(element
                                                                        .createdAt)
                                                                .isBefore(DateTime
                                                                        .now()
                                                                    .subtract(
                                                                        const Duration(
                                                                            days:
                                                                                7))))
                                                            .toList()
                                                            .length +
                                                        1, (index) {
                                                  List<HistoryModel> today = provider
                                                      .history
                                                      .where((element) => DateTime
                                                              .parse(element
                                                                  .createdAt)
                                                          .isBefore(DateTime.now()
                                                              .subtract(
                                                                  const Duration(
                                                                      days: 7))))
                                                      .toList();
                                                  if (index == 0) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 15.0),
                                                      child: Text("Past Weeks",
                                                          style: MyFaysalTheme.of(
                                                                  context)
                                                              .splashHeaderText
                                                              .override(
                                                                  fontSize: 12)),
                                                    );
                                                  }
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedModel =
                                                            today[index - 1];
                                                      });
      
                                                      showSingleHistoryView(
                                                          today[index - 1],
                                                          sendReceipt);
                                                    },
                                                    child: TransactionCard(
                                                      date: today[index - 1]
                                                          .createdAt,
                                                      narration: today[index - 1]
                                                          .narration,
                                                      amount:
                                                          today[index - 1].amount,
                                                      credit:
                                                          today[index - 1].type ==
                                                              "credit",
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 80,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        
                        ),
                      
                      ),
                    ),
                    
                  ],
                ),
        ),
      );
    });
  }

  Future sendReceipt() async {

    RenderRepaintBoundary screenShot = screenShotKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    // if (screenShot.debugNeedsPaint) {
    //   return;
    // }

    ui.Image image = await screenShot.toImage(pixelRatio: 5.0);
    final directory = await getExternalStorageDirectory();
    ByteData imageInByte =
        await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    Uint8List pngBytes = imageInByte.buffer.asUint8List();
    File transferScreenshot =
        File("${directory!.path}/${selectedModel!.id}.png");
    await transferScreenshot.writeAsBytes(pngBytes);

    await FlutterShare.shareFile(
        title: "transfer details", filePath: transferScreenshot.path);
    // await directory.delete(recursive: true);
  }
}
