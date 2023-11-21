// ignore_for_file: use_build_context_synchronously, unnecessary_getters_setters

import 'package:device_information/device_information.dart';
import 'package:faysal/services/http_class.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  static String _email = "";
  static String _token = "";
  static bool firstTime = false;
  static bool? _isLoggedIn;
  // SharedPreferences
  static late SharedPreferences _preferences;

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    await getStoredData();
  }

  static Future<void> getStoredData() async {
    _email = _preferences.getString("email") ?? "";
    _token = _preferences.getString("token") ?? "";
    _isLoggedIn = _preferences.getBool("is_logged_in") ?? false;
    firstTime = _preferences.getBool("hasUsedApp") ?? false;
  }

  static saveDataToStorage(
      {String email = '', String token = '', bool isLogged = false}) {
    if (email.isNotEmpty) {
      _email = email;
      _preferences.setString('email', email);
    }
    if (token.isNotEmpty) {
      _token = token;
      _preferences.setString('token', token);
    }
    _isLoggedIn = isLogged;
    _preferences.setBool('is_logged_in', isLogged);
  }

  static removeRecord() async {
    // await _preferences.remove("email");
    await _preferences.remove("token");
    await _preferences.remove("is_logged_in");
    await _preferences.remove("id");
    await _preferences.remove("name");
    // await _preferences.remove("email");
    await _preferences.remove("phone");
    await _preferences.remove("accountName");
    await _preferences.remove("accountNumber");
    await _preferences.remove("bvn");
    await _preferences.remove("avatar");
    await _preferences.remove("balance");
    await _preferences.remove("question");
    await _preferences.remove("cacheKey");
  }

  String get email => _email;
  String get userToken => _token;
  bool get loggedIn => _isLoggedIn!;
  bool get firstTimeUsage => firstTime;

  set email(String value) {
    _email = value;
    _preferences.setString('email', value);
  }

  set hasUsedApp(bool value) {
    firstTime = value;
    _preferences.setBool('hasUsedApp', value);
  }

  set userToken(String value) {
    _token = value;
    _preferences.setString("token", value);
  }

  set isLoggedIn(bool? value) {
    _isLoggedIn = value;
    _preferences.setBool('is_logged_in', value!);
  }

  Future<bool> loginUser(String email, String password, VoidCallback call,
      BuildContext context) async {
    var deviceName = await DeviceInformation.deviceName;
    var response = await HttpResponse().login(email, password, deviceName);

    FToast toast = FToast()..init(context);

    if (response["status"] != 200) {
      if(response["data"].toString().contains("record")){
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
            response["data"],
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: "Popppins", color: Colors.white),
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      return false;
    }
    
    email = email;
    userToken = response["data"]["token"];
    isLoggedIn = true;
    saveDataToStorage(
        email: email, token: response["data"]["token"], isLogged: true);
    call();
    return false;
  }

  Future getResetPin(String email, BuildContext context, FToast toast) async {
    var response = await HttpResponse().getPasswordResetToken(email);

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
    return response["data"].toString();
  }

  Future forgotPassword(
      String email,
      String password,
      VoidCallback call,
      BuildContext context,
      String passwordConformation,
      String resetToken) async {
    FToast toast = FToast();
    toast.init(context);
    var response = await HttpResponse()
        .forgotPassword(email, password, passwordConformation, resetToken);
    // print(response);

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

    call();
  }

  Future logoutUser(Future Function() call, BuildContext context,
      VoidCallback navigate) async {
    FToast fToast = FToast();
    fToast.init(context);

    var response = await HttpResponse().logout();
    // print(response);

    if (response["status"] != 200) {
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
    }

    // email ="";


  userToken="";

  isLoggedIn=false;

    call();
    navigate();
  }
}
