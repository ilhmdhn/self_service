class VoucherDataResult {
  bool isLoading;
  bool? state;
  String? message;
  List<VoucherData>? voucherData;

  VoucherDataResult(
      {this.isLoading = true, this.state, this.message, this.voucherData});

  factory VoucherDataResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }
    return VoucherDataResult(
        isLoading: false,
        state: json['state'],
        message: json['message'],
        voucherData: List<VoucherData>.from(
            (json['data'] as List).map((x) => VoucherData.fromJson(x))));
  }
}

class VoucherData {
  String? voucherCode;
  String? voucherName;
  String? description;
  String? image;

  VoucherData(
      {this.voucherCode,
      this.voucherName,
      this.description,
      this.image});

  factory VoucherData.fromJson(Map<String, dynamic> json) => VoucherData(
        voucherCode: json['voucher_code'],
        voucherName: json['voucher_name'],
        description: json['description'],
        image: json['image'],
      );
}
