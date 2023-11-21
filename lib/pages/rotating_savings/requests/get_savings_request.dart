import 'dart:convert';

import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/constants.dart';

import "package:http/http.dart" as http;

class GetRotationalSavingsRequest {
  Future getRotationalSavings([String? ajoCode]) async {
    String uri;
    if (ajoCode != null) {
      uri = "${baseUrl}crs/getRotatingSavings?ajo_code=$ajoCode";
    } else {
      uri = "${baseUrl}crs/getRotatingSavings";
    }

    try {
      var getResponse = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(getResponse.body);

      if (usable["status"]) {
        return {"status": true, "data": usable["body"]["rotatingSavings"]};
      }
      return {"status": false, "message": usable["message"]};
    } catch (e) {
      return {"status": false, "message": "unable to communicate with server"};
    }
  }

  Future getMyRotationalSavings() async {
    var uri = "${baseUrl}mycrs/getMyRotatingSavings";

    try {
      var getResponse = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(getResponse.body);
      // print(usable);

      if (usable["status"]) {
        return {"status": true, "data": usable["body"]["myRotatingSavings"]};
      }
      return {"status": false, "message": usable["message"]};
    } catch (e) {
      return {"status": false, "message": "unable to communicate with server"};
    }
  }

  Future getMyRotationalSavingsSumarry(String ajoId) async {
    var uri = "${baseUrl}crs/getSavingsSummary?id=$ajoId";

    try {
      var getResponse = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(getResponse.body);

      if (usable["status"]) {
        return {"status": true, "data": usable["body"]["summary"]};
      }
      return {"status": false, "message": usable["message"]};
    } catch (e) {
      return {"status": false, "message": "unable to communicate with server"};
    }
  }

  static Future getMyRotationalMembers(int ajoId) async {
    var uri = "${baseUrl}crs/getRotatingSavingsMembers?id=$ajoId";

    try {
      var getResponse = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(getResponse.body);


      if (usable["status"]) {
        return {"status": true, "data": usable["body"]};
      }
      return {"status": false, "data": usable["message"]};
    } catch (e) {
      return {"status": false, "data": "unable to communicate with server"};
    }
  }

  static Future getDisbursementHistory(int ajoId) async {
    var uri = "${baseUrl}mycrs/getDisbursementHistory?id=$ajoId";

    try {
      var getResponse = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(getResponse.body);

      if (usable["status"]) {
        return {"status": true, "data": usable["body"]};
      }
      return {"status": false, "message": usable["message"]};
    } catch (e) {
      return {"status": false, "message": "unable to communicate with server"};
    }
  }
}
