import 'dart:convert';

import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/constants.dart';
import "package:http/http.dart" as http;
class QrTransferRequests{
  static Future initializeTransfer(String transferRef,String amount)async{
    var uri = "${baseUrl}qrcodeevent/initiate";

    try{
      var response =  await http.post(Uri.parse(uri),body: {
        "event_ref": transferRef,
        "amount": amount
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      });
      var usable = jsonDecode(response.body);
      if(usable["status"]){
        return true;
      }
      return({
        "status": false,
        "data": usable["message"]
      });
    }
    catch(e){
      return({
        "status": false,
        "data": "unable to communicate with the server"
      });
    }
  }



  static Future checkStatusCallBack(String transferRef)async{
    var uri = "${baseUrl}qrcodeevent/listen";

    try{
      var response =  await http.post(Uri.parse(uri),body: {
        "event_ref": transferRef,
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      });
      var usable = jsonDecode(response.body);
      // print(usable);
      if(usable["status"]){
        return ({
        "status": true,
        "data": usable["body"]
      });
      }
      if(usable["errors"] != null){
        return({
        "status": false,
        "data": usable["errors"]
      });
      }
      return({
        "status": false,
        "data": usable["message"]
      });
    }
    catch(e){
      return({
        "status": false,
        "data": "unable to communicate with the server"
      });
    }
  }
  static Future acceptTransaction(String transferRef)async{
    var uri = "${baseUrl}qrcodeevent/accept";

    try{
      var response =  await http.post(Uri.parse(uri),body: {
        "event_ref": transferRef,
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      });
      var usable = jsonDecode(response.body);
      if(response.statusCode == 200){
        return ({
          "status": true,
          "data": usable["body"]
        });
      }
      return({
        "status": false,
        "data": usable["message"]
      });
    }
    catch(e){
      return({
        "status": false,
        "data": "unable to communicate with the server"
      });
    }
  }
  static Future completeTransaction(String transferRef)async{
    var uri = "${baseUrl}qrcodeevent/complete";

    try{
      var response =  await http.post(Uri.parse(uri),body: {
        "event_ref": transferRef,
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      });
      var usable = jsonDecode(response.body);
      if(response.statusCode == 200){
        return ({
          "status": true,
          "data": usable["body"]
        });
      }
      return({
        "status": false,
        "data": usable["message"]
      });
    }
    catch(e){
      return({
        "status": false,
        "data": "unable to communicate with the server"
      });
    }
  }

  static Future cancelTransaction(String transferRef)async{
    var uri = "${baseUrl}qrcodeevent/cancel";
    // print(transferRef);

    try{
      var response =  await http.post(Uri.parse(uri),body: {
        "event_ref": transferRef,
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      });
      var usable = jsonDecode(response.body);
      // print(usable);
      if(response.statusCode == 200){
        return ({
          "status": true,
          "data": "Transaction Cancelled"
        });
      }
      return({
        "status": false,
        "data": usable["message"]
      });
    }
    catch(e){
      return({
        "status": false,
        "data": "unable to communicate with the server"
      });
    }
  }


}