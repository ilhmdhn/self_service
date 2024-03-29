// class InventoryResult {
//   bool isLoading;
//   bool? state;
//   String? message = '';
//   List<Inventory>? inventory = List.empty();

//   InventoryResult({
//     this.isLoading = true,
//     this.state,
//     this.message,
//     this.inventory,
//   });

//   factory InventoryResult.fromJson(Map<String, dynamic> json) {
//     if (json['state'] == false) {
//       throw json['message'];
//     }
//     return InventoryResult(
//         isLoading: false,
//         state: json['state'],
//         message: json['message'],
//         inventory: List<Inventory>.from(
//             (json['data'] as List).map((x) => Inventory.fromJson(x))));
//   }
// }

// class InventorySingleResult {
//   bool isLoading;
//   bool? state;
//   String? message;
//   Inventory? inventory;

//   InventorySingleResult(
//       {this.isLoading = true, this.state, this.message, this.inventory});

//   factory InventorySingleResult.fromJson(Map<String, dynamic> json) {
//     if (json['state'] == false) {
//       throw json['message'];
//     }
//     return InventorySingleResult(
//         isLoading: false,
//         state: json['state'],
//         message: json['message'],
//         inventory: Inventory.fromJson(json['data']));
//   }
// }

// class Inventory {
//   String? inventoryCode;
//   String? inventoryIdGlobal;
//   String? name;
//   num? price;
//   String? image;

//   Inventory({
//     this.inventoryCode,
//     this.inventoryIdGlobal,
//     this.name,
//     this.price,
//     this.image,
//   });

//   factory Inventory.fromJson(Map<String, dynamic> json) {
//     return Inventory(
//       inventoryCode: json['Inventory'],
//       inventoryIdGlobal: json['InventoryID_Global'],
//       name: json['Nama'],
//       price: json['Price'],
//       image: json['image'],
//     );
//   }
// }
