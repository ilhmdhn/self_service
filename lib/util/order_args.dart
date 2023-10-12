import 'package:self_service/data/model/room_price_model.dart';

class OrderArgs {
  String roomCategory = '';
  String roomCode = '';
  String memberCode = '';
  String memberName = '';
  int checkinDuration = 1;
  int pax = 1;
  List<FnBOrder> fnb = [];

  OrderArgs(
      {this.roomCategory = '',
      this.roomCode = '',
      this.fnb = const [],
      this.memberCode = '',
      this.checkinDuration = 1,
      this.pax = 1,
      this.memberName = ''});
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

class CheckinArgs {
  OrderArgs? orderArgs;
  RoomPriceData? roomPrice;

  CheckinArgs({this.orderArgs, this.roomPrice});
}
