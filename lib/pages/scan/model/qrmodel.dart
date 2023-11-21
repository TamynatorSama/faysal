import 'package:faysal/models/user_model.dart';

class QrModel{
  late String recieverId;
  late String recieverPhone;
  late String status;
  late UserModel sender;

  QrModel({
    required this.recieverId,required this.recieverPhone, required this.sender,required this.status
  });

  QrModel.fromJson(Map<String, dynamic>json){
    recieverId = json["event"]["receiver_id"].toString();
    recieverPhone = json["event"]["receiver_phone"];
    status = json["event"]["status"];
    var newJson = {"body":{
      "user":json["sender "]
    }};
    sender = UserModel.fromJson(newJson);
  }
}