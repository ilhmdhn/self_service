class OrderArgs {
  final String roomCategory;
  final String roomCode;
  final List<FnBOrder> fnb;
  OrderArgs(this.roomCategory, this.roomCode, this.fnb);
}

class FnBOrder {
  String? idGlobal = '';
  String? itemName = '';
  String? note = '';
  num qty;
  num price;
  String category = '';
  String image = '';

  FnBOrder(
      {this.idGlobal,
      this.itemName,
      this.note,
      this.qty = 0,
      this.price = 0,
      this.category = '',
      this.image = ''});
}
