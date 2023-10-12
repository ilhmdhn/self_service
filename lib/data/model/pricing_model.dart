class ServiceTaxResult {
  bool isLoading;
  bool? state;
  String? message;
  ServiceTax? detail;

  ServiceTaxResult(
      {this.isLoading = true, this.state, this.message, this.detail});

  factory ServiceTaxResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }

    return ServiceTaxResult(
      isLoading: false,
      state: true,
      message: json['message'],
      detail: ServiceTax.fromJson(json['data'])
    );
  }
}

class ServiceTax {
  num serviceRoom;
  num taxRoom;
  num serviceFnb;
  num taxFnb;

  ServiceTax({
    this.serviceRoom = 0,
    this.taxRoom = 0,
    this.serviceFnb = 0,
    this.taxFnb = 0,
  });

  factory ServiceTax.fromJson(Map<String, dynamic> json) {
    return ServiceTax(
        serviceRoom: json['service_room'],
        taxRoom: json['tax_room'],
        serviceFnb: json['service_fnb'],
        taxFnb: json['tax_fnb']);
  }
}
