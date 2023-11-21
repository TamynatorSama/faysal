import 'package:faysal/services/authService/login/loginhandler.dart';

class MemberModel {
  final String id;
  final String numberOfHands;
  late String membership;
  final AjoUserModel userData;

  MemberModel(
      {required this.id,
      required this.membership,
      required this.numberOfHands,
      required this.userData});

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
      id: json["id"].toString(),
      membership: json["membership"],
      numberOfHands: json["number_of_hand"].toString(),
      userData: AjoUserModel.fromJson(json["user"]));
}

class AjoUserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String accountname;
  final int accountNumber;
  final String avatar;
  final int bvn;
  final String? question;

  AjoUserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.accountname,
      required this.accountNumber,
      required this.avatar,
      required this.bvn,
      this.question,});
  factory AjoUserModel.fromJson(Map<String, dynamic> json) {
    return AjoUserModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        email: json["email"] ?? Login().email,
        phone: json["phone"] ?? 0,
        accountname: json["account_name"] ?? "",
        accountNumber: int.parse(json["account_number"]?? "0"),
        avatar: json["avatar"] ?? "",
        bvn: json["bvn"] ?? 0,
        question: json["security_question"]
        );
  }
}
