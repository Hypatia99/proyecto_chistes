class dev {
  List<String> categories;
  DateTime createdAt;
  String iconUrl;
  String id;
  DateTime updatedAt;
  String url;
  String value;

  dev({
    required this.categories,
    required this.createdAt,
    required this.iconUrl,
    required this.id,
    required this.updatedAt,
    required this.url,
    required this.value,
  });

  factory dev.fromJson(Map<String, dynamic> json) => dev(
        categories: List<String>.from(json["categories"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        iconUrl: json["icon_url"],
        id: json["id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
        value: json["value"],
      );
}
