class ErrorResponseDto {
  final ErrorDto error;

  ErrorResponseDto({
    required this.error,
  });

  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) => ErrorResponseDto(
    error: ErrorDto.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error.toJson(),
  };
}

class ErrorDto {
  final int code;
  final String title;
  final String message;
  final List<ErrorElementDto> errors;

  ErrorDto({
    required this.code,
    required this.title,
    required this.message,
    required this.errors,
  });

  factory ErrorDto.fromJson(Map<String, dynamic> json) => ErrorDto(
    code: json["code"],
    title: json["title"],
    message: json["message"],
    errors: List<ErrorElementDto>.from(json["errors"].map((x) => ErrorElementDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "title": title,
    "message": message,
    "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
  };
}

class ErrorElementDto {
  final String key;
  final String message;

  ErrorElementDto({
    required this.key,
    required this.message,
  });

  factory ErrorElementDto.fromJson(Map<String, dynamic> json) => ErrorElementDto(
    key: json["key"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "message": message,
  };
}
