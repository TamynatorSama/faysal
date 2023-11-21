// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class HttpResponse {
  //auth
  Future verifyEmailToken(String email) async {
    var uri = baseUrl + "verification/verifyEmail?email=$email";

    try {
      var response = await http.get(Uri.parse(uri)).timeout(const Duration(seconds: 45));

      if (response.statusCode == 200) {
        var useable = jsonDecode(response.body);
        return {"status": 200, "data": useable};
      } else if (response.statusCode == 403) {
        var useable = jsonDecode(response.body);
        return {"status": 403, "data": useable["errors"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  Future registerUserNative(Map body) async {
    var uri = baseUrl + "auth/createUser";

    dynamic data = {
      "name": body["name"],
      "email": body["email"],
      "password": body["password"],
      "phone": body["phone"],
      "pin": int.parse(body["pin"]),
      "email_token": body["email_token"]
    };

    try {
      var response = await http.post(Uri.parse(uri),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data)).timeout(const Duration(seconds: 45));
      var useable = jsonDecode(response.body);
      // print(response.statusCode);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable};
      } else if (response.statusCode == 403) {
        return {"status": 403, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "unable to communicate with server"};
    }
  }

  Future login(String email, String password, String deviceName) async {
    var uri = baseUrl + "auth/login";
    // print(uri);

    try {
      var response = await http.post(Uri.parse(uri), body: {
        "email": email,
        "password": password,
        "device_name": deviceName
      }).timeout(const Duration(seconds: 45));
      var useable = jsonDecode(response.body);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable};
      } else if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["data"]["${useable["data"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  Future getPasswordResetToken(
    String email,
  ) async {
    var uri = baseUrl + "auth/getResetPasswordToken";

    try {
      var response = await http.post(Uri.parse(uri), body: {
        "email": email,
      }).timeout(const Duration(seconds: 45));
      var useable = jsonDecode(response.body);
      if(kDebugMode)print(useable);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable["email_token"]};
      } else if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["data"]["${useable["data"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  Future changePassword(
    String confirmPassword,
    String password,
  ) async {
    var uri = baseUrl + "auth/changePassword";

    try {
      var response = await http.post(Uri.parse(uri), body: {
        "password": password,
        "password_confirmation": confirmPassword
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      }).timeout(const Duration(seconds: 45));
      var useable = jsonDecode(response.body);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable["message"]};
      } else if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["data"]["${useable["data"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  Future forgotPassword(String email, String password,
      String passwordConfirmation, String resetPasswordToken) async {
    var uri = baseUrl + "auth/resetPassword";

    try {
      var response = await http.post(Uri.parse(uri), body: {
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "reset_password_token": resetPasswordToken
      }).timeout(const Duration(seconds: 45));
      var useable = jsonDecode(response.body);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable};
      } else if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["data"]["${useable["data"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  Future changeTransactionPin(String securityAnswer, String pin) async {
    var uri = baseUrl + "auth/changePin";

    try {
      var response = await http.post(Uri.parse(uri), body: {
        "pin": pin,
        "pin_confirmation": pin,
        "security_answer": securityAnswer.trim()
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      }).timeout(const Duration(seconds: 45));
      var useable = jsonDecode(response.body);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable};
      } else if (response.statusCode == 403) {
        return {"status": 403, "data": useable["errors"].first};
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }
  // auth/changePin

  Future setSecurityQuestion(
    String question,
    String answer,
  ) async {
    var uri = baseUrl + "profile/setSecurityQuestion";

    try {
      var response = await http.post(Uri.parse(uri), body: {
        "security_question": question,
        "security_answer": answer,
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      }).timeout(const Duration(seconds: 45));
      var useable = jsonDecode(response.body);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable};
      } else if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["data"]["${useable["data"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  static Future getSecurityQuestions() async {
    var uri = baseUrl + "utils/getSecurityQuestion";

    try {
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"}).timeout(const Duration(seconds: 45)).timeout(const Duration(seconds: 45));
      var useable = jsonDecode(response.body);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": true, "data": useable["question"] ?? []};
      } else if (response.statusCode == 403) {
        return {
          "status": false,
          "data": useable["data"]["${useable["data"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": false, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": false, "data": "Unable to communicate with server"};
    }
  }

  Future logout() async {
    var uri = baseUrl + "auth/logout";

    try {
      var response = await http.post(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"}).timeout(const Duration(seconds: 45)).timeout(const Duration(seconds: 45));

      var useable = jsonDecode(response.body);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable};
      } else if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["data"]["${useable["data"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }
  // end of auth

  Future getProfile() async {
    var uri = baseUrl + "profile/userProfile";

    try {
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"}).timeout(const Duration(seconds: 45));

      var useable = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {"status": 200, "data": useable};
      } else if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["data"]["${useable["data"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  // get general settings
  static Future getGeneralSettings() async {
    var uri = baseUrl + "utils/getSettings";

    try {
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"}).timeout(const Duration(seconds: 45));

      var usable = jsonDecode(response.body);

      if (usable["status"]) {
        return {"status": true, "data": usable["body"]["settings"]};
      }
      return {"status": false, "message": usable["message"]};
    } catch (e) {
      return {"status": false, "message": "unable to communicate with server"};
    }
  }

  static Future uploadProfilePics(String filePath) async {
    var uri = baseUrl + "profile/uploadProfileImage";

    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.headers.addAll({"Authorization": "Bearer ${Login().userToken}"});

    try {
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('imgFile', filePath);

      request.files.add(multipartFile);

      http.StreamedResponse response = await request.send();

      final newRes = await http.Response.fromStream(response);
      var usable = jsonDecode(newRes.body);
      // print(usable);
      if (usable["status"]) {
        return {"status": true, "data": usable["body"]["avatar"]};
      }
      else if(!usable["status"] && usable["errors"] != null){
        return {"status": false, "data": usable["errors"].values.first.first};
      }
      else if(!usable["status"] && usable["error"] != null){
        return {"status": false, "data": usable["error"].toString().split("(").first};
      }
      else{
        return {"status": false, "data": usable["message"]};
      }
    } catch (e) {
      return {"status": false, "data": "unable to communicate with server"};
    }
  }

  Future getUser(String phone) async {
    var uri = baseUrl + "profile/getUser?phone=$phone";

    try {
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"}).timeout(const Duration(seconds: 45));
      // print(response.body);

      var useable = jsonDecode(response.body);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable};
      } else if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["data"]["${useable["error"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      } else if (response.statusCode == 401 || useable["status"] == false) {
        return {"status": 500, "data": useable["error"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  Future getExternalUserDetails(String bankCode, String accountNumber) async {
    var uri = baseUrl + "utils/accountLookup";

    try {
      var response = await http.post(Uri.parse(uri),
          body: {"accountNumber": accountNumber, "beneficiaryBank": bankCode},
          headers: {"Authorization": "Bearer ${Login().userToken}"}).timeout(const Duration(seconds: 45));

      var useable = jsonDecode(response.body);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable["token"]};
      } else if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["data"]["${useable["error"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      } else if (response.statusCode == 401 || useable["status"] == false) {
        return {"status": 500, "data": useable["error"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  Future internalTransfer(
      String amount, String phone, String pin, String narration) async {
    var uri = baseUrl + "transactions/internalTransfer";

    try {
      var response = await http.post(Uri.parse(uri), body: {
        "amount": amount,
        "pin": pin,
        "phone": phone.startsWith("0") ? phone : "0$phone",
        "narration": narration
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      }).timeout(const Duration(seconds: 45));

      var useable = jsonDecode(response.body);
      // print(useable);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable["body"]};
      }
      if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["errors"]["${useable["errors"].keys.toList().first}"]
              [0]
        };
      }
      if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  Future externalTransfer(String amount, String accountNumber, String pin,
      String bankCode, String description) async {
    var uri = baseUrl + "transactions/externalTransfer";

    try {
      var response = await http.post(Uri.parse(uri), body: {
        "amount": amount,
        "pin": pin,
        "account_number": accountNumber,
        "bankCode": bankCode,
        "narration": description,
      }, headers: {
        "Authorization": "Bearer ${Login().userToken}"
      }).timeout(const Duration(seconds: 45));

      var useable = jsonDecode(response.body);

      if (useable["status"] == true) {
        return {"status": 200, "data": useable["body"]};
      } else if (!useable["status"] && useable["errors"] != null) {
        Type type = useable["errors"].runtimeType;
        if (type == String) {
          return {"status": 400, "data": useable["errors"]};
        } else {
          return {"status": 400, "data": useable["errors"].values.first};
        }
      } else {
        return {"status": 400, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  Future getBanks() async {
    var uri = baseUrl + "utils/getBanks";

    try {
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"}).timeout(const Duration(seconds: 45));

      var useable = jsonDecode(response.body);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable["body"]["banks"]};
      } else if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["data"]["${useable["data"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      } else if (response.statusCode == 401 || useable["status"] == false) {
        return {"status": 500, "data": useable["error"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  Future getTransactionHistory(String filter) async {
    var uri = baseUrl + "transactions/getTransactions?$filter";

    try {
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": "Bearer ${Login().userToken}"}).timeout(const Duration(seconds: 45));

      var useable = jsonDecode(response.body);
      // print(useable);

      if (response.statusCode == 200 || useable["status"] == true) {
        return {"status": 200, "data": useable["body"]["transactions"]};
      } else if (response.statusCode == 403) {
        return {
          "status": 403,
          "data": useable["data"]["${useable["data"].keys.toList()[0]}"][0]
        };
      } else if (response.statusCode == 401) {
        return {"status": 401, "data": useable["message"]};
      } else if (response.statusCode == 401 || useable["status"] == false) {
        return {"status": 500, "data": useable["message"]};
      }
    } catch (e) {
      return {"status": 500, "data": "Unable to communicate with server"};
    }
  }

  static Future verifyPin(String pin) async {
    var uri = baseUrl + "verification/verifyTransactionPin";

    try {
      var response = await http.post(Uri.parse(uri),
          body: {"pin": pin},
          headers: {"Authorization": "Bearer ${Login().userToken}"}).timeout(const Duration(seconds: 45));
      var usable = jsonDecode(response.body);
      if (usable["status"]) {
        return {"status": true, "data": usable["message"]};
      }
      return {"status": false, "data": usable["errors"]};
    } catch (e) {
      return {"status": false, "data": "Unable to communicate with server"};
    }
  }
}
