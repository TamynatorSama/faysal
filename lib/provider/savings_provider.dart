// ignore_for_file: use_build_context_synchronously

import 'package:faysal/main.dart';
import 'package:faysal/models/ajo_member_model.dart';
import 'package:faysal/models/frequency_model.dart';
import 'package:faysal/models/rotational_savings.dart';
import 'package:faysal/pages/rotating_savings/creation/successful_creation.dart';
import 'package:faysal/pages/rotating_savings/requests/create_flow_requests.dart';
import 'package:faysal/pages/rotating_savings/requests/get_savings_request.dart';
import 'package:faysal/pages/rotating_savings/requests/join_savings.dart';
import 'package:faysal/pages/rotating_savings/requests/savings_action_request.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SavingsProvider extends ChangeNotifier {
  List<SavingDependantModel> frequency = [];
  List<SavingDependantModel> disbursement = [];
  List<RotationalSavingsModel> allSavings = [];
  List<MyRotationalSavingsModel> mySavings = [];
  List<MemberModel> members = [];
  List<MemberModel> membersRequest = [];
  List<MemberModel> allAjoMemebers = [];

  String ajoName = "";
  String amount = "";
  String frequencyId = "";
  String disbursementId = "";
  String numberOfHands = "";
  String coordinatorFee = "";
  String startDate = "";
  String faysalFee = "";
  String ajoType = "";

  Future<void> getFrequency() async {
    var frequencyResponse = await CreateFlowRequest().getFrequency();
    if (frequencyResponse["status"]) {
      var allFrequency = frequencyResponse["data"] as List;

      frequency =
          allFrequency.map((e) => SavingDependantModel.fromJson(e)).toList();
    }
    notifyListeners();
  }

  Future<void> getDisbursement() async {
    var disbursementResponse = await CreateFlowRequest().getDisbursement();
    if (disbursementResponse["status"]) {
      var allFrequency = disbursementResponse["data"] as List;

      disbursement =
          allFrequency.map((e) => SavingDependantModel.fromJson(e)).toList();
    }
    notifyListeners();
  }

  Future getPublicRotationalSavings(BuildContext context,[String? ajoCode]) async {
    FToast toast = FToast();

    toast.init(context);

    var getResponse =
        await GetRotationalSavingsRequest().getRotationalSavings(ajoCode);

    if (getResponse["status"]) {
      var savings = getResponse["data"] as List;

      allSavings =
          savings.map((e) => RotationalSavingsModel.fromJson(e)).toList();

      notifyListeners();
      return;
    }
    allSavings = [];
    notifyListeners();

    toast.showToast(
      gravity: ToastGravity.TOP,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 26, 26),
            borderRadius: BorderRadius.circular(3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Text(
          getResponse["message"],
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
      ),
      toastDuration: const Duration(seconds: 3),
    );
    return;
  }

  Future getMyRotationalSavings(BuildContext context) async {
    FToast toast = FToast();

    toast.init(context);

    var getResponse =
        await GetRotationalSavingsRequest().getMyRotationalSavings();

    if (getResponse["status"]) {
      var savings = getResponse["data"] as List;

      mySavings =
          savings.map((e) => MyRotationalSavingsModel.fromJson(e)).toList();

      notifyListeners();
      return;
    }

    mySavings = [];
    notifyListeners();

    toast.showToast(
      gravity: ToastGravity.TOP,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 26, 26),
            borderRadius: BorderRadius.circular(3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Text(
          getResponse["message"],
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
      ),
      toastDuration: const Duration(seconds: 3),
    );
    return;
  }

  Future<Map<String, dynamic>> createRotationalSavings(
      BuildContext context) async {
    FToast toast = FToast();
    // print(ajoName);

    toast.init(context);

    var getResponse = await CreateFlowRequest.createRotationalSavings(
        ajoName,
        amount,
        coordinatorFee,
        frequencyId,
        disbursementId,
        startDate,
        ajoType,
        numberOfHands,faysalFee);

    if (getResponse["status"]) {
      return {"status": true, "ajoId": getResponse["data"]["ajo_code"]};
    }

    toast.showToast(
      gravity: ToastGravity.TOP,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 26, 26),
            borderRadius: BorderRadius.circular(3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Text(
          getResponse["data"],
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
      ),
      toastDuration: const Duration(seconds: 3),
    );
    return {"status": false, "ajoId": ""};
  }

  Future<bool> joinSavings(
      BuildContext context, String numberOfHands, String ajoId) async {
    FToast toast = FToast();

    toast.init(context);

    var getResponse =
        await JoinSavingsRequest.joinSavings(ajoId, numberOfHands);

    if (getResponse["status"]) {
      toast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Text(
            getResponse["data"],
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );

      notifyListeners();
      return true;
    }

    toast.showToast(
      gravity: ToastGravity.TOP,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 26, 26),
            borderRadius: BorderRadius.circular(3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Text(
          getResponse["data"],
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
      ),
      toastDuration: const Duration(seconds: 3),
    );
    return false;
  }

  Future getAjoMembers(int ajoId) async {
    var result =
        await GetRotationalSavingsRequest.getMyRotationalMembers(ajoId);



        Type type = result["data"].runtimeType; 

    if(type == String){
      return;
    }
        
    if (result["data"]["members"].isNotEmpty) {
      List<MemberModel> allMembers = (result["data"]["members"] as List)
          .map((e) => MemberModel.fromJson(e))
          .toList();

          allAjoMemebers = allMembers;

      allMembers.forEach((element) {
        if (element.membership.toLowerCase() == "request") {
          membersRequest.add(element);
        } else {
          members.add(element);
        }
      });
    }
    notifyListeners();
  }

  Future approveMembership(
      int ajoId, String userId, BuildContext context, MemberModel model) async {
    FToast toast = FToast();

    toast.init(context);
    var result =
        await SavingsActionRequests.approveRotatingSavingsMemberShip(
            ajoId, userId);

    if (result["status"]) {
      toast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Text(
            result["data"],
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      membersRequest.remove(model);
      members.add(model);
      notifyListeners();
      return;
    }

    toast.showToast(
      gravity: ToastGravity.TOP,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 26, 26),
            borderRadius: BorderRadius.circular(3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Text(
          result["data"],
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
      ),
      toastDuration: const Duration(seconds: 3),
    );

    // notifyListeners();
  }

  Future rejectMembership(
      int ajoId, BuildContext context, MemberModel model) async {
    FToast toast = FToast();

    toast.init(context);
    var result =
        await SavingsActionRequests.rejectRotatingSavingsMemberShip(ajoId,model.id);

    if (result["status"]) {
      toast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Text(
            result["data"],
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      membersRequest.remove(model);
      notifyListeners();
      return;
    }

    toast.showToast(
      gravity: ToastGravity.TOP,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 26, 26),
            borderRadius: BorderRadius.circular(3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Text(
          result["data"],
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
      ),
      toastDuration: const Duration(seconds: 3),
    );

    // notifyListeners();
  }

  Future<bool> startAjo(int ajoId, BuildContext context) async {
    FToast toast = FToast();

    toast.init(context);
    var result = await SavingsActionRequests.startAjo(ajoId);

    if (result["status"]) {
      toast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Text(
            result["data"],
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
          ),
        ),
        toastDuration: const Duration(seconds: 5),
      );
      notifyListeners();
      return true;
    }

    toast.showToast(
      gravity: ToastGravity.TOP,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 26, 26),
            borderRadius: BorderRadius.circular(3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Text(
          result["data"],
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
      ),
      toastDuration: const Duration(seconds: 3),
    );
    return false;

    // notifyListeners();
  }

  Future<bool> deleteAjo(
      int ajoId, BuildContext context, RotationalSavingsModel model) async {
    FToast toast = FToast();

    toast.init(context);
    var result = await SavingsActionRequests.deleteAjo(ajoId);

    if (result["status"]) {
      toast.showToast(
        gravity: ToastGravity.TOP,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Text(
            result["data"],
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
          ),
        ),
        toastDuration: const Duration(seconds: 5),
      );
      allSavings.remove(model);
      notifyListeners();
      return true;
    }

    toast.showToast(
      gravity: ToastGravity.TOP,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 26, 26),
            borderRadius: BorderRadius.circular(3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Text(
          result["data"],
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
      ),
      toastDuration: const Duration(seconds: 3),
    );
    return false;

    // notifyListeners();
  }

  Future<bool> makeContribution(int ajoId, BuildContext context,String ajoNmae) async {
    FToast toast = FToast();

    toast.init(context);
    var result = await SavingsActionRequests.makeContribution(ajoId);
    // print(result);
    if (result["status"]) {
      navigate(ajoNmae);
      return true;
    }

    toast.showToast(
      gravity: ToastGravity.TOP,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 26, 26, 26),
            borderRadius: BorderRadius.circular(3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Text(
          result["data"],
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
      ),
      toastDuration: const Duration(seconds: 3),
    );
    return false;
  }
}

navigate(String ajoName) {
    Navigator.push(
      MyApp.navigationKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => SuccessfulSavingsCreation(header:"Contribution Successfull",message: "You can have succesfully made contribution to $ajoName.",call:()=>Navigator.pop(context),)),
    );
}