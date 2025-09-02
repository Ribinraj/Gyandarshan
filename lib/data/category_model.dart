class CategoryModel {
  final String? categoryId;
  final String? divisionId;
  final String? categoryShortName;
  final String? categoryFullName;
  final String? categoryImage;
  final String? hasSubMenu;
  final DateTimeInfo? createdAt;
  final String? modifiedAt;
  final DateTimeInfo? lastModified;

  CategoryModel({
    this.categoryId,
    this.divisionId,
    this.categoryShortName,
    this.categoryFullName,
    this.categoryImage,
    this.hasSubMenu,
    this.createdAt,
    this.modifiedAt,
    this.lastModified,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId']?.toString(),
      divisionId: json['divisionId']?.toString(),
      categoryShortName: json['categoryShortName']?.toString(),
      categoryFullName: json['categoryFullName']?.toString(),
      categoryImage: json['categoryImage']?.toString(),
      hasSubMenu: json['hasSubMenu']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTimeInfo.fromJson(json['created_at'])
          : null,
      modifiedAt: json['modified_at']?.toString(),
      lastModified: json['lastModified'] != null
          ? DateTimeInfo.fromJson(json['lastModified'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "categoryId": categoryId ?? "",
      "divisionId": divisionId ?? "",
      "categoryShortName": categoryShortName ?? "",
      "categoryFullName": categoryFullName ?? "",
      "categoryImage": categoryImage ?? "",
      "hasSubMenu": hasSubMenu ?? "",
      "created_at": createdAt?.toJson(),
      "modified_at": modifiedAt ?? "",
      "lastModified": lastModified?.toJson(),
    };
  }
}

class DateTimeInfo {
  final String? date;
  final int? timezoneType;
  final String? timezone;

  DateTimeInfo({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  factory DateTimeInfo.fromJson(Map<String, dynamic> json) {
    return DateTimeInfo(
      date: json['date']?.toString(),
      timezoneType: json['timezone_type'] is int
          ? json['timezone_type']
          : int.tryParse(json['timezone_type']?.toString() ?? ""),
      timezone: json['timezone']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date ?? "",
      "timezone_type": timezoneType ?? 0,
      "timezone": timezone ?? "",
    };
  }
}