// ignore_for_file: use_build_context_synchronously


import 'package:faysal/services/http_class.dart';
import 'package:faysal/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final httpCall = HttpResponse();

class SignUpProvider extends ChangeNotifier {
  Map<String, dynamic> userInfo = {};
  void populateUserInfo(String key, dynamic value) {
    userInfo[key] = value;
    notifyListeners();
  }

  Future getVerificationToken(FToast toast, VoidCallback call, String email,
      BuildContext context) async {
    var response = await httpCall.verifyEmailToken(email);

    FToast fToast = FToast();
    fToast.init(context);

    if (response["status"] != 200) {
      // Fluttertoast.showToast(msg: response["data"],gravity: ToastGravity.TOP,);
      fToast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Text(
            response["data"],
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: "Popppins", color: Colors.white),
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      return;
    }
    userInfo['email_token'] = response["data"]["email_token"];
    // print(response["data"]["email_token"]);
    call();
  }

  Future registerUser(Map data, VoidCallback callback, BuildContext context,
      VoidCallback error, Future Function() login) async {
    var response = await httpCall.registerUserNative(data);
    FToast fToast = FToast();
    fToast.init(context);

    if(response == null){
      fToast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: const Text(
            "unable to communicate with server",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Poppins", color: Colors.white),
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      return;
    }

    if (response["status"] == 200) {
      await login();
      callback();
      return;
    }

    if (response["status"] != 200) {
      if (response["status"] == 403) {
        showToast(context, response["data"]);
        // await showModalBottomSheet(
        //     backgroundColor: Colors.transparent,
        //     context: context,
        //     builder: (context) => FeedbackComponent(context, FeedbackType.error,
        //         response["data"]["${response["data"].keys.toList()[0]}"][0]));
        if (response["data"].keys.toList()[0] == "phone") {
          error();
        }
        return;
      }
      fToast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Text(
            response["data"],
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      return;
    }
  }
}
