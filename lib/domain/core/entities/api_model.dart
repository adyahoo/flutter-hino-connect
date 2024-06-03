class ErrorResponseModel {
  final int code;
  final String title;
  final String message;
  final List<ErrorModel> errors;

  ErrorResponseModel({
    required this.code,
    required this.title,
    required this.message,
    this.errors = const [],
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(
        code: json["code"],
        title: json["title"],
        message: json["message"],
        errors: List<ErrorModel>.from(json["errors"].map((x) => ErrorModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "message": message,
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
      };
}

class ErrorModel {
  final String key;
  final String message;

  ErrorModel({
    required this.key,
    required this.message,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        key: json["key"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "message": message,
      };
}
