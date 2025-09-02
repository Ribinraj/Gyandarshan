class DivisionModel {
  final String divisionId;
  final String divisionName;
  final String divisionTitle;

  DivisionModel({
    required this.divisionId,
    required this.divisionName,
    required this.divisionTitle,
  });

  factory DivisionModel.fromJson(Map<String, dynamic> json) {
    return DivisionModel(
      divisionId: json['divisionId'],
      divisionName: json['divisionName'],
      divisionTitle: json['divisionTitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'divisionId': divisionId,
      'divisionName': divisionName,
      'divisionTitle': divisionTitle,
    };
  }
}
