// ignore_for_file: use_build_context_synchronously
import 'package:faysal/pages/topup/model/variation_model.dart';
import 'package:faysal/pages/topup/requests/make_topup.dart';
import 'package:faysal/utils/formatter.dart';
import 'package:faysal/utils/functions.dart';
import 'package:flutter/material.dart';

class RechargeProvider extends ChangeNotifier {
  String provider = "mtn";
  String number = "";
  String amount = "";
  String serviceID = "";
  String pin = "";
  VariationModel? data;
  List<VariationModel> mtnVariation = [];
  List<VariationModel> gloVariation = [];
  List<VariationModel> airtelVariation = [];
  List<VariationModel> etisalatVariation = [];

  void resetAll() {
    provider = "";
    number = "";
    amount = "";
    serviceID = "";
    pin = "";
    data = null;
    notifyListeners();
  }

  Future<bool> buyAirtime(BuildContext context) async {
    var response = await MakeTopup.buyVTU(
        RemoveSeparator(amount).toString(), provider, number, pin);

    if (response["status"]) {
      await showTopUpSuccess(number);

      resetAll();
      return true;
    }
    showToast(context, response["data"]);
    return false;
  }

  Future getAllVariations(BuildContext context,[bool? init]) async {
    if (airtelVariation.isEmpty) {
      await getAirtelserviceVariationsData(context, true);
    }

    if (mtnVariation.isEmpty) {
      await getMtnserviceVariationsData(context, true);
    }

    if (gloVariation.isEmpty) {
      await getGloserviceVariationsData(context, true);
    }

    if (etisalatVariation.isEmpty) {
      await getEtisalatserviceVariationsData(context, true);
    }
    if(init == null){
      notifyListeners();
    }
    
  }

  void setProivder(String network) {
    provider = network;
    notifyListeners();
  }

  Future getEtisalatserviceVariationsData(
      BuildContext context, bool isInit) async {
    var service = await MakeTopup.getserviceVariationsData("etisalat-data");
    if (service["status"]) {
      etisalatVariation = (service["data"] as List)
          .map((e) => VariationModel.fromJson(e))
          .toList();
      notifyListeners();
      return;
    }
    if (!isInit) {
      showToast(context, service["data"]);
    }
  }

  Future getAirtelserviceVariationsData(
      BuildContext context, bool isInit) async {
    var service = await MakeTopup.getserviceVariationsData("airtel-data");
    if (service["status"]) {
      airtelVariation = (service["data"] as List)
          .map((e) => VariationModel.fromJson(e))
          .toList();
      notifyListeners();
      return;
    }
    if (!isInit) {
      showToast(context, service["data"]);
    }
  }

  Future getMtnserviceVariationsData(BuildContext context, bool isInit) async {
    var service = await MakeTopup.getserviceVariationsData("mtn-data");
    if (service["status"]) {
      mtnVariation = (service["data"] as List)
          .map((e) => VariationModel.fromJson(e))
          .toList();
      notifyListeners();
      return;
    }
    if (!isInit) {
      showToast(context, service["data"]);
    }
  }

  Future getGloserviceVariationsData(BuildContext context, bool isInit) async {
    var service = await MakeTopup.getserviceVariationsData("glo-data");
    if (service["status"]) {
      gloVariation = (service["data"] as List)
          .map((e) => VariationModel.fromJson(e))
          .toList();
      notifyListeners();
      return;
    }
    if (!isInit) {
      showToast(context, service["data"]);
    }
  }

  Future<bool> buyData(BuildContext context) async {
    var response =
        await MakeTopup.buyData(data!.variationCode, serviceID, number, pin);

    if (response["status"]) {
      await showTopUpSuccess(number);

      resetAll();
      return true;
    }
    showToast(context, response["data"]);
    return false;
  }
}
