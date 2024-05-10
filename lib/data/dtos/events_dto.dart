class EventDto {
  final int id;
  final String type;
  final String? note;
  final String createdAt;

  EventDto({
    required this.id,
    required this.type,
    required this.note,
    required this.createdAt,
  });

  factory EventDto.fromJson(Map<String, dynamic> json) => EventDto(
        id: json["id"],
        type: json["type"],
        note: json["note"],
        createdAt: json["created_at"],
      );
}
