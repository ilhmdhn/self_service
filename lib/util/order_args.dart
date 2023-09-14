class OrderArgs {
  final String roomCategory;
  final String roomCode;

  OrderArgs(this.roomCategory, this.roomCode);
}

class FnBOrder {
  String? idGlobal = '';
  String? itemName = '';
  String? note = '';
  num qty;
  num price;

  FnBOrder({
    this.idGlobal,
    this.itemName,
    this.note,
    this.qty = 0,
    this.price = 0
  });
}
