// ignore_for_file: use_build_context_synchronously
import 'package:faysal/app_navigator.dart';
import 'package:faysal/pages/bills/requests/bills_payment_req.dart';
import 'package:faysal/pages/bills/requests/model/meter_details_model.dart';
import 'package:faysal/pages/bills/requests/model/verified_card_model.dart';
import 'package:faysal/pages/topup/model/variation_model.dart';
import 'package:faysal/pages/topup/requests/make_topup.dart';
import 'package:faysal/utils/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BillProivder extends ChangeNotifier {
  String provider = "";
  String verifiedCardNumber = "";
  String verifiedUserMeter = "";
  String electricityProvider = "";
  String electricityType = "";
  String variationCode = "";
  String pin = "";
  List<VariationModel> gotv = [];
  List<VariationModel> dstv = [];
  List<VariationModel> star = [];
  VerifieduserCardModel? verifiedUser;
  MeterDetailsModel? verifiedMeter;

  Future getAllVariations(BuildContext context) async {
    if (dstv.isEmpty) {
      await getDstvserviceVariationsData(context, true);
      notifyListeners();
    }

    if (gotv.isEmpty) {
      await getGotvserviceVariationsData(context, true);
      notifyListeners();
    }
    if (star.isEmpty) {
      await getStartimesserviceVariationsData(context, true);
      notifyListeners();
    }
  }

  Future getDstvserviceVariationsData(BuildContext context, bool isInit) async {
    var service = await MakeTopup.getserviceVariationsData("dstv");
    if (service["status"]) {
      dstv = (service["data"] as List)
          .map((e) => VariationModel.fromJson(e))
          .toList();
      notifyListeners();
      return;
    }
    if (!isInit) {
      showToast(context, service["data"]);
    }
  }
  Future getStartimesserviceVariationsData(BuildContext context, bool isInit) async {
    var service = await MakeTopup.getserviceVariationsData("startimes");
    if (service["status"]) {
      star = (service["data"] as List)
          .map((e) => VariationModel.fromJson(e))
          .toList();
      notifyListeners();
      return;
    }
    if (!isInit) {
      showToast(context, service["data"]);
    }
  }

  Future getGotvserviceVariationsData(BuildContext context, bool isInit) async {
    var service = await MakeTopup.getserviceVariationsData("gotv");
    if (service["status"]) {
      gotv = (service["data"] as List)
          .map((e) => VariationModel.fromJson(e))
          .toList();
      notifyListeners();
      return;
    }
    if (!isInit) {
      showToast(context, service["data"]);
    }
  }

  Future getUserCardDetails(
      String tvProvider, String cardNumber, BuildContext context) async {
    var response = await BillsPayment.verifyCardDetails(tvProvider, cardNumber);

    if (response["status"]) {
      verifiedCardNumber = cardNumber;
      provider = tvProvider;
      verifiedUser = VerifieduserCardModel.fromJson(response["data"]);
      return;
    }
    showFeedbackToast(response["data"], true, context);
  }

  Future buySubscription(String phone, BuildContext context,String name) async {
    var response = await BillsPayment.payTvBill(
        provider, verifiedCardNumber, variationCode, pin, phone);
    if(kDebugMode) print(response);

    if (response["status"]) {

      await showTransferSuccess(name, verifiedCardNumber,true);
      resetAll();
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>const AppNavigator()),(route)=>false);

      return true;
    }
    showToast(context, response["data"]);
    resetAll();
    return false;
  }



  Future getUserMeterDetails(
      String electricityProvider, String meterNumber,String type,BuildContext context) async {
    var response = await BillsPayment.verifyMeterDetails(electricityProvider,meterNumber, type);
    // print("object");

    if (response["status"]) {
      verifiedUserMeter =meterNumber;
      electricityProvider = electricityProvider;
      electricityType = type;
      verifiedMeter = MeterDetailsModel.fromJson(response["data"]);
      return;
    }
    showToast(context, response["data"]);
  }

  Future buyElectricity(String phone,String amount,BuildContext context) async {
    var response = await BillsPayment.payElectricityBill(
        electricityProvider, verifiedUserMeter, electricityType, pin, phone,amount);
    if(kDebugMode) print(response);

    if (response["status"]) {

      await showTransferSuccess(electricityProvider.replaceAll("-", " ").capitalize(" "), amount,false);
      resetAll();
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>const AppNavigator()),(route)=>false);

      return true;
    }
    showToast(context, response["data"]);
    resetAll();
    return false;
  }

  resetAll() {
    provider = "";
    verifiedCardNumber = "";
    verifiedMeter = null;
    verifiedUserMeter = "";
    electricityProvider = "";
    electricityType = "";
    variationCode = "";
    verifiedUser = null;
  }
}
