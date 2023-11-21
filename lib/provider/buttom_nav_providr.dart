
import 'package:faysal/services/authService/login/loginhandler.dart';
import 'package:faysal/utils/functions.dart';
import 'package:flutter/material.dart';

class ButtomNavBarProvider extends ChangeNotifier{
  int pageIndex = 0;
  static bool hasResumed = true;
  static bool hasNavigated = false;
  static bool justStarted = true;
  static bool resumedBeforeTimeOut = false;
  static bool _askforpin = false;


  get screenResumed => hasResumed;
  get startApp => justStarted;
  get beforeTimeout => resumedBeforeTimeOut;
  get inConfirmationPage => hasResumed;
  get requestPin => _askforpin;

  set hasScreenResumed(bool value){
    
    hasResumed = value;

    if (value && !hasNavigated && Login().loggedIn) {
        hasNavigated = true;
        resumedBeforeTimeOut = false;
        _askforpin = false;
        showEntryPin();
    }
  }
  set hasNavigatedToPage(bool value) {
    hasNavigated = value;
    
  }
  set justStartedapp(bool value) {
    justStarted = value;
  }
  set askForPin(bool value) {
    _askforpin = value;
  }
  set setTimeout(bool value) {
    resumedBeforeTimeOut = value;
  }

  void changePage(int index){
    pageIndex = index;
    notifyListeners();
  }
}