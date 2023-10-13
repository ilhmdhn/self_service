class BaseResponse {
  bool isLoading;
  bool? state;
  String? message;

  BaseResponse({
    this.isLoading = true,
    this.state,
    this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    if (json['state'] != true) {
      throw json['message'];
    }
    return BaseResponse(
        isLoading: false, state: true, message: json['message']);
  }
}
