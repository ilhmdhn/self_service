class ListPaymentResult {
  bool isLoading;
  bool? state;
  String? message;
  List<PaymentMethod>? data;

  ListPaymentResult(
      {this.isLoading = true, this.state, this.message, this.data});

  factory ListPaymentResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] != true) {
      throw json['message'];
    }

    return ListPaymentResult(
        isLoading: false,
        state: true,
        message: json['Message'],
        data: List<PaymentMethod>.from(
            (json['data'] as List).map((e) => PaymentMethod.fromJson(e))));
  }
}

class PaymentMethod {
  String? code;
  String? name;
  String? icon;
  String? description;
  bool isExpanded;
  List<PaymentChannel>? channel;

  PaymentMethod(
      {this.code,
      this.isExpanded = false,
      this.name,
      this.icon,
      this.description,
      this.channel});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        code: json['Code'],
        name: json['Name'],
        icon: json['icon'],
        description: json['Description'],
        channel: List<PaymentChannel>.from(
            (json['Channels'] as List).map((x) => PaymentChannel.fromJson(x))),
      );
}

class PaymentChannel {
  String? code;
  String? name;
  String? icon;
  String? description;
  PaymentFee? fee;

  PaymentChannel({
    this.code,
    this.name,
    this.icon,
    this.description,
    this.fee,
  });

  factory PaymentChannel.fromJson(Map<String, dynamic> json) {
    return PaymentChannel(
        code: json['Code'],
        name: json['Name'],
        icon: json['icon'],
        description: json['Description'],
        fee: PaymentFee.fromJson(json['TransactionFee']));
  }
}

class PaymentFee {
  num? actualFee;
  String? feeType;
  num? additionalFee;

  PaymentFee({
    this.actualFee,
    this.feeType,
    this.additionalFee,
  });

  factory PaymentFee.fromJson(Map<String, dynamic> json) {
    return PaymentFee(
        actualFee: json['ActualFee'],
        feeType: json['ActualFeeType'],
        additionalFee: json['AdditionalFee']);
  }
}
