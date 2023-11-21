import 'package:faysal/services/authService/login/loginhandler.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String accountname;
  final int accountNumber;
  late String avatar;
  final int bvn;
  final int balance;
  final int ajoBalance;
  late String? question;
  late String? hasVerifiedEmail;
  late String? hasVerifiedPhone;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.accountname,
      required this.accountNumber,
      required this.avatar,
      required this.bvn,
      this.question,
      this.hasVerifiedEmail,
      this.hasVerifiedPhone,
      required this.ajoBalance,
      required this.balance});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["body"]["user"]["id"] ?? 0,
        name: json["body"]["user"]["name"] ?? "",
        email: json["body"]["user"]["email"] ?? Login().email,
        phone: json["body"]["user"]["phone"] ?? 0,
        accountname: json["body"]["user"]["account_name"] ?? "",
        accountNumber: int.parse(json["body"]["user"]["account_number"]?? "0"),
        avatar: json["body"]["user"]["avatar"] ?? "",
        bvn: json["body"]["user"]["bvn"] ?? 0,
        balance: json["body"]["balance"] ?? 0,
        hasVerifiedEmail: json["body"]["user"]["email_verified_at"],
        hasVerifiedPhone: json["body"]["user"]["phone_verified_at"],
        ajoBalance: json["body"]["balance_from_all_ajo"] ?? 0,
        question: json["body"]["user"]["security_question"]
        );
  }
}
