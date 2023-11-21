class VerifieduserCardModel {
  final String customerName;
  final String customerNumber;
  final String currentBouquet;

  VerifieduserCardModel(
      {required this.currentBouquet,
      required this.customerName,
      required this.customerNumber});

  factory VerifieduserCardModel.fromJson(Map<String, dynamic> json) =>
      VerifieduserCardModel(
          currentBouquet: json["Current_Bouquet"] ?? "",
          customerName: json["Customer_Name"],
          customerNumber: json["Customer_Number"].toString());
}
