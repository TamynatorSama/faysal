// ignore_for_file: use_build_context_synchronously

import 'package:faysal/models/settings_model.dart';
import 'package:faysal/models/user_model.dart';
import 'package:faysal/services/http_class.dart';
import 'package:faysal/utils/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ProfileProvider extends ChangeNotifier {
  List<String> questions = [];
  late SettingsModel settings;
  String cacheKey = "";
  UserModel userProfile = UserModel(
    id: 0,
    name: "",
    email: "",
    phone: "",
    accountname: "",
    accountNumber: 0,
    avatar: "",
    bvn: 0,
    question: "",
    balance: 0,
    ajoBalance: 0,
  );

  static late SharedPreferences _preferences;
  Future<void> initializeProfile() async {
    _preferences = await SharedPreferences.getInstance();
    await getStoredData();
  }

  Future<void> getStoredData() async {
    cacheKey = _preferences.getString("cacheKey")??"";
    UserModel savedUserProfile = UserModel(
        id: _preferences.getInt("id") ?? 0,
        name: _preferences.getString("name") ?? "",
        email: _preferences.getString("email") ?? "",
        phone: _preferences.getString("phone") ?? "",
        accountname: _preferences.getString("accountName") ?? "",
        accountNumber: _preferences.getInt("accountNumber") ?? 0,
        avatar: _preferences.getString("avatar") ?? "",
        question: _preferences.getString("question") ?? "",
        bvn: _preferences.getInt("bvn") ?? 0,
        balance: _preferences.getInt("balance") ?? 0,
        hasVerifiedEmail: _preferences.getString("email_verified_at") ?? "",
        hasVerifiedPhone: _preferences.getString("phone_verified_at") ?? "",
        ajoBalance: _preferences.getInt("balance_from_all_ajo") ?? 0);

    userProfile = savedUserProfile;
    notifyListeners();
  }

  static Future<void> storedData(dynamic response) async {
    await _preferences.setInt("id", response["body"]["user"]["id"]);
    await _preferences.setString("name", response["body"]["user"]["name"]);
    await _preferences.setString("email", response["body"]["user"]["email"]);
    await _preferences.setString("email_verified_at",
        response["body"]["user"]["email_verified_at"] ?? "");
    await _preferences.setString("phone_verified_at",
        response["body"]["user"]["phone_verified_at"] ?? "");
    await _preferences.setString(
        "phone", response["body"]["user"]["phone"].toString());
    await _preferences.setString(
        "accountName", response["body"]["user"]["account_name"]);
    await _preferences.setInt("accountNumber",
        int.parse(response["body"]["user"]["account_number"] ?? 0));
    await _preferences.setInt("bvn", response["body"]["user"]["bvn"] ?? 0);
    await _preferences.setString(
        "avatar", response["body"]["user"]["avatar"] ?? "");
    await _preferences.setInt("balance", response["body"]["balance"]);
    await _preferences.setInt(
        "balance_from_all_ajo", response["body"]["balance_from_all_ajo"]);
    await _preferences.setString(
        "question", response["body"]["user"]["security_question"] ?? "");
  }

  void clearProvider() {
    userProfile = UserModel(
        id: 0,
        name: "",
        email: "",
        phone: "",
        accountname: "",
        accountNumber: 0,
        avatar: "",
        bvn: 0,
        balance: 0,
        ajoBalance: 0);

    notifyListeners();
  }

  Future<void> getSystemSettings() async {
    var response = await HttpResponse.getGeneralSettings();
    Type type = response["data"].runtimeType;

    if (type == String) return;

    settings = SettingsModel.fromJson(response["data"]);

    notifyListeners();
  }

  Future populateProfile(FToast toast, VoidCallback call) async {
    var response = await HttpResponse().getProfile();
    if (kDebugMode) print(response);
    if (response["status"] != 200) {
      toast.showToast(
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
    userProfile = UserModel.fromJson(response["data"]);
    storedData(response["data"]);
    notifyListeners();

    if (response["data"]["body"]["user"]["security_question"] == null &&
        await checkNetworkConnection(false)) {
      call();
      return;
    }
  }

  Future<void> updatePics(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    var response = await HttpResponse.uploadProfilePics(image.path);
    
    if(response["status"]){
      bool test = response["data"].toString().contains("https://app.myfaysal.com/images/");
      if(test){
        userProfile.avatar = response["data"].toString().replaceAll("https://app.myfaysal.com/images/", "");
      }
      else{
        userProfile.avatar = response["data"];
      }
      String newKey = const Uuid().v4();

      cacheKey = newKey;
     await  _preferences.setString(cacheKey,newKey);
      
      notifyListeners();
      return;
    }
    showToast(context, response["data"]);
    
  }

  Future<void> getQuestions() async {
    var response = await HttpResponse.getSecurityQuestions();
    // print();
    if (response["data"].isNotEmpty &&
        response["data"].runtimeType.toString().toLowerCase() != "string") {
      questions = (response["data"] as List).map((e) => e.toString()).toList();
    }
  }
}
