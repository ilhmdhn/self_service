class OrderArgs {
  String roomCategory = '';
  String roomCode = '';
  String memberCode = '';
  String memberName = '';
  List<FnBOrder> fnb = List.empty();

  OrderArgs({
    this.roomCategory = '', 
    this.roomCode = '',
    this.fnb = const [],
    this.memberCode = '',
    this.memberName = ''
  });
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
