class PromoDataResult {
  bool isLoading;
  bool? state;
  String? message;
  List<PromoData>? promo;

  PromoDataResult(
      {this.isLoading = true, this.state, this.message, this.promo});

  factory PromoDataResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }
    return PromoDataResult(
        isLoading: false,
        state: json['state'],
        message: json['message'],
        promo: List<PromoData>.from(
            (json['data'] as List).map((x) => PromoData.fromJson(x))));
  }
}

class PromoData {
  String? name;
  num? discountPercent;
  num? discountIdr;

  PromoData({this.name, this.discountPercent, this.discountIdr});

  factory PromoData.fromJson(Map<String, dynamic> json) => PromoData(
        name: json['name'],
        discountPercent: json['discount_percent'],
        discountIdr: json['discount_idr'],
      );
}
