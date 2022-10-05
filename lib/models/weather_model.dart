class Weather {
  String icon;
  int code;
  String description;

  Weather({
    required this.icon,
    required this.code,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        icon: json["icon"],
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "code": code,
        "description": description,
      };
}
