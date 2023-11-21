import 'dart:convert';

import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/constants.dart';
import 'package:http/http.dart' as http;

class MakeTopup {
  static String sectionUrl = "${baseUrl}recharge";

  static Future buyVTU(
      String amount, String provider, String phoneNumber, String pin) async {
    try {
      var response = await http.post(Uri.parse("$sectionUrl/buyVTU"), body: {
        "amount": amount,
        "phone": phoneNumber,
        // "phone": "08011111111",
        "network": provider,
        "pin": pin
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      }).timeout(const Duration(seconds: 45));
      var usable = jsonDecode(response.body);
      if (usable["status"]) {
        return ({"status": true, "data": usable["body"]});
      }
      if(usable["errors"] !=null){
        return ({
        "status": false,
        "data": usable["errors"].values.first
      });
      
      }
      return ({
        "status": false,
        "data": usable["message"]
      });
    } catch (e) {
      return ({
        "status": false,
        "data": "unable to communicate with the server"
      });
    }
  }

  static Future buyData(
      String variationCode, String serviceID, String phoneNumber, String pin) async {
    try {
      var response = await http.post(Uri.parse("$sectionUrl/buyDATA"), body: {
        "variation_code": variationCode,
        "phone": phoneNumber,
        // "phone": "08011111111",
        "serviceID": serviceID,
        "pin": pin
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      }).timeout(const Duration(seconds: 45));
      var usable = jsonDecode(response.body);
      if (usable["status"]) {
        return ({"status": true, "data": usable["message"]});
      }
      if(usable["errors"] !=null){
        return ({
        "status": false,
        "data": usable["errors"].values.first.first
      });
      
      }
      return ({
        "status": false,
        "data": usable["message"]
      });
    } catch (e) {
      return ({
        "status": false,
        "data": "unable to communicate with the server"
      });
    }
  }




  static Future getserviceVariationsData(String variation) async {
    try {
      var response = await http.get(
          Uri.parse(
              "$sectionUrl/getserviceVariationsData?serviceID=$variation"),
          headers: {"Authorization": "Bearer ${Login().userToken}"}).timeout(const Duration(seconds: 45));
      var usable = jsonDecode(response.body);
      // print(usable);

      if (usable["status"]) {
        return ({"status": true, "data": usable["body"]["variations"]});
      }
      if (usable["errors"] != null) {
        return ({
          "status": false,
          "data": usable["errors"]["${usable["errors"].keys.toList().first}"][0]
        });
      }
      return ({"status": false, "data": usable["message"]});
    } catch (e) {
      return ({
        "status": false,
        "data": "unable to communicate with the server"
      });
    }
  }
}
