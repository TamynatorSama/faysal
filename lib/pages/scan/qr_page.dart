import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/provider/qr_scan_provider.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'dart:convert';

class QrPage extends StatefulWidget {
  final String amount;
  final String description;

  const QrPage({super.key, required this.amount, required this.description});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  late QrScanProvider qrScanProvider;

  // @override
  // void initState() {
  //
  // }
  @override
  void initState() {
    qrScanProvider = Provider.of(context, listen: false);
    qrScanProvider.checkScanStatus(
        context, qrScanProvider.transactionRef, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 0.9)),
      child: Scaffold(
        backgroundColor: MyFaysalTheme.of(context).scaffolbackgeroundColor,
        body: WidgetBackgorund(
          home: true,
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top < 30
                    ? size.height * 0.1 > 70
                        ? 70
                        : size.height * 0.05
                    : MediaQuery.of(context).padding.top + 20,
                left: 24,
                right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(),
                Text(
                  "Scan QR to Pay",
                  style: MyFaysalTheme.of(context)
                      .splashHeaderText
                      .override(fontSize: 20),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(15),
                          //   child: SizedBox(
                          //     height: size.longestSide * 0.3,
                          //     width: size.longestSide * 0.3,
                          //     child: QrImage(
                          //       data: jsonEncode({
                          //         "ref": Provider.of<QrScanProvider>(context,
                          //                 listen: false)
                          //             .transactionRef,
                          //         "description": widget.description,
                          //         "amount": widget.amount
                          //       }),
                          //       foregroundColor:
                          //           MyFaysalTheme.of(context).primaryText,
                          //       version: QrVersions.auto,
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.height * 0.03, bottom: 20),
                            child: Image.asset(
                              "assets/images/long.png",
                              width: size.width * 0.2,
                            ),
                          ),
                          Text(
                            "Pay with QR Code",
                            style: MyFaysalTheme.of(context)
                                .splashHeaderText
                                .override(fontSize: size.width * 0.06),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: size.width * 0.6),
                                child: AutoSizeText(
                                  "Hold the code inside the frame, it will be scanned automatically",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: MyFaysalTheme.of(context).text1.override(
                                      fontSize: size.width * 0.24,
                                      color: Colors.white.withOpacity(0.5)),
                                )),
                          ),
                        ],
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
    );
  }
}
