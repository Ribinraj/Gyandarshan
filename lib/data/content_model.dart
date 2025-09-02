class ContentDataModel {
  final String contentId;
  final String categoryId;
  final String subCategoryId;
  final String contentType;
  final String contentName;
  final String contentAttachment;
  final String contentVideo;
  final String createdBy;
  final CreatedAt? createdAt;
  final String modifiedAt;
  final String categoryName;
  final String subCategoryName;

  ContentDataModel({
    required this.contentId,
    required this.categoryId,
    required this.subCategoryId,
    required this.contentType,
    required this.contentName,
    required this.contentAttachment,
    required this.contentVideo,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedAt,
    required this.categoryName,
    required this.subCategoryName,
  });

  factory ContentDataModel.fromJson(Map<String, dynamic> json) {
    return ContentDataModel(
      contentId: json['contentId'] ?? "",
      categoryId: json['categoryId'] ?? "",
      subCategoryId: json['subCategoryId'] ?? "",
      contentType: json['contentType'] ?? "",
      contentName: json['contentName'] ?? "",
      contentAttachment: json['contentAttachment'] ?? "",
      contentVideo: json['contentVideo'] ?? "",
      createdBy: json['createdBy'] ?? "",
      createdAt: json['created_at'] != null
          ? CreatedAt.fromJson(json['created_at'])
          : null,
      modifiedAt: json['modified_at'] ?? "",
      categoryName: json['categoryName'] ?? "",
      subCategoryName: json['subCategoryName'] ?? "",
    );
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
      date: json['date'] ?? "",
      timezoneType: json['timezone_type'] ?? 0,
      timezone: json['timezone'] ?? "",
    );
  }
}