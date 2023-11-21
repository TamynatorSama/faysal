import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/models/history_model.dart';
import 'package:faysal/pages/home/topupwallet/widget/topup_wallet_btn.dart';
import 'package:faysal/provider/buttom_nav_providr.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class SingleHistoryDialog extends StatefulWidget {
  final HistoryModel model;
  final Future Function() call;
  const SingleHistoryDialog(
      {super.key, required this.model, required this.call});

  @override
  State<SingleHistoryDialog> createState() => _SingleHistoryDialogState();
}

class _SingleHistoryDialogState extends State<SingleHistoryDialog> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        // await Future.delayed(const Duration(seconds: 1), () {
          ButtomNavBarProvider().setTimeout = false;
        // });
        return true;
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
            textScaleFactor:
                MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: size.height * 0.6,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  color: MyFaysalTheme.of(context).secondaryColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: ()async{
                                  // await Future.delayed(
                                  //             const Duration(seconds: 1), () {
                                            ButtomNavBarProvider().setTimeout =
                                                false;
                                          // });
                                  Navigator.pop(context);},
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white.withOpacity(0.4),
                                  size: 18,
                                ),
                              )
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
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6),
                                      child: AutoSizeText(
                                        "Transactions Details",
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: MyFaysalTheme.of(context)
                                            .splashHeaderText
                                            .override(fontSize: 20),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.08),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: size.width * 0.19,
                                          height: size.width * 0.19,
                                          padding:
                                              EdgeInsets.all(size.width * 0.04),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: MyFaysalTheme.of(context)
                                                  .primaryColor),
                                          child: SvgPicture.string(
                                            '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="17" y1="7" x2="7" y2="17"></line><polyline points="17 17 7 17 7 7"></polyline></svg>',
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            children: [
                                              AutoSizeText(
                                                widget.model.narration,
                                                maxLines: 1,
                                                style: MyFaysalTheme.of(context)
                                                    .splashHeaderText
                                                    .override(
                                                        fontSize: 18,
                                                        lineHeight: 2.3),
                                              ),
                                              ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.58),
                                                  child: AutoSizeText(
                                                    "${DateFormat.MMMMd().format(DateTime.parse(widget.model.createdAt))}, ${DateFormat.jm().format(DateTime.parse(widget.model.createdAt))}",
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    style: MyFaysalTheme.of(
                                                            context)
                                                        .text1
                                                        .override(
                                                            fontSize: 15,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.5)),
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.58),
                                      child: AutoSizeText(
                                        "Ref ID: ${widget.model.ref}",
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: MyFaysalTheme.of(context)
                                            .text1
                                            .override(
                                                fontSize: 15,
                                                color: Colors.white
                                                    .withOpacity(0.5)),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      children: [
                                        TopupWalletBtn(
                                          icon:
                                              '<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6"><path stroke-linecap="round" stroke-linejoin="round" d="M8.25 7.5V6.108c0-1.135.845-2.098 1.976-2.192.373-.03.748-.057 1.123-.08M15.75 18H18a2.25 2.25 0 002.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 00-1.123-.08M15.75 18.75v-1.875a3.375 3.375 0 00-3.375-3.375h-1.5a1.125 1.125 0 01-1.125-1.125v-1.5A3.375 3.375 0 006.375 7.5H5.25m11.9-3.664A2.251 2.251 0 0015 2.25h-1.5a2.251 2.251 0 00-2.15 1.586m5.8 0c.065.21.1.433.1.664v.75h-6V4.5c0-.231.035-.454.1-.664M6.75 7.5H4.875c-.621 0-1.125.504-1.125 1.125v12c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V16.5a9 9 0 00-9-9z" /></svg>',
                                          text: "Share Transaction",
                                          call: () async {
                                            ButtomNavBarProvider().setTimeout =
                                                true;

                                            await widget.call();
                                          },
                                        )
                                        // Padding(
                                        //   padding: const EdgeInsets.only(top: 20.0),
                                        //   child: TopupWalletBtn(
                                        //     icon:
                                        //         '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="18" cy="5" r="3"></circle><circle cx="6" cy="12" r="3"></circle><circle cx="18" cy="19" r="3"></circle><line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line><line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line></svg>',
                                        //     text: "Share Account Details",
                                        //     call: () async {},
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
