import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/provider/chart_provider.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  void initState() {
    Provider.of<StatisticProvider>(context, listen: false).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
        body: Consumer<StatisticProvider>(builder: (context, provider, child) {
          return WidgetBackgorund(
              home: true,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top < 30
                        ? size.height * 0.1 > 70
                            ? 70
                            : size.height * 0.1
                        : MediaQuery.of(context).padding.top + 20,
                    left: 24,
                    right: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Insights",
                          textAlign: TextAlign.center,
                          style: MyFaysalTheme.of(context)
                              .splashHeaderText
                              .override(fontSize: 20),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ScrollConfiguration(
                            behavior: const ScrollBehavior()
                                .copyWith(overscroll: false),
                            child: SingleChildScrollView(
                                child: Column(children: [
                              Container(
                                width: double.maxFinite,
                                margin:
                                    const EdgeInsets.only(top: 40, bottom: 30),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: MyFaysalTheme.of(context)
                                        .secondaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText("Income",
                                              style: MyFaysalTheme.of(context)
                                                  .splashHeaderText
                                                  .override(
                                                      fontSize:
                                                          size.width * 0.04)),
                                          AutoSizeText.rich(
                                              TextSpan(children: [
                                                TextSpan(
                                                    text: getCurrency(),
                                                    style: const TextStyle(
                                                        fontFamily: "Poppins")),
                                                TextSpan(
                                                    text: NumberFormat().format(
                                                        provider.credit))
                                              ]),
                                              maxLines: 1,
                                              style: MyFaysalTheme.of(context)
                                                  .splashHeaderText
                                                  .override(
                                                      fontSize:
                                                          size.width * 0.08,
                                                      lineHeight: 1.3)),
                                        ],
                                      ),
                                    )),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 13.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText("Expenses",
                                                  style:
                                                      MyFaysalTheme.of(context)
                                                          .splashHeaderText
                                                          .override(
                                                              fontSize:
                                                                  size.width *
                                                                      0.04)),
                                              AutoSizeText.rich(
                                                  TextSpan(children: [
                                                    TextSpan(
                                                        text: getCurrency(),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Poppins")),
                                                    TextSpan(
                                                        text: NumberFormat()
                                                            .format(
                                                                provider.debit))
                                                  ]),
                                                  maxLines: 1,
                                                  style:
                                                      MyFaysalTheme.of(context)
                                                          .splashHeaderText
                                                          .override(
                                                              fontSize:
                                                                  size.width *
                                                                      0.08,
                                                              lineHeight: 1.3)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                              Container(
                                width: double.maxFinite,
                                margin: const EdgeInsets.only(bottom: 30),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: MyFaysalTheme.of(context)
                                        .secondaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: size.height * 0.05),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText("Weekly",
                                              maxLines: 1,
                                              style: MyFaysalTheme.of(context)
                                                  .splashHeaderText
                                                  .override(
                                                    fontSize: size.width * 0.04,
                                                  )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  AutoSizeText("Income",
                                                      style: MyFaysalTheme.of(
                                                              context)
                                                          .splashHeaderText
                                                          .override(
                                                            fontSize:
                                                                size.width *
                                                                    0.034,
                                                          )),
                                                  Container(
                                                    width: 15,
                                                    height: 15,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Color(
                                                                0xff4BF0A5)),
                                                    child: FittedBox(
                                                        child: SvgPicture.string(
                                                            '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="17" y1="7" x2="7" y2="17"></line><polyline points="17 17 7 17 7 7"></polyline></svg>')),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Row(
                                                  children: [
                                                    AutoSizeText("Expenses",
                                                        style: MyFaysalTheme.of(
                                                                context)
                                                            .splashHeaderText
                                                            .override(
                                                              fontSize:
                                                                  size.width *
                                                                      0.034,
                                                            )),
                                                    Container(
                                                      width: 15,
                                                      height: 15,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffE86B35)),
                                                      child: FittedBox(
                                                          child: SvgPicture.string(
                                                              '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="7" y1="17" x2="17" y2="7"></line><polyline points="7 7 17 7 17 17"></polyline></svg>')),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.06),
                                      width: double.maxFinite,
                                      child: Wrap(
                                        alignment: WrapAlignment.spaceBetween,
                                        children: List.generate(
                                            provider.weekCredit.length,
                                            (index) {
                                          double allForDay =
                                              provider.weekCredit[index] +
                                                  provider.weekDebit[index];
                                          double debitHeight =
                                              ((provider.weekDebit[index] /
                                                              allForDay) *
                                                          size.height *
                                                          0.3)
                                                      .isNaN
                                                  ? ((provider.weekCredit[
                                                                      index] /
                                                                  allForDay) *
                                                              size.height *
                                                              0.3)
                                                          .isNaN
                                                      ? size.height * 0.3 / 2
                                                      : 0
                                                  : (provider.weekDebit[index] /
                                                          allForDay) *
                                                      size.height *
                                                      0.3;
                                          double creditHeigth = ((provider
                                                                  .weekCredit[
                                                              index] /
                                                          allForDay) *
                                                      size.height *
                                                      0.3)
                                                  .isNaN
                                              ? ((provider.weekDebit[index] /
                                                              allForDay) *
                                                          size.height *
                                                          0.3)
                                                      .isNaN
                                                  ? size.height * 0.3 / 2
                                                  : 0
                                              : (provider.weekCredit[index] /
                                                      allForDay) *
                                                  size.height *
                                                  0.3;

                                          return Column(
                                            children: [
                                              SizedBox(
                                                width: 7,
                                                height: size.height * 0.3 + 6,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    AnimatedContainer(
                                                      margin: EdgeInsets.only(
                                                          bottom: ((provider.weekDebit[
                                                                              index] /
                                                                          allForDay) *
                                                                      size.height *
                                                                      0.3)
                                                                  .isNaN
                                                              ? 0
                                                              : 3),
                                                      duration: const Duration(
                                                          milliseconds: 600),
                                                      width: 7,
                                                      height: creditHeigth,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        color: const Color(
                                                            0xff4BF0A5),
                                                      ),
                                                    ),
                                                    AnimatedContainer(
                                                      margin: EdgeInsets.only(
                                                          top: ((provider.weekCredit[index] /
                                                                              allForDay) *
                                                                          size
                                                                              .height *
                                                                          0.3)
                                                                      .isNaN &&
                                                                  !((provider.weekCredit[index] /
                                                                              allForDay) *
                                                                          size.height *
                                                                          0.3)
                                                                      .isNaN
                                                              ? 0
                                                              : 3),
                                                      duration: const Duration(
                                                          milliseconds: 600),
                                                      width: 7,
                                                      height: debitHeight,
                                                      decoration:
                                                          const ShapeDecoration(
                                                        color:
                                                            Color(0xffE86B35),
                                                        shape: StadiumBorder(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                  index == 0
                                                      ? "S"
                                                      : index == 1
                                                          ? "M"
                                                          : index == 2
                                                              ? "T"
                                                              : index == 3
                                                                  ? "W"
                                                                  : index == 4
                                                                      ? "T"
                                                                      : index ==
                                                                              5
                                                                          ? "F"
                                                                          : "S",
                                                  style:
                                                      MyFaysalTheme.of(context)
                                                          .splashHeaderText
                                                          .override(
                                                              fontSize: 13,
                                                              lineHeight: 2.3))
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          size.width * 0.06,
                                          40.0,
                                          size.width * 0.06,
                                          0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText("Category Chart",
                                                  maxLines: 1,
                                                  style:
                                                      MyFaysalTheme.of(context)
                                                          .splashHeaderText
                                                          .override(
                                                            fontSize:
                                                                size.width *
                                                                    0.045,
                                                          )),
                                              AutoSizeText("All Time Expenses",
                                                  maxLines: 1,
                                                  style: MyFaysalTheme.of(
                                                          context)
                                                      .splashHeaderText
                                                      .override(
                                                          fontSize: 5,
                                                          color:
                                                              MyFaysalTheme.of(
                                                                      context)
                                                                  .primaryText
                                                                  .withOpacity(
                                                                      0.5))),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Row(
                                                  children: [
                                                    AutoSizeText("Expenses",
                                                        maxLines: 1,
                                                        style: MyFaysalTheme.of(
                                                                context)
                                                            .splashHeaderText
                                                            .override(
                                                              fontSize:
                                                                  size.width *
                                                                      0.045,
                                                            )),
                                                    Container(
                                                      width: 15,
                                                      height: 15,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffE86B35)),
                                                      child: FittedBox(
                                                          child: SvgPicture.string(
                                                              '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="7" y1="17" x2="17" y2="7"></line><polyline points="7 7 17 7 17 17"></polyline></svg>')),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              AutoSizeText.rich(
                                                  TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "-${getCurrency()}",
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "Poppins")),
                                                    TextSpan(
                                                        text: NumberFormat()
                                                            .format(
                                                                provider.debit))
                                                  ]),
                                                  maxLines: 1,
                                                  style: MyFaysalTheme.of(
                                                          context)
                                                      .splashHeaderText
                                                      .override(
                                                          fontSize:
                                                              size.width * 0.01,
                                                          color:
                                                              MyFaysalTheme.of(
                                                                      context)
                                                                  .primaryText
                                                                  .withOpacity(
                                                                      0.5))),
                                              // AutoSizeText(
                                              //   "NGN ${NumberFormat().format(provider.credit)}",
                                              //   maxLines: 1,
                                              //   style: MyFaysalTheme.of(
                                              //             context)
                                              //         .splashHeaderText
                                              //         .override(
                                              //             fontSize:
                                              //                 size.width * 0.01,
                                              //             color:
                                              //                 MyFaysalTheme.of(
                                              //                         context)
                                              //                     .primaryText
                                              //                     .withOpacity(
                                              //                         0.5))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: SfCircularChart(
                                        // centerX: ,
                                        series: <CircularSeries>[
                                          DoughnutSeries<GOPData, dynamic>(
                                              innerRadius:
                                                  "${(size.width * 0.37) - 15}",
                                              radius: "${size.width * 0.37}",
                                              dataSource: getChartData(
                                                  provider.debit,
                                                  provider.credit),
                                              xValueMapper: (GOPData date, _) =>
                                                  date.continet,
                                              pointColorMapper:
                                                  (GOPData data, _) =>
                                                      data.color,
                                              yValueMapper: (GOPData date, _) =>
                                                  date.gpd),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            
                            ])))),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ));
        }));
  }

  List<GOPData> getChartData(double debit, double credit) {
    final List<GOPData> chartDate = [
      GOPData(
        continet: "Income",
        gpd: credit.floor(),
        color: const Color(0xff4BF0A5),
      ),
      GOPData(
        continet: "Expenses",
        gpd: debit.floor(),
        color: const Color(0xffE86B35),
      ),
    ];
    return chartDate;
  }
}

class GOPData {
  final String continet;
  final int gpd;
  final Color color;
  GOPData({
    required this.continet,
    required this.gpd,
    required this.color,
  });
}
