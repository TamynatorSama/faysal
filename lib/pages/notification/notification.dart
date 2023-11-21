import 'package:faysal/pages/home/widgets/notification_cart.dart';
import 'package:faysal/pages/notification/notification_model.dart';
import 'package:faysal/provider/history_provider.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/custom_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {

  bool isLoading = false;
  bool isRefresh = false;

  @override
  void initState() {
    if (Provider.of<HistoryProvider>(context, listen: false).notification.isNotEmpty) {
      isRefresh = true;
    }
    getHistoryData();
    super.initState();
  }

  Future getHistoryData() async {
    if (!isRefresh) {
      setState(() {
        isLoading = true;
      });
    }
    await Provider.of<HistoryProvider>(context, listen: false)
        .populateNotifications();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<HistoryProvider>(builder: (context, provider, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
        child: RefreshIndicator(
          onRefresh: ()async{
            isRefresh = true;
            await getHistoryData();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: MediaQuery.of(context).padding.top < 30
                  ? size.height * 0.1 > 70
                      ? 70
                      : size.height * 0.1
                  : MediaQuery.of(context).padding.top + 20,
            ),
            child: Column(
              children: [
                Text(
                  "Notifications",
                  style: MyFaysalTheme.of(context)
                      .splashHeaderText
                      .override(fontSize: 20),
                ),
               isLoading
                ? const LoadingScreen(): provider.notification.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/empty.svg",
                                  width: size.width * 0.27,
                                  color: MyFaysalTheme.of(context).primaryColor,
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
                                            .override(fontSize: size.width * 0.05),
                                      ),
                                    ),
                                    ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: size.width * 0.55),
                                        child: Text(
                                          "You have dont have any notification at the moment",
                                          textAlign: TextAlign.center,
                                          style: MyFaysalTheme.of(context)
                                              .text1
                                              .override(
                                                  fontSize: size.width * 0.033,
                                                  color: Colors.white
                                                      .withOpacity(0.3)),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ScrollConfiguration(
                          behavior:
                              const ScrollBehavior().copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                provider.notification
                                        .where((element) =>
                                            DateTime.parse(element.createdAt).day ==
                                            DateTime.now().day)
                                        .toList()
                                        .isEmpty
                                    ? const Offstage()
                                    : Container(
                                        width: double.maxFinite,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15,
                                            horizontal: size.width < 327 ? 15 : 25),
                                        margin: EdgeInsets.only(
                                            top: size.height * 0.03),
                                        decoration: BoxDecoration(
                                          color: MyFaysalTheme.of(context)
                                              .secondaryColor,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                              provider.notification
                                                      .where((element) =>
                                                          DateTime.parse(
                                                                  element.createdAt)
                                                              .day ==
                                                          DateTime.now().day)
                                                      .toList()
                                                      .length +
                                                  1, (index) {
                                            List<NotificationModel> today = provider
                                                .notification
                                                .where((element) =>
                                                    DateTime.parse(
                                                            element.createdAt)
                                                        .day ==
                                                    DateTime.now().day)
                                                .toList();
                                            if (index == 0) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 15.0),
                                                child: Text("Today",
                                                    style: MyFaysalTheme.of(context)
                                                        .splashHeaderText
                                                        .override(fontSize: 12)),
                                              );
                                            }
                                            return NotificationCard(
                                                date: today[index - 1].createdAt,
                                                title: today[index - 1].title);
                                          }),
                                        ),
                                      ),
                               
                               provider.notification
                                              .where((element) => DateTime.parse(
                                                      element.createdAt)
                                                  .isBefore(DateTime.now().subtract(
                                                      const Duration(days: 7))))
                                              .toList()
                                              .isEmpty && provider.notification
                                              .where((element) =>
                                                  DateTime.parse(element.createdAt)
                                                      .isBefore(DateTime.now()
                                                          .subtract(const Duration(
                                                              days: 1))) &&
                                                  DateTime.parse(element.createdAt)
                                                      .isAfter(DateTime.now()
                                                          .subtract(const Duration(
                                                              days: 7))))
                                              .toList()
                                              .isEmpty  &&provider.notification
                                              .where((element) =>
                                                  DateTime.parse(element.createdAt)
                                                      .day ==
                                                  DateTime.now()
                                                      .subtract(
                                                          const Duration(days: 1))
                                                      .day)
                                              .toList()
                                              .isEmpty ? const Offstage():
                                Container(
                                  width: double.maxFinite,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: size.width < 327 ? 15 : 25),
                                  margin: EdgeInsets.only(top: size.height * 0.03),
                                  decoration: BoxDecoration(
                                    color: MyFaysalTheme.of(context).secondaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Wrap(
                                    runSpacing: 25,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    children: [
                                      provider.notification
                                              .where((element) =>
                                                  DateTime.parse(element.createdAt)
                                                      .day ==
                                                  DateTime.now()
                                                      .subtract(
                                                          const Duration(days: 1))
                                                      .day)
                                              .toList()
                                              .isEmpty
                                          ? const Offstage()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  provider.notification
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
                                                          .length +
                                                      1, (index) {
                                                List<NotificationModel> yesterday =
                                                    provider.notification
                                                        .where((element) =>
                                                            DateTime.parse(element
                                                                    .createdAt)
                                                                .day ==
                                                            DateTime.now()
                                                                .subtract(
                                                                    const Duration(
                                                                        days: 1))
                                                                .day)
                                                        .toList();
                                                if (index == 0) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 15.0),
                                                    child: Text("yesterday",
                                                        style: MyFaysalTheme.of(
                                                                context)
                                                            .splashHeaderText
                                                            .override(
                                                                fontSize: 12)),
                                                  );
                                                }
                                                return NotificationCard(
                                                    date: yesterday[index - 1]
                                                        .createdAt,
                                                    title:
                                                        yesterday[index - 1].title);
                                              }),
                                            ),
                                      provider.notification
                                              .where((element) =>
                                                  DateTime.parse(element.createdAt)
                                                      .isBefore(DateTime.now()
                                                          .subtract(const Duration(
                                                              days: 1))) &&
                                                  DateTime.parse(element.createdAt)
                                                      .isAfter(DateTime.now()
                                                          .subtract(const Duration(
                                                              days: 7))))
                                              .toList()
                                              .isEmpty
                                          ? const Offstage()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  provider.notification
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
                                                List<NotificationModel> today = provider
                                                    .notification
                                                    .where((element) =>
                                                        DateTime.parse(element.createdAt)
                                                            .isBefore(DateTime.now()
                                                                .subtract(const Duration(
                                                                    days: 1))) &&
                                                        DateTime.parse(element.createdAt)
                                                            .isAfter(DateTime.now()
                                                                .subtract(
                                                                    const Duration(days: 7))))
                                                    .toList();
                                                if (index == 0) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 15.0),
                                                    child: Text("Last 7 Days",
                                                        style: MyFaysalTheme.of(
                                                                context)
                                                            .splashHeaderText
                                                            .override(
                                                                fontSize: 12)),
                                                  );
                                                }
                                                return NotificationCard(
                                                    date:
                                                        today[index - 1].createdAt,
                                                    title: today[index - 1].title);
                                              }),
                                            ),
                                      provider.notification
                                              .where((element) => DateTime.parse(
                                                      element.createdAt)
                                                  .isBefore(DateTime.now().subtract(
                                                      const Duration(days: 7))))
                                              .toList()
                                              .isEmpty
                                          ? const Offstage()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  provider.notification
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
                                                List<NotificationModel> today =
                                                    provider
                                                        .notification
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
                                                    padding: const EdgeInsets.only(
                                                        bottom: 15.0),
                                                    child: Text("Past Weeks",
                                                        style: MyFaysalTheme.of(
                                                                context)
                                                            .splashHeaderText
                                                            .override(
                                                                fontSize: 12)),
                                                  );
                                                }
                                                return NotificationCard(
                                                    date:
                                                        today[index - 1].createdAt,
                                                    title: today[index - 1].title);
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
      );
    });
  }
}
  
