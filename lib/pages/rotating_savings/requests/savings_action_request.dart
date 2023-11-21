import 'dart:convert';

import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/constants.dart';
import "package:http/http.dart" as http;

class SavingsActionRequests {
  static Future startAjo(int ajoId) async {
    var uri = "${baseUrl}crs/startRotatingSavings";

    try {
      var getResponse = await http.patch(Uri.parse(uri),
          body: {"id": ajoId.toString()},
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(getResponse.body);
      // print(usable);

      if (usable["status"]) {
        return {"status": true, "data": usable["message"]};
      }
      return {"status": false, "data": usable["errors"]};
    } catch (e) {
      return {"status": false, "data": "unable to communicate with server"};
    }
  }

  static Future deleteAjo(int ajoId) async {
    var uri = "${baseUrl}crs/deleteRotatingSavings?id=$ajoId}";
    try {
      var getResponse = await http.delete(Uri.parse(uri),
          body: {"id": ajoId.toString()},
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(getResponse.body);
      // print(usable);

      if (usable["status"]) {
        return {"status": true, "data": usable["message"]};
      }
      return {"status": false, "data": usable["errors"]};
    } catch (e) {
      // print(e);
      return {"status": false, "data": "unable to communicate with server"};
    }
  }

  static Future approveRotatingSavingsMemberShip(
      int ajoId, String userId) async {
    var uri = "${baseUrl}crs/approveRotatingSavingsMemberShip?id=$ajoId";

    try {
      var getResponse = await http.patch(Uri.parse(uri),
          body: {"id": userId},
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(getResponse.body);

      if (usable["status"]) {
        return {"status": true, "data": usable["message"]};
      }
      return {"status": false, "message": usable["message"]};
    } catch (e) {
      return {"status": false, "message": "unable to communicate with server"};
    }
  }

  static Future rejectRotatingSavingsMemberShip(
      int ajoId, String memberId) async {
    var uri = "${baseUrl}crs/rejectRotatingSavingsMemberShip?id=$ajoId";

    try {
      var getResponse = await http.delete(Uri.parse(uri),
          body: {"id": memberId},
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(getResponse.body);
      // print(usable);

      if (usable["status"]) {
        return {"status": true, "data": usable["message"]};
      }
      return {"status": false, "data": usable["message"]};
    } catch (e) {
      return {"status": false, "data": "unable to communicate with server"};
    }
  }

  static Future makeContribution(int ajoId) async {
    var uri = "${baseUrl}mycrs/makeContribution?id=$ajoId";

    try {
      var getResponse = await http.patch(Uri.parse(uri),
          body: {"id": ajoId.toString()},
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(getResponse.body);
      // print(usable);

      if (usable["status"]) {
        return {"status": true, "data": usable["message"]};
      }
      return {"status": false, "data": usable["message"]};
    } catch (e) {
      return {"status": false, "data": "unable to communicate with server"};
    }
  }
}
