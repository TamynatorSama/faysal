class SavingDependantModel {
  final int id;
  final String name;
  final String description;

  SavingDependantModel(this.description, this.id, this.name);

  factory SavingDependantModel.fromJson(Map<String, dynamic> json) {
    return SavingDependantModel(json["description"], json["id"], json["name"]);
  }
}
