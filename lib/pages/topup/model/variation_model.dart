class VariationModel{
  late String variationCode;
  late String name;
  late String variationAmount;
  late bool fixedPrice;

  VariationModel({
    required this.fixedPrice,
    required this.name,
    required this.variationAmount,
    required this.variationCode
  });

  VariationModel.fromJson(Map<String,dynamic>json){
    variationAmount = json["variation_amount"];
    variationCode = json["variation_code"];
    name = json["name"];
    fixedPrice = json["fixedPrice"].toString().toLowerCase() == "yes" ? true:false;
  }
}