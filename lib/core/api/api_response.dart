
class ApiResponse<T>{
  bool status;
  String message;
  T data;
  ApiResponse({required this.status, required this.message, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse<T>(
        status: json["status"],
        message: json["message"],
        data: json["data"]); // The method 'fromJson' isn't defined for the type 'Type'.
    // Try correcting the name to the name of an existing method, or defining a method named 'fromJson'.
  }

  Map<String, dynamic> toJson() => {
    "status": this.status,
    "message": this.message,
    // Try correcting the name to the name of an existing method, or defining a method named 'toJson'
  };

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}