class PromoFoodResult {
  bool isLoading;
  bool? state;
  String? message;
  List<PromoFoodData>? promo;

  PromoFoodResult(
      {this.isLoading = true, this.state, this.message, this.promo});

  factory PromoFoodResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }
    return PromoFoodResult(
        isLoading: false,
        state: json['state'],
        message: json['message'],
        promo: List<PromoFoodData>.from(
            (json['data'] as List).map((x) => PromoFoodData.fromJson(x))));
  }
}

class PromoFoodData {
  String? promoFood;
  int? syaratKamar;
  String? kamar;
  int? syaratJeniskamar;
  String? jenisKamar;
  int? syaratDurasi;
  int? durasi;
  int? syaratHari;
  int? hari;
  int? syaratJam;
  int? dateStart;
  String? timeStart;
  int? dateFinish;
  String? timeFinish;
  int? syaratInventory;
  String? inventory;
  int? syaratQuantity;
  int? quantity;
  num? diskonPersen;
  num? diskonRp;

  PromoFoodData(
      {this.promoFood,
      this.syaratKamar,
      this.kamar,
      this.syaratJeniskamar,
      this.jenisKamar,
      this.syaratDurasi,
      this.durasi,
      this.syaratHari,
      this.hari,
      this.syaratJam,
      this.dateStart,
      this.timeStart,
      this.dateFinish,
      this.timeFinish,
      this.syaratInventory,
      this.inventory,
      this.syaratQuantity,
      this.quantity,
      this.diskonPersen,
      this.diskonRp});

  factory PromoFoodData.fromJson(Map<String, dynamic> json) => PromoFoodData(
    promoFood: json['Promo_Food'],
    syaratKamar: json['Syarat_Kamar'],
    kamar: json['Kamar'],
    syaratJeniskamar: json['Syarat_Jenis_kamar'],
    jenisKamar: json['Jenis_Kamar'],
    syaratDurasi: json['Syarat_Durasi'],
    durasi: json['Durasi'],
    syaratHari: json['Syarat_Hari'],
    hari: json['Hari'],
    syaratJam: json['Syarat_Jam'],
    dateStart: json['Date_Start'],
    timeStart: json['Time_Start'],
    dateFinish: json['Date_Finish'],
    timeFinish: json['Time_Finish'],
    syaratInventory: json['Syarat_Inventory'],
    inventory: json['Inventory'],
    syaratQuantity: json['Syarat_Quantity'],
    quantity: json['Quantity'],
    diskonPersen: json['Diskon_Persen'],
    diskonRp: json['Diskon_Rp'],
  );
}