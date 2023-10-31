class PaymentVaResult {
  bool isLoading;
  bool? state;
  VirtualAccountData? data;
  String? message;

  PaymentVaResult({
    this.isLoading = true,
    this.state,
    this.message,
    this.data,
  });

  factory PaymentVaResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] != true) {
      throw json['message'];
    }

    return PaymentVaResult(
        isLoading: false,
        state: true,
        message: json['message'],
        data: VirtualAccountData.fromJson(json['data']));
  }
}

class VirtualAccountData {
  String? sessionId;
  int? transactionId;
  String? referenceId;
  String? via;
  String? channel;
  String? paymentNo;
  String? paymentName;
  num? subTotal;
  num? fee;
  num? total;
  String? feeDirection;
  String? expired;
  String? expiredTime;

  VirtualAccountData(
      {this.sessionId,
      this.transactionId,
      this.referenceId,
      this.via,
      this.channel,
      this.paymentNo,
      this.paymentName,
      this.subTotal,
      this.fee,
      this.total,
      this.feeDirection,
      this.expired,
      this.expiredTime});

  factory VirtualAccountData.fromJson(Map<String, dynamic> json) =>
      VirtualAccountData(
          sessionId: json['SessionId'],
          transactionId: json['TransactionId'],
          referenceId: json['ReferenceId'],
          via: json['Via'],
          channel: json['Channel'],
          paymentNo: json['PaymentNo'],
          paymentName: json['PaymentName'],
          subTotal: json['SubTotal'],
          fee: json['Fee'],
          total: json['Total'],
          feeDirection: json['FeeDirection'],
          expired: json['Expired'],
          expiredTime: json['expired_time']);
}
