import 'dart:convert';

import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/constants.dart';
import 'package:faysal/utils/formatter.dart';
import "package:http/http.dart" as http;

class CreateFlowRequest {
  Future getFrequency() async {
    var uri = "${baseUrl}crs/getFrequency";

    try {
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(response.body);

      if (usable["status"] == true) {
        return {"status": true, "data": usable["body"]["frequency"]};
      } else {
        return {"status": false, "data": usable["errors"][0]};
      }
    } catch (e) {
      return {"status": false, "data": "Unable to communicate with the server"};
    }
  }

  Future getDisbursement() async {
    var uri = "${baseUrl}crs/getDisbursementDate";

    try {
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"});

      var usable = jsonDecode(response.body);

      if (usable["status"] == true) {
        return {"status": true, "data": usable["body"]["disbursemement"]};
      } else {
        return {"status": false, "data": usable["errors"][0]};
      }
    } catch (e) {
      return {"status": false, "data": "Unable to communicate with the server"};
    }
  }

  static Future createRotationalSavings(
      String ajoName,
      String amount,
      String coordinatorFee,
      String frequencyId,
      String disbursementId,
      String startDate,
      String ajoType,
      String numberOfHands,
      String fee
      ) async {
    var uri = "${baseUrl}crs/createRotatingSavings";

    try {
      var response = await http.post(Uri.parse(uri), body: {
        "ajo_name": ajoName,
        "amount": RemoveSeparator(amount).toString(),
        "frequency_id": frequencyId,
        "disbursement_date_id": disbursementId,
        "number_of_hand": numberOfHands,
        "coordinator_fee": RemoveSeparator(coordinatorFee).toString(),
        "start_date": startDate,
        "ajo_type_id": ajoType,
        "faysal_fee": fee
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      });
      

      var usable = jsonDecode(response.body);
      if (usable["status"] == true) {
        return {"status": true, "data": usable["body"]};
      } else {
        return {"status": false, "data": usable["errors"]["${usable["errors"].keys.toList().first}"][0]};
      }
    } catch (e) {
      return {"status": false, "data": "Unable to communicate with the server"};
    }
  }
}
