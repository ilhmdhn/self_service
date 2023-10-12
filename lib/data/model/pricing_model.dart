class ServiceTaxResult {
  bool isLoading;
  bool? state;
  String? message;
  ServiceTax detail = ServiceTax();

  ServiceTaxResult(
      {this.isLoading = true,
      this.state,
      this.message,
      ServiceTax? serviceTax});

  factory ServiceTaxResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] != true) {
      throw json['message'];
    }

    return ServiceTaxResult(
      isLoading: false,
      state: true,
      message: json['message'],
      serviceTax: ServiceTax.fromJson(json['data'])
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
