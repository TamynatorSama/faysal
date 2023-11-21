class SettingsModel{
  late String appName;
  late String appLogo;
  late String contactEmail;
  late String ajoCommission;

  SettingsModel({
    required this.appName,
    required this.ajoCommission,
    required this.appLogo,
    required this.contactEmail
  });


  SettingsModel.fromJson(Map<String, dynamic>json){
    appName = json["app_name"]??"";
    appLogo = json["app_name"]??"";
    contactEmail = json["contact_email"] ?? "";
    ajoCommission = json["ajo_commission"]?? "";
  }

}