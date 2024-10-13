import 'package:alnsher/model/home_model.dart';

class ResponseModel {
  bool status;
  String message;
  List<HomeCategory> dataResponse;

  ResponseModel({required this.status, required this.message, required this.dataResponse});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'],
      message: json['message'],
      dataResponse: List<HomeCategory>.from(json['data_response'].map((x) => HomeCategory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data_response': List<dynamic>.from(dataResponse.map((x) => x.toJson())),
    };
  }
}

