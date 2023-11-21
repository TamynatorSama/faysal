// ignore_for_file: use_build_context_synchronously

import 'package:faysal/app_navigator.dart';
import 'package:faysal/models/bank_model.dart';
import 'package:faysal/models/history_model.dart';
import 'package:faysal/models/user_model.dart';
import 'package:faysal/services/http_class.dart';
import 'package:faysal/utils/functions.dart';
import 'package:faysal/utils/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransferProvider extends ChangeNotifier {
  double? amount;
  String? accountNumer;
  BankModel? bankCode;
  String? pin;
  String? description;
  UserModel? transferFaysal;
  String? userBankName;
  late HistoryModel transactionHistory;
  bool ableToDoExternalTransfer = true;

  List<BankModel> banks = [];

  void update(Update updateType, dynamic value) {
    switch (updateType) {
      case Update.acccountnum:
        accountNumer = value;
        break;
      case Update.amount:
        amount = value;
        break;
      case Update.pin:
        pin = value;
        break;
      case Update.bankcode:
        bankCode = value;
        break;
      case Update.description:
        description = value;
        break;
    }
    notifyListeners();
  }

  void resetAll([bool? init]) {
    amount = null;
    accountNumer = null;
    bankCode = null;
    pin = null;
    description = null;
    transferFaysal = null;
    // if(init !=null){
    //   notifyListeners();
    // }
  }

  Future<void> populateBank([bool? init]) async {
    var response = await HttpResponse().getBanks();
    if (response["status"] != 200) {
      return;
    }
    if(kDebugMode)print(response);

    if(response["data"] == false || response["data"]["banks"] == null || (response["data"]["banks"] as List).isEmpty){
      ableToDoExternalTransfer = false;
      return;
    }
    
    var bankJson = response["data"]["banks"] as List;
    banks = bankJson.map((e) => BankModel.fromJson(e)).toList();
    if (init == null) {
      notifyListeners();
    }
  }

  Future<void> getUser(String number, BuildContext context) async {
    FToast fToast = FToast().init(context);
    var response = await HttpResponse().getUser(number);
    if(kDebugMode)print(response);

    if (response["status"] != 200) {
      transferFaysal = null;
      notifyListeners();
      return;
    }
    if (response["status"] == 200 && response["data"]["body"]["user"] == null) {
      fToast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Text(
            "User does not exist in the faysal ecosystem",
            textAlign: TextAlign.center,
            style: MyFaysalTheme.of(context).text1,
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      transferFaysal = null;
      notifyListeners();
      return;
    }
    transferFaysal = UserModel.fromJson(response["data"]);

    notifyListeners();
  }

  Future<void> getUserBank(
      String bankCode, String accountNumber, BuildContext context) async {
    FToast fToast = FToast().init(context);
    var response =
        await HttpResponse().getExternalUserDetails(bankCode, accountNumber);
    if (kDebugMode) print(response);
    if (response["status"] != 200 ) {
      userBankName = null;
      notifyListeners();
      return;
    }
    if ((response["status"] == 200 && response["data"] == null) || response["data"]["accountName"].toString().toLowerCase() == "na") {
      fToast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Text(
            "Invalid Account number",
            textAlign: TextAlign.center,
            style: MyFaysalTheme.of(context).text1,
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      userBankName = null;
      notifyListeners();
      return;
    }
    userBankName = response["data"]["accountName"];

    notifyListeners();
  }

  void resetBankName() {
    userBankName = null;
    notifyListeners();
  }

  Future<void> internalTransfer(
    BuildContext context,
  ) async {
    FToast fToast = FToast().init(context);
    var response = await HttpResponse().internalTransfer(
        amount.toString(), accountNumer.toString(), pin!, description!);
    if (kDebugMode) print(response);
    if (response["status"] != 200) {
      fToast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Text(
            response["data"],
            textAlign: TextAlign.center,
            style: MyFaysalTheme.of(context).text1,
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      return;
    }
    await showTransferSuccess(transferFaysal!.name, amount.toString());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AppNavigator()),
        (route) => false);
    resetAll();
    // call();
  }

  Future<void> externalTransfer(BuildContext context) async {
    FToast fToast = FToast().init(context);
    var response = await HttpResponse().externalTransfer(
        amount.toString(),
        accountNumer!.toString(),
        pin!,
        bankCode!.bankCode,
        description!);
    if (response["status"] != 200) {
      fToast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Text(
            response["data"],
            textAlign: TextAlign.center,
            style: MyFaysalTheme.of(context).text1,
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      return;
    }
    transactionHistory =
        HistoryModel.fromJson(response["data"]["trax_details"]);
    await showTransferSuccess(userBankName!, amount.toString());
    // (){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AppNavigator()),
        (route) => false);
    resetAll();
    resetBankName();
    // };
  }
}

enum Update { amount, acccountnum, bankcode, pin, description }
