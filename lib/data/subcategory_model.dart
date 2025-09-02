class SubCategoryModel {
  final String subCategoryId;
  final String divisionId;
  final String categoryId;
  final String categoryName;
  final String groupName;
  final CreatedAt createdAt;
  final String modifiedAt;

  SubCategoryModel({
    required this.subCategoryId,
    required this.divisionId,
    required this.categoryId,
    required this.categoryName,
    required this.groupName,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      subCategoryId: json['subCategoryId']?.toString() ?? '',
      divisionId: json['divisionId']?.toString() ?? '',
      categoryId: json['categoryId']?.toString() ?? '',
      categoryName: json['categoryName'] ?? '',
      groupName: json['groupName'] ?? '',
      createdAt: CreatedAt.fromJson(json['created_at']),
      modifiedAt: json['modified_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subCategoryId': subCategoryId,
      'divisionId': divisionId,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'groupName': groupName,
      'created_at': createdAt.toJson(),
      'modified_at': modifiedAt,
    };
  }
}

class CreatedAt {
  final String date;
  final int timezoneType;
  final String timezone;

  CreatedAt({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) {
    return CreatedAt(
      date: json['date'] ?? '',
      timezoneType: json['timezone_type'] ?? 0,
      timezone: json['timezone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'timezone_type': timezoneType,
      'timezone': timezone,
    };
  }
}
