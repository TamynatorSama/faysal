import 'dart:convert';

import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/constants.dart';

import 'package:http/http.dart' as http;

class BillsPayment {
  static String sectionUrl = "${baseUrl}recharge";

  static Future verifyCardDetails(String serviceId, String billersCode) async {
    try {
      var response =
          await http.post(Uri.parse("$sectionUrl/verifyCardDetails"), body: {
        "serviceID": serviceId,
        "billersCode": billersCode,
        // "billersCode": "1212121212",
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      }).timeout(const Duration(seconds: 45));

      // print(response.body);


      var usable = jsonDecode(response.body);

      if (usable["status"]) {
        return ({"status": true, "data": usable["body"]});
      }

      return ({"status": false, "data": usable["message"]});

    } catch (e) {
      return ({"status": false, "data": "unable to comminicate with server"});
    }
  }

  static Future payTvBill(String serviceId, String billersCode,String variationCode,String pin,String phone) async {
    try {
      var response =
          await http.post(Uri.parse("$sectionUrl/buyTVSubscription"), body: {
        "serviceID": serviceId,
        "billersCode": billersCode,
        // "billersCode": "1212121212",
        "variation_code": variationCode,
        "phone": phone,
        "pin":pin
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      }).timeout(const Duration(seconds: 45));

      var usable = jsonDecode(response.body);

      if (usable["status"]) {
        return ({"status": true, "data": usable["body"]});
      }
      if(usable["errors"] !=null){
        return ({"status": false, "data": usable["errors"].values.first[0]});
      }

      return ({"status": false, "data": usable["message"]});

    } catch (e) {
      return ({"status": false, "data": "unable to comminicate with server"});
    }
  }



  static Future verifyMeterDetails(String serviceId, String billersCode,String type) async {
    try {
      var response =
          await http.post(Uri.parse("$sectionUrl/verifyMetre"), body: {
        "serviceID": serviceId,
        "billersCode": billersCode,
        // "billersCode": "1111111111111",
        "type": type
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      }).timeout(const Duration(seconds: 45));
      
      // print(response.body);
      


      var usable = jsonDecode(response.body);

      if (usable["status"]) {
        return ({"status": true, "data": usable["body"]});
      }

      return ({"status": false, "data": usable["message"]});

    } catch (e) {
      return ({"status": false, "data": "unable to comminicate with server"});
    }
  }




  static Future payElectricityBill(String serviceId, String billersCode,String variationCode,String pin,String phone,String amount) async {
    try {
      var response =
          await http.post(Uri.parse("$sectionUrl/buyElectricity"), body: {
        "serviceID": serviceId,
        "billersCode": billersCode,
        // "billersCode": "1212121212",
        "variation_code": variationCode,
        "phone": phone,
        "pin":pin,
        "amount": amount
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      }).timeout(const Duration(seconds: 45));

      var usable = jsonDecode(response.body);

      if (usable["status"]) {
        return ({"status": true, "data": usable["body"]});
      }
      if(usable["errors"] !=null){
        return ({"status": false, "data": usable["errors"].values.first[0]});
      }

      return ({"status": false, "data": usable["message"]});

    } catch (e) {
      return ({"status": false, "data": "unable to comminicate with server"});
    }
  }

}



