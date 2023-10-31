class QrisPaymentResult {
  bool isLoading;
  bool? state;
  QrisData? data;
  String? message;

  QrisPaymentResult({
    this.isLoading = true,
    this.state,
    this.message,
    this.data,
  });

  factory QrisPaymentResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] != true) {
      throw json['message'];
    }

    return QrisPaymentResult(
        isLoading: false,
        state: true,
        message: json['message'],
        data: QrisData.fromJson(json['data']));
  }
}

class QrisData {
  String? sessionId;
  int? transactionId;
  String? referenceId;
  String? via;
  String? channel;
  String? paymentNo;
  String? qrString;
  String? paymentName;
  num? subTotal;
  num? fee;
  num? total;
  String? feeDirection;
  String? expired;
  String? qrImage;
  String? qrTemplate;
  String? terminal;
  String? nNSCode;
  String? expiredTime;

  QrisData(
      {this.sessionId,
      this.transactionId,
      this.referenceId,
      this.via,
      this.channel,
      this.paymentNo,
      this.qrString,
      this.paymentName,
      this.subTotal,
      this.fee,
      this.total,
      this.feeDirection,
      this.expired,
      this.qrImage,
      this.qrTemplate,
      this.terminal,
      this.nNSCode,
      this.expiredTime});

  factory QrisData.fromJson(Map<String, dynamic> json) => QrisData(
        sessionId: json['SessionId'],
        transactionId: json['TransactionId'],
        referenceId: json['ReferenceId'],
        via: json['Via'],
        channel: json['Channel'],
        paymentNo: json['PaymentNo'],
        qrString: json['QrString'],
        paymentName: json['PaymentName'],
        subTotal: json['SubTotal'],
        fee: json['Fee'],
        total: json['Total'],
        feeDirection: json['FeeDirection'],
        expired: json['Expired'],
        qrImage: json['QrImage'],
        qrTemplate: json['QrTemplate'],
        terminal: json['Terminal'],
        nNSCode: json['NNSCode'],
        expiredTime: json['expired_time'],
      );
}
