import 'dart:convert';

class HistoryModel {
  final int id;
  final String amount;
  final String createdAt;
  final String receiverName;
  final String type;
  final String narration;
  final String ref;
  final String status;
  final String processor;
  final String senderBank;
  final String receiverBank;
  final String senderName;
  final String senderAcctNo;
  final String receiverAcctNo;
  late bool isInternal;
  late bool transferIn;
  final HistoryResponseAdditon historyAddtionalInfo;

  HistoryModel({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.narration,
    required this.processor,
    required this.receiverBank,
    required this.ref,
    required this.senderBank,
    required this.status,
    required this.type,
    required this.senderName,
    required this.receiverName,
    required this.receiverAcctNo,
    required this.senderAcctNo,
    required this.isInternal,
    required this.transferIn,
    required this.historyAddtionalInfo
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {

    var additionalInfoJson = jsonDecode(json["res_data"]);

    return HistoryModel(
        id: json["id"] ?? "",
        amount: json["amount"].toString(),
        createdAt: json["created_at"] ?? "",
        receiverName: json["receiver_name"] ?? "",
        receiverBank: json["receiver_bank"] ?? "",
        ref: json["ref"] ?? "",
        processor: json["processor"] ?? "",
        narration: json["narration"] ?? "",
        senderBank: json["sender_bank"] ?? "",
        type: json["type"] ?? "",
        status: json["status"] ?? "",
        senderName: json["sender_name"] ?? "",
        receiverAcctNo: json["receiver_account_number"] ?? "",
        senderAcctNo: json["sender_account_number"] ?? "",
        transferIn: json["mata_data"] !=null ? true:false,
        historyAddtionalInfo: HistoryResponseAdditon.fromJson(additionalInfoJson["content"]?? {}),
        isInternal: json["sender_bank"].toString().contains("faysal") && json["receiver_bank"].toString().contains("faysal"));


  }
}
class HistoryResponseAdditon{
  late String type;
  late String productName;
  HistoryResponseAdditon({
    required this.productName,
    required this.type
  });

  HistoryResponseAdditon.fromJson(Map<String,dynamic>json){
    var newJson = json["transactions"] ?? {};
    type = newJson["type"] ?? "";
    productName = newJson["product_name"] ?? "";
  }

}




// {id: 74, user_id: 10, amount: 200.00, processor: Internal, channel: others, type: credit, narration: trf, ref: 1credit20230110144153, status: success, sender_name: Abdulrazaq Musa, sender_account_number: 9979161259, sender_bank: Myfaysal Walet, receiver_name: kolawole tamilore, receiver_account_number: 9979219992, receiver_bank: Myfaysal Wallet, session_id: null, mata_data: {}, res_data: {}, created_at: 2023-01-10T14:41:53.000000Z, updated_at: 2023-01-10T14:41:53.000000Z}
