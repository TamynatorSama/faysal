import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:faysal/models/history_model.dart';
import 'package:faysal/pages/notification/requests/notification_requests.dart';
import 'package:faysal/services/http_class.dart';
import 'package:flutter/material.dart';
import 'package:faysal/pages/notification/notification_model.dart' as custom_notification_model;

class HistoryProvider extends ChangeNotifier{
  List<HistoryModel> history = [];
  List<custom_notification_model.NotificationModel> notification = [];

  Future<void> populateHistory()async{

    var response = await HttpResponse().getTransactionHistory("limit=100");
    Type type  = response["data"].runtimeType;

    if(type == String) return;

    var list = response["data"] as List;

      history = list.map((e) => HistoryModel.fromJson(e)).toList();

  notifyListeners();

  }

  Future<void> populateNotifications()async{

    var response = await NotificationRequests.getAppNotifications();
    // print(response);
    Type type  = response["data"].runtimeType;

    if(type == String) return;

    var list = response["data"] as List;

      notification = list.map((e) => custom_notification_model.NotificationModel.fromjson(e)).toList();

  notifyListeners();

  }
  void getNotification(){
    Timer.periodic(const Duration(seconds: 5), (timer) async{ 
      await fetchNotificationAndDisplay();
    });
  }


  Future fetchNotificationAndDisplay()async{
    var response = await NotificationRequests.getPushNotifications();

    if(response["status"] && response["data"] !=null){
       custom_notification_model.NotificationModel push = custom_notification_model.NotificationModel.fromjson(response["data"]);

      if(push.read){
        await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          channelKey: "notification_channel",
          title: push.title,
          body: push.content,
          notificationLayout: NotificationLayout.BigText
          ));
      }
    }

  }
  resetAll(){
      history = [];
      notification = [];
    }

}