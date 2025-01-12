import 'package:info_sphere/utils/imports.dart';

Source sourceFromJson(String str) => Source.fromJson(json.decode(str));

String sourceToJson(Source data) => json.encode(data.toJson());

class Source {
  String? id;
  String? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
