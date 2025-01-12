import 'dart:convert';

class Success {
  String? status;
  int? totalResults;
  dynamic data;

  Success({
    this.status,
    this.totalResults,
    this.data,
  });
}

SuccessResponse successResponseFromJson(String str) =>
    SuccessResponse.fromJson(json.decode(str));

String successResponseToJson(SuccessResponse data) =>
    json.encode(data.toJson());

class SuccessResponse<T> {
  String? status;
  int? totalResults;
  T? data;

  SuccessResponse({
    this.status,
    this.totalResults,
    this.data,
  });

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      SuccessResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        data: json["articles"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": data,
      };
}
