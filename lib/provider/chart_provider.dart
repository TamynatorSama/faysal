import 'package:faysal/main.dart';
import 'package:faysal/models/history_model.dart';
import 'package:faysal/services/http_class.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StatisticProvider extends ChangeNotifier {
  List<HistoryModel> history = [];
  double debit = 0;
  double credit = 0;
  String filter = "limit=100";

  List<double> weekDebit = [0, 0,0, 0, 0, 0, 0];
  List<double> weekCredit = [0, 0, 0, 0, 0, 0,0];

  // List<HistoryModel> thisWeek = [];


  Future getData() async {
    var response = await HttpResponse().getTransactionHistory(filter);

    FToast fToast = FToast()..init(MyApp.navigationKey.currentContext!);

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
            style: const TextStyle(fontFamily: "Poppins", color: Colors.white),
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      return;
    }

    var list = response["data"] as List;
    history = list.map((e) => HistoryModel.fromJson(e)).toList();
    userProvider();
  }

  void userProvider() {
    credit = 0;
    debit = 0;
    weekDebit = [0, 0, 0, 0, 0, 0, 0];
    weekCredit = [0, 0, 0, 0, 0, 0, 0];
    history.forEach((element) {
      if (element.type.toLowerCase() == "credit") {
        credit += double.parse(element.amount);
      } else {
        debit += double.parse(element.amount);
      }

      DateTime beginWeek;


        if(DateTime.now().weekday ==7){
          beginWeek = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
        }
        else{
          beginWeek = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).subtract(Duration(days: DateTime.now().weekday));
        }


          
    
          
          
      DateTime endWeek = beginWeek.add(const Duration(days: 6));

      if (DateTime.parse(element.createdAt).isAfter(beginWeek) &&
          DateTime.parse(element.createdAt).isBefore(endWeek)) {
        if (element.type.toLowerCase() == "credit") {
          weekCredit[weekNum(DateTime.parse(element.createdAt).weekday - 1)] +=
              double.parse(element.amount);
        } else {
          weekDebit[weekNum(DateTime.parse(element.createdAt).weekday - 1)] +=
              double.parse(element.amount);
        }
      }
    });
    notifyListeners();
  }


  int weekNum(int iteration){
    switch(iteration){
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        return iteration +1;
      case 6:
        return 0;
      default: 
      return 0;

    }
  }


}
