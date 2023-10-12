import 'package:self_service/util/order_args.dart';

CheckinArgs calculateOrder(CheckinArgs dataCheckin) {
  num roomPrice = 0;
  num serviceRoom = 0;
  num taxRoom = 0;
  num roomTotal = 0;

  num fnbPrice = 0;
  num serviceFnb = 0;
  num taxFnb = 0;
  num fnbTotal = 0;

  dataCheckin.roomPrice?.detail?.forEach((element) {
    roomPrice = roomPrice + (element.roomTotal ?? 0);
  });

  roomPrice = roomPrice.round();
  serviceRoom = roomPrice * (dataCheckin.roomPrice?.servicePercent ?? 0) / 100;
  taxRoom = (roomPrice + serviceRoom) *
      (dataCheckin.roomPrice?.taxPercent ?? 0) /
      100;
  roomTotal = roomPrice + serviceRoom + taxRoom;

  dataCheckin.roomPrice?.roomPrice = roomPrice;
  dataCheckin.roomPrice?.serviceRoom = serviceRoom;
  dataCheckin.roomPrice?.taxRoom = taxRoom;
  dataCheckin.roomPrice?.priceTotal = roomTotal;

  return dataCheckin;
}
