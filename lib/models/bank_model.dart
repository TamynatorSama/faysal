class BankModel {
  final String bankCode;
  final String bankName;
  BankModel({required this.bankCode, required this.bankName});
  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
        bankCode: json["bankCode"].toString(), bankName: json["bankName"]);
  }
}
