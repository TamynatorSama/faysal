import 'dart:convert';

import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/constants.dart';
import "package:http/http.dart" as http;

class JoinSavingsRequest{

  static Future joinSavings(
      String ajoId,
      String numberOfHands
      ) async {
    var uri = "${baseUrl}mycrs/joinRotatingSavings?id=$ajoId&number_of_hand=$numberOfHands";

    try {
      var response = await http.get(Uri.parse(uri), headers: {
        "Authorization": "Bearer ${Login().userToken}"
      });

      var usable = jsonDecode(response.body);


      if (usable["status"] == true) {
        return {"status": true, "data": usable["message"]};
      } 
      if(usable["errors"] != null){
        Type type = usable["errors"].runtimeType;
        if(type == String){
          return {"status": false, "data": usable["errors"]};
        }
        return {"status": false, "data": usable["errors"].values.first.first};
      }

      return {"status": false, "data": usable["message"]};
    } catch (e) {
      return {"status": false, "data": "Unable to communicate with the server"};
    }
  }

}