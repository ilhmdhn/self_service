class OrderArgs {
  final String roomCategory;
  final String roomCode;

  OrderArgs(this.roomCategory, this.roomCode);
}

class FnBOrder {
  String? idGlobal = '';
  String? itemName = '';
  String? note = '';
  num? qty = 0;
  num? price = 0;

  FnBOrder({
    this.idGlobal,
    this.itemName,
    this.note,
    this.qty,
    this.price
  });
}
