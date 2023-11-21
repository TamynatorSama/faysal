class MyRotationalSavingsModel {
  final int id;
  final int ajoId;
  final int userId;
  final int numberOfHand;
  final String membership;
  final RotationalSavingsModel ajo;

  MyRotationalSavingsModel(
      {required this.ajo,
      required this.ajoId,
      required this.id,
      required this.membership,
      required this.numberOfHand,
      required this.userId});
  factory MyRotationalSavingsModel.fromJson(Map<String, dynamic> json) =>
      MyRotationalSavingsModel(
          ajo: RotationalSavingsModel.fromJson(json["ajo"]),
          ajoId: json["ajo_id"],
          id: json["id"],
          membership: json["membership"],
          numberOfHand: json["number_of_hand"],
          userId: json["user_id"]);
}

class Creator {
  final String name;
  final String email;
  final String phone;

  Creator({required this.email, required this.name, required this.phone});

  factory Creator.fromJson(Map<String, dynamic> json) =>
      Creator(email: json["email"] ?? "", name: json["name"]??"", phone: json["phone"]??"");
}

class RotationalSavingsModel {
  final int id;
  final int userId;
  final String ajoCode;
  final String name;
  final int ajoType;
  final int ajoTypeId;
  final String createAjoStep;
  final String amount;
  final int frequencyId;
  final int disbursementDateId;
  final int disbursementMethodId;
  final int numberOfHand;
  final int penalty;
  final String nextDisbursemetDate;
  final String coordinatorFee;
  final String account;
  final int bankId;
  final String accName;
  final int accNum;
  int isActive;
  final String operation;
  final String startedAt;
  final String completedAt;
  final String createdAt;
  final Creator user;

  @override
  String toString() {
    String toString = """
  this.accName ==> $accName
      accNum ==> $accNum
      account ==> $account
      ajoCode ==> $ajoCode
      ajoType ==> $ajoType
      amount ==> $amount
      bankId ==> $bankId
      completedAt ==> $completedAt
      coordinatorFee ==> $coordinatorFee
      createAjoStep ==> $createAjoStep
      disbursementDateId ==> $disbursementDateId
      disbursementMethodId ==> $disbursementMethodId
      frequencyId ==> $frequencyId
      id ==> $id
      isActive ==> $isActive
      name ==> $name
      numberOfHand ==> $numberOfHand
      operation ==> $operation
      penalty, ==> $penalty
      startedAt ==> $startedAt
      userId ==> $userId

""";

    return toString;
  }

  RotationalSavingsModel(
      {required this.accName,
      required this.accNum,
      required this.account,
      required this.ajoCode,
      required this.ajoType,
      required this.amount,
      required this.ajoTypeId,
      required this.bankId,
      required this.completedAt,
      required this.coordinatorFee,
      required this.createAjoStep,
      required this.disbursementDateId,
      required this.disbursementMethodId,
      required this.frequencyId,
      required this.id,
      required this.nextDisbursemetDate,
      required this.isActive,
      required this.name,
      required this.numberOfHand,
      required this.operation,
      required this.penalty,
      required this.startedAt,
      required this.userId,
      required this.createdAt,
      required this.user
      });

  factory RotationalSavingsModel.fromJson(Map<String, dynamic> json) =>
      RotationalSavingsModel(
          accName: json["acc_name"] ?? "",
          accNum: json["acc_num"] ?? 0,
          account: json["account"] ?? "",
          ajoCode: json["ajo_code"] ?? "",
          ajoType: json["ajo_type_id"],
          ajoTypeId: json["ajo_type_id"]?? 1,
          amount: json["amount"] ?? "",
          nextDisbursemetDate: json["next_disbursement_date"] ?? "",
          bankId: json["bank_id"] ?? 0,
          completedAt: json["completed_at"] ?? "",
          coordinatorFee: json["coordinator_fee"] ?? "",
          createAjoStep: json["create_ajo_step"],
          disbursementDateId: json["disbursement_date_id"] ?? 0,
          disbursementMethodId: json["disbursement_method_id"] ?? 0,
          frequencyId: json["frequency_id"]??0,
          id: json["id"] ??0,
          isActive: json["active"] ?? 0,
          name: json["name"]??"",
          numberOfHand: json["number_of_hand"]??0,
          operation: json["operation"]??"",
          penalty: json["penalty"]??0,
          startedAt: json["started_at"]??"",
          userId: json["user_id"]??0,
          createdAt: json["created_at"]?? "",
          user: Creator.fromJson(json["user"] ?? {}));
}
