class DisbursementHistoryModel {
  final String turn;
  final String status;
  final String date;
  final String numberOfHands;
  final String amount;

  DisbursementHistoryModel(
      {required this.amount,
      required this.date,
      required this.numberOfHands,
      required this.status,
      required this.turn});

  factory DisbursementHistoryModel.fromJson(Map<String, dynamic> json) =>
      DisbursementHistoryModel(
          amount: json["amount"],
          date: json["date"],
          numberOfHands: json["number_of_hand"].toString(),
          status: json["status"].toString(),
          turn: json["turn"].toString());
}
