import 'dart:convert';

class Error {
  String? code;
  String? status;
  String? message;

  Error({this.code, this.status, this.message});
}

ErrorResponse apiErrorFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String apiErrorToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  String? status;
  String? code;
  String? message;

  ErrorResponse({
    this.status,
    this.code,
    this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
