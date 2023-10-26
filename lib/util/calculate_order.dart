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

  num itemCount = 0;
  dataCheckin.orderArgs?.fnb.fnbList.forEach((element) {
    print('${element.itemName} service ${element.isService}');
    itemCount += element.price;
  });

  print('DEBUGGING ' + itemCount.toString());

  dataCheckin.roomPrice?.detail?.forEach((element) {
    roomPrice = roomPrice + (element.roomTotal ?? 0);
  });

  if (dataCheckin.orderArgs?.fnb.fnbList != [] &&
      dataCheckin.orderArgs?.fnb.fnbList != null) {
    for (var element in dataCheckin.orderArgs!.fnb.fnbList) {
      num service = 0;
      if (element.isService == 1) {
        service = ((element.price * element.qty) *
            (dataCheckin.orderArgs?.fnb.servicePercent ?? 0) /
            100);
      }
      if (element.isTax == 1) {
        taxFnb = taxFnb +
            (((element.price * element.qty) + service) *
                (dataCheckin.orderArgs?.fnb.taxPercent ?? 0) /
                100);
      }

      serviceFnb = serviceFnb + service;
      fnbPrice = fnbPrice + (element.price * element.qty);
    }
  }

  roomPrice = roomPrice.round();
  serviceRoom = roomPrice * (dataCheckin.roomPrice?.servicePercent ?? 0) / 100;
  taxRoom = (roomPrice + serviceRoom) *
      (dataCheckin.roomPrice?.taxPercent ?? 0) /
      100;
  roomTotal = roomPrice + serviceRoom + taxRoom;

  fnbTotal = fnbPrice + serviceFnb + taxFnb;

  dataCheckin.roomPrice?.roomPrice = roomPrice;
  dataCheckin.roomPrice?.serviceRoom = serviceRoom;
  dataCheckin.roomPrice?.taxRoom = taxRoom;
  dataCheckin.roomPrice?.priceTotal = roomTotal;

  dataCheckin.orderArgs?.fnb.fnbTotal = fnbPrice;
  dataCheckin.orderArgs?.fnb.fnbService = serviceFnb;
  dataCheckin.orderArgs?.fnb.fnbTax = taxFnb;
  dataCheckin.orderArgs?.fnb.totalAll = fnbTotal;

  return dataCheckin;
}
