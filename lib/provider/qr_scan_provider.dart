// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:faysal/app_navigator.dart';
import 'package:faysal/main.dart';
import 'package:faysal/models/history_model.dart';
import 'package:faysal/pages/scan/model/listener_model.dart';
import 'package:faysal/pages/scan/model/qrmodel.dart';
import 'package:faysal/pages/scan/qr_pin_confirmation.dart';
import 'package:faysal/pages/scan/requests/qr_transfer.dart';
import 'package:faysal/provider/buttom_nav_providr.dart';
import 'package:faysal/services/http_class.dart';
import 'package:faysal/utils/formatter.dart';
import 'package:faysal/utils/functions.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class QrScanProvider extends ChangeNotifier {
  String amount = "";
  String description = "";
  String transactionRef = "";
  bool isLoading = false;
  bool? isSenderState;
  late QrModel qrcode;
  late ListenerEventModel event;
  late HistoryModel transactionHistory;





  String generateUniqueTransactionRef(){
    var uuid = const Uuid().v4();
    var generatedString = "faysal${DateTime.fromMillisecondsSinceEpoch(1640979000000).toString()}|$uuid";
    transactionRef = generatedString;
    return generatedString;
  }
  Future<bool> initiateTransaction(BuildContext context)async{
    var response = await QrTransferRequests.initializeTransfer(transactionRef, RemoveSeparator(amount).toString());
    if(response){
      return true;
    }
    showToast(context, response["data"]);
    return false;
  }

  void checkScanStatus(BuildContext context,String qrRef, bool isSender,[VoidCallback? call]){
    late Timer timer;
    isSenderState = isSender;
    

    timer = Timer.periodic(const Duration(seconds: 5),(time)async{
      if( ! await checkNetworkConnection(false)){
        showToast(context, "No Internet Connection");
        return;
      }
      if(!isSender){
        isLoading = true;
        notifyListeners();
      }
      var response = await QrTransferRequests.checkStatusCallBack(qrRef);

      if(!response["status"] && response["data"].toString().toLowerCase().contains("not yet")){
        resetAll();
        timer.cancel();
        showToast(MyApp.navigationKey.currentContext!, "Transaction cancelled");
        Provider.of<ButtomNavBarProvider>(context,listen: false).changePage(0);
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const AppNavigator()), (route) => false);
      return;
      }
      
      if(response["data"]["receiver"] != null){
        if(isSender || response["data"]["event"]["status"].toString().toLowerCase() == "completed"){
          if(!isSender){
            isLoading = false;
            notifyListeners();
            call!();
          }
          timer.cancel();
        }
        event = ListenerEventModel.fromJson(response["data"]);
        
        if(isSender){
          Navigator.push(context,MaterialPageRoute(builder: (context) => const QrPinConfirmation())); 
        }
      }
    });
  }

  Future<void> internalTransfer(BuildContext context, VoidCallback call,String pin) async {
    var response = await HttpResponse().internalTransfer(
        RemoveSeparator(amount).toString(), event.reciever.phone, pin, description);
    if (response["status"] != 200) {
     showToast(context, response["data"]);
      return;
    }
    transactionHistory = HistoryModel.fromJson(response["data"]["trax_datails"]);
    call();
  }


  

  Future<bool> acceptTransaction(String transactionRefFromQr,BuildContext context)async{
    if(!transactionRefFromQr.contains("faysal")){
      return false;
    }
    var response = await QrTransferRequests.acceptTransaction(transactionRefFromQr);
    if(response["status"]){
      qrcode = QrModel.fromJson(response["data"]);
      return true;
    }
    showToast(context, response["data"]);
    return false;
  }

  Future cancelTransaction(String transactionRefFromQr,BuildContext context,[bool? byReciever])async{
    var response = await QrTransferRequests.cancelTransaction(transactionRefFromQr);
    if(response["status"]){
      resetAll();
      if(byReciever ==null){
        showToast(context, response["data"]);
      }
      Provider.of<ButtomNavBarProvider>(context,listen: false).changePage(0);
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const AppNavigator()), (route) => false);
      return;
    }
    showToast(context, response["data"]);
  }

  void resetAll() {
    amount = "";
    description = "";
    transactionRef = "";
    isLoading = false;
    isSenderState = null;
  }
}
