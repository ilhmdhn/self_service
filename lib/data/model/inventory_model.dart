class InventoryResult {
  bool? state;
  String? message = '';
  List<Inventory>? inventory = List.empty();

  InventoryResult({
    this.state,
    this.message,
    this.inventory,
  });

  factory InventoryResult.fromJson(Map<String, dynamic> json) {
    return InventoryResult(
        state: json['state'],
        message: json['message'],
        inventory: List<Inventory>.from(
            (json['data'] as List).map((x) => Inventory.fromJson(x))));
  }
}

class Inventory {
  String? inventoryCode;
  String? inventoryIdGlobal;
  String? name;
  num? price;
  String? image;

  Inventory({
    this.inventoryCode,
    this.inventoryIdGlobal,
    this.name,
    this.price,
    this.image,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      inventoryCode: json['Inventory'],
      inventoryIdGlobal: json['InventoryID_Global'],
      name: json['Nama'],
      price: json['Price'],
      image: json['image'],
    );
  }
}
