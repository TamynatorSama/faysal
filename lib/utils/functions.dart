import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:faysal/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:faysal/models/history_model.dart';
import 'package:faysal/models/rotational_savings.dart';
import 'package:faysal/pages/account/security/widget/security_question_dialog.dart';
import 'package:faysal/pages/auth/login/login.dart';
import 'package:faysal/pages/bills/widget/bills_dialog.dart';
import 'package:faysal/pages/history/single_view.dart';
import 'package:faysal/pages/home/topupwallet/topup_wallet.dart';
import 'package:faysal/pages/topup/widgets/topup_success_dialog.dart';
import 'package:faysal/pages/transfer/widget/transfer_confirmation.dart';
import 'package:faysal/pages/transfer/widget/transfer_destination_modal.dart';
import 'package:faysal/pages/topup/widgets/topup_dialog.dart';
import 'package:faysal/pages/transfer/widget/transfer_success_dialog.dart';
import 'package:faysal/pages/rotating_savings/widget/payment_breakdown_dialog.dart';
import 'package:faysal/provider/buttom_nav_providr.dart';
import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/theme.dart';
import 'package:faysal/widgets/feedback_toast.dart';
import 'package:faysal/widgets/transaction_pin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:faysal/pages/rotating_savings/join_savings/widget/hands_modal.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

String getCurrency() {
  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  return format.currencySymbol;
}

Future<String?> showPinConfirmationModal() async {
  return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => const TransactionPin());
}

Future showTransferDestinationmodal(double amount) async {
  await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => TransferDestinationmodal(amount: amount,));
}

Future showTopUpSuccess(String number) async {
  await showDialog(
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              backgroundColor: Colors.transparent,
              child: TopUpSuccessful(
                number: number,
              ),
            ),
          ));
}

Future showTransferSuccess(String name, String amount,
    [bool? bill, bool? isReciever]) async {
  await showDialog(
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              backgroundColor: Colors.transparent,
              child: TransferSucess(
                name: name,
                amount: amount,
                isBill: bill,
                isReciever: isReciever,
              ),
            ),
          ));
}

Future showSecurityQuestionDialog() async {
  return await showDialog(
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: const Dialog(
                insetPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                backgroundColor: Colors.transparent,
                child: SecurityQuestionDialog()),
          ));
}

Future showNumberOfHandsDialog(int maxHands) async {
  return await showDialog(
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Dialog(
                insetPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                backgroundColor: Colors.transparent,
                child: NumberOfHandsDialog(
                  maxHands: maxHands,
                )),
          ));
}

String generateAvatar(String id, [bool? minus]) {
  var avatarId = id.split("").last;

  if (minus != null && int.parse(avatarId) > 5) {
    return (9 - int.parse(avatarId)).toString();
  }

  return avatarId;
}

Future showTopupDialog() async {
  await showDialog(
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: const Dialog(
              insetPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              backgroundColor: Colors.transparent,
              child: TopupDialog(),
            ),
          ));
}

Future showSingleHistoryView(HistoryModel model, Future Function() call) async {
  await showDialog(
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              backgroundColor: Colors.transparent,
              child: SingleHistoryDialog(
                model: model,
                call: call,
              ),
            ),
          ));
  ButtomNavBarProvider().setTimeout = false;
}

Future showAjoBreakdown(
    VoidCallback call, MyRotationalSavingsModel model) async {
  return await showDialog(
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              backgroundColor: Colors.transparent,
              child: AjoContributionBreakdown(
                call: call,
                model: model,
              ),
            ),
          ));
}

Future<String> selectFilterDate(BuildContext context,
    [DateTime? firstDate, DateTime? lastDate]) async {
  var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate ?? DateTime(1999, 1, 1),
      lastDate: lastDate ?? DateTime.now());
  if (date == null) return "";

  return "${date.year}-${date.month}-${date.day}";
}

Future showBillDialog() async {
  await showDialog(
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: const Dialog(
              insetPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              backgroundColor: Colors.transparent,
              child: BillsDialog(),
            ),
          ));
}

Future showTopupWalletDialog() async {
  await showDialog(
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: const Dialog(
              insetPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              backgroundColor: Colors.transparent,
              child: TopupWallet(),
            ),
          ));
}

Future showTransferConfirmationDialog() async {
  return await showDialog(
      context: MyApp.navigationKey.currentContext!,
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: const Dialog(
              insetPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              backgroundColor: Colors.transparent,
              child: ConfirmTransfer(),
            ),
          ));
}

Future<bool> checkNetworkConnection(bool isInit,
    [BuildContext? context]) async {
  var connectionResult = await Connectivity().checkConnectivity();
  bool result = connectionResult == ConnectivityResult.none ? false : true;
  if (!result) {
    FToast toast = FToast();

    toast.init(isInit ? context! : MyApp.navigationKey.currentContext!);
    toast.showToast(
      gravity: ToastGravity.TOP,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 26, 26),
            borderRadius: BorderRadius.circular(3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: const Text(
          "No Internet Connection",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
      ),
      toastDuration: const Duration(seconds: 5),
    );
  }

  return result;
}
Future showFeedbackToast(String message,bool isError,BuildContext context) async {
    FToast toast = FToast();
    toast.init(context);
    toast.showToast(
      gravity: ToastGravity.TOP,
      child: FeedBackToast(message: message,isError: isError,),
      toastDuration: const Duration(seconds: 5),
    );
}

void showToast(BuildContext context, String message) {
  FToast fToast = FToast().init(context);
  fToast.showToast(
    gravity: ToastGravity.TOP,
    child: Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: MyFaysalTheme.of(context).secondaryColor,
          borderRadius: BorderRadius.circular(3)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
      child: AutoSizeText(
        message,
        textAlign: TextAlign.center,
        style: MyFaysalTheme.of(context).promtHeaderText.override(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.043),
      ),
    ),
    toastDuration: const Duration(seconds: 3),
  );
}

extension Capitalize on String {
  String capitalize([String? separator]) {
    if (isEmpty) return "";
    var split = separator == null ? [this] : trim().split(separator);
    var capitalized = [];

    for (var element in split) {
      var firstLetter = element.replaceRange(1, null, "").toUpperCase();
      var lastLetters = element.replaceRange(0, 1, "");
      capitalized.add("$firstLetter$lastLetters");
    }

    var capitalizedWord =
        capitalized.reduce((value, element) => value + separator + element);

    return capitalizedWord;
  }
}

Future showEntryPin([BuildContext? context]) async {
  Navigator.pushAndRemoveUntil(
            context ?? MyApp.navigationKey.currentContext!,
            PageTransition(
                child: const LoginWidget(), type: PageTransitionType.fade),
            (route) => false);
        Provider.of<ButtomNavBarProvider>(
                context ?? MyApp.navigationKey.currentContext!,
                listen: false)
            .changePage(0);
            Login().isLoggedIn = false;
  // await Login().logoutUser(
  //     () async {
  //       Provider.of(context ?? MyApp.navigationKey.currentContext!,
  //               listen: false)
  //           .clearProvider();
  //       await Login.removeRecord();
  //     },
  //     context ?? MyApp.navigationKey.currentContext!,
  //     () {
        
  //     });

  // await showDialog(
  //   barrierDismissible: false,
  //   context: context ?? MyApp.navigationKey.currentContext!, builder: (context)=> BackdropFilter(
  //   filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
  //   child: WillPopScope(
  //     onWillPop: ()async=>false,
  //     child: const Dialog(
  //       insetPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 24),
  //       backgroundColor: Colors.transparent,
  //       child: EntryPinConfirmationScreen(),),
  //   ),
  // ));
}
