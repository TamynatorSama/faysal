import 'package:faysal/models/user_model.dart';

class ListenerEventModel{
  late String eventId;
  late String eventRef;
  late String status;
  late UserModel reciever;



  ListenerEventModel({
    required this.eventId,
    required this.eventRef,
    required this.reciever,
    required this.status
  });


  ListenerEventModel.fromJson(Map<String,dynamic> json){
    eventId = json["event"]["id"].toString();
    eventRef = json["event"]["event_ref"];
    status = json["event"]["status"];
    var newJson = {
      "body":{
        "user": json["receiver"]
      }
    };
    reciever = UserModel.fromJson(newJson);
  }


}


// {status: true, data: {event: {id: 12, event_ref: faysal2021-12-31 20:30:00.000|de332148-e7cf-4594-acbd-bf291721d37c, sender_id: 11, receiver_id: 1, receiver_phone: 08164517303, amount: 2000.00, status: accepted, created_at: 2023-02-02T18:14:19.000000Z, updated_at: 2023-02-02T18:15:32.000000Z}, receiver: {id: 1, name: Abdulrazaq Musa, email: razmybox@gmail.com, phone: 08164517303, account_name: MERCHANT(Abdulrazaq Musa), account_number: 9979161259, ajo_account_name: MERCHANT(Abdulrazaq Musa (Rot), ajo_account_number: 9979209634, email_verified_at: 2022-12-07T11:39:27.000000Z, phone_verified_at: null, two_fa: 1, security_question: What is your favourite football club, created_at: 2022-03-18T03:00:14.000000Z, updated_at: 2023-01-14T02:46:39.000000Z, avatar: 08164517303.jpg, bvn: 87878767876, id_document: null}}}