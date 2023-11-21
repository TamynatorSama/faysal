// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/constants.dart';
import 'package:http/http.dart' as http;

class NotificationRequests{
  static Future getAppNotifications() async {
    var uri = baseUrl + "notifications/getNotifications";

    try {
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(response.body);
      // print(usable);

      if (usable["status"]) {
        return {"status": true, "data": usable["body"]};
      }
      return {"status": false, "message": usable["message"]};
    } catch (e) {
      return {"status": false, "message": "unable to communicate with server"};
    }
  }
  
  static Future getPushNotifications() async {
    var uri = baseUrl + "notifications/getPushNotification";

    try {
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(response.body);

      if (usable["status"]) {
        return {"status": true, "data": usable["body"]};
      }
      return {"status": false, "message": usable["message"]};
    } catch (e) {
      return {"status": false, "message": "unable to communicate with server"};
    }
  }

}