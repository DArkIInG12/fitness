
class ExcerciceModel {
  String? bodyPart;
  String? equipment;
  String? gifUrl;
  String? id;
  String? name;
  String? target;
  List<dynamic>? secondary;
  List<dynamic>? instructions;

  ExcerciceModel({
    this.bodyPart,
    this.equipment,
    this.gifUrl,
    this.name,
    this.target,
    this.secondary,
    this.instructions,
  });
 
  factory ExcerciceModel.fromMap(Map<String, dynamic> map) {
    return ExcerciceModel(
      bodyPart: map['bodyPart'] ?? '',
      equipment: map['equipment'] ?? '',
      gifUrl: map['gifUrl'] ?? '',
      name: map['name'] ?? '',
      target: map['target'] ?? '',
      secondary: map['secondaryMuscles'] ?? '',
      instructions: map['instructions'] ?? ''
    );
  }

}
