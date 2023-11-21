class MeterDetailsModel {
  final String name;
  final String meterNumber;
  final String customerDistrict;
  final String address;

  MeterDetailsModel(
      {required this.address,
      required this.customerDistrict,
      required this.meterNumber,
      required this.name});

  factory MeterDetailsModel.fromJson(Map<String, dynamic> json) =>
      MeterDetailsModel(
          address: json["Address"] ?? "",
          customerDistrict: json["Customer_District"] ?? "",
          meterNumber: json["MeterNumber"] ?? json["Meter_Number"].toString(),
          name: json["Customer_Name"]);
}
