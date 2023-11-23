import 'package:self_service/data/model/voucher_model.dart';
import 'package:self_service/util/order_args.dart';
import 'package:self_service/util/tools.dart';

CheckinArgs calculateOrder(CheckinArgs dataCheckin) {
  num roomPrice = 0;
  num serviceRoom = 0;
  num taxRoom = 0;
  num roomTotal = 0;

  num fnbPrice = 0;
  num serviceFnb = 0;
  num taxFnb = 0;
  num fnbTotal = 0;

  num finalVoucher = 0;

//voucher nilai
  num voucherPrice = dataCheckin.voucher?.voucherPrice ?? 0;
  finalVoucher = finalVoucher + voucherPrice;

// voucher room
  bool isVoucherHour = false;
  int vcrMinute = 0;
  num vcrRoomPrice = (dataCheckin.voucher?.voucherRoomPrice ?? 0);
  num vcrRoomPercent = (dataCheckin.voucher?.voucherRoomDiscount ?? 0);
  num vcrRoomPercentResult = 0;

// promo room
  num promoRoomPercent = dataCheckin.promoRoom?.diskonPersen ?? 0;
  num promoRoomRupiah = dataCheckin.promoRoom?.diskonRp ?? 0;

// voucher fnb
  num voucherFnbPercent = (dataCheckin.voucher?.voucherFnbDiscount ?? 0);
  num vcrFnbPercentResult = 0;
  num vcrFnbPrice = (dataCheckin.voucher?.voucherFnbPrice??0);

// promo fnb
  num promoFoodPercent = (dataCheckin.promoFood?.diskonPersen ?? 0);
  num promoFoodRupiah = (dataCheckin.promoFood?.diskonRp ?? 0);

  if ((dataCheckin.voucher?.voucherHour ?? 0) > 0) {
    isVoucherHour = true;
    vcrMinute = dataCheckin.voucher!.voucherHour! * 60;
  }

  VoucherData? dataVoucher = dataCheckin.voucher;

  List<String> itemCondition = (dataVoucher?.itemCode ?? '')
      .split('|')
      .map((item) => item.trim())
      .toList();

//-------------- CALCULATE ROOM PRICE -------------------------
  dataCheckin.roomPrice?.detail?.asMap().forEach((key, value) {
    double pricePerMinute = dataCheckin.roomPrice?.detail?[key].pricePerMinute ?? 0;
    int usedMinute = dataCheckin.roomPrice?.detail?[key].usedMinute ?? 0;
    dataCheckin.roomPrice?.detail?[key].promoTotal = 0;
    dataCheckin.roomPrice?.detail?[key].promoPercent = 0;
    dataCheckin.roomPrice?.detail?[key].vcrMinute = 0;
    dataCheckin.roomPrice?.detail?[key].priceTotal = pricePerMinute * usedMinute;
  });


//-------------- CALCULATE ROOM VOUCHER HOUR -------------------------
  dataCheckin.roomPrice?.detail?.asMap().forEach((index, element) {
    if (isVoucherHour && vcrMinute > 0 && (element.priceTotal ?? 0) > 0) {
      int usedMinute = element.usedMinute ?? 0;
      int cutMinute = 0;
      if (vcrMinute <= usedMinute) {
        cutMinute = vcrMinute;
      } else if (vcrMinute > usedMinute) {
        cutMinute = usedMinute;
      }

      vcrMinute -= cutMinute;
      num vcrHourValue = (cutMinute * (element.pricePerMinute ?? 0));
      dataCheckin.roomPrice?.detail?[index].vcrMinute = cutMinute;
      dataCheckin.roomPrice?.detail?[index].priceTotal = (dataCheckin.roomPrice?.detail?[index].priceTotal ?? 0) - vcrHourValue;
    }
  });


//-------------- CALCULATE ROOM PROMO PERCENT -------------------------
  if (dataCheckin.promoRoom != null && promoRoomPercent > 0) {
    DateTime startPromo = convertToEndTime(dataCheckin.promoRoom?.timeStart ?? '00:00:00');
    DateTime endPromo = convertToEndTime(dataCheckin.promoRoom?.timeFinish ?? '23:59:59');
    int nextDay = dataCheckin.promoRoom?.dateFinish ?? 0;
    endPromo = endPromo.add(const Duration(minutes: 1));

    if (dataCheckin.promoRoom?.dateFinish == 1) {
      endPromo = endPromo.add(const Duration(days: 1));
    }

    bool addDate = false;
    int addedDate = 0;

    dataCheckin.roomPrice?.detail?.asMap().forEach((key, value) {
      bool inTimePromo = false;
      DateTime startTime = convertToEndTime(value.startTime ?? '23:59:59');
      DateTime finishTime = convertToEndTime(value.finishTime ?? '23:59:59');
      if (addDate) {
        startTime = startTime.add(const Duration(days: 1));
        finishTime = finishTime.add(const Duration(days: 1));
      }
      if (startTime.isAfter(finishTime)) {
        addDate = true;
        addedDate++;
        finishTime = finishTime.add(Duration(days: addedDate));
      }
      if ((startTime.isAfter(startPromo) || startTime.isAtSameMomentAs(startPromo)) && finishTime.isBefore(endPromo)) {
        inTimePromo = true;
      }

      if (nextDay == 1 && finishTime.isBefore(endPromo)) {
        inTimePromo = true;
      }

      if ((value.priceTotal ?? 0) > 0 && inTimePromo) {
        num promoPercent = dataCheckin.promoRoom?.diskonPersen ?? 0;
        if ((value.priceTotal ?? 0) > 0) {
          num totalRoom = value.priceTotal ?? 0;
          num promoValue = (totalRoom * promoPercent / 100);
          dataCheckin.roomPrice?.detail?[key].priceTotal = totalRoom - promoValue;
          dataCheckin.roomPrice?.detail?[key].promoTotal = promoValue;
          dataCheckin.roomPrice?.detail?[key].promoPercent = promoPercent.toInt();
        }
      }
    });
  }

  dataCheckin.roomPrice?.detail?.forEach((element) {
    roomPrice += (element.priceTotal ?? 0);
  });

//-------------- CALCULATE ROOM VOUCHER PERCENT -------------------------
  if (vcrRoomPercent > 0) {
    vcrRoomPercentResult = (vcrRoomPercent / 100) * roomPrice;
    roomPrice -= vcrRoomPercentResult;
    finalVoucher += vcrRoomPercentResult;
  }

//-------------- CALCULATE VOUCHER RP -------------------------
  if (voucherPrice > 0) {
    num thisVcrUse = 0;
    if (roomPrice <= voucherPrice) {
      thisVcrUse = roomPrice;
    } else {
      thisVcrUse = voucherPrice;
    }

    voucherPrice -= thisVcrUse;
    roomPrice -=thisVcrUse;
    finalVoucher += thisVcrUse;
  }

//-------------- CALCULATE ROOM VOUCHER RP -------------------------
    
    if(vcrRoomPrice>0){
      num thisVcrUse = 0;
      if(roomPrice<=vcrRoomPrice){
        thisVcrUse= roomPrice;
      }else{
        thisVcrUse = vcrRoomPercent;
      }
      roomPrice -= thisVcrUse;
      finalVoucher += thisVcrUse;
    }

//-------------- CALCULATE ROOM PROMO RP -------------------------
    
    if(promoRoomRupiah>0){
      num thisPromoUse = 0;
      if(roomPrice<=vcrRoomPrice){
        thisPromoUse= roomPrice;
      }else{
        thisPromoUse = vcrRoomPercent;
      }
      roomPrice -= thisPromoUse;
    }



  if (roomPrice < 0) {
    roomPrice = 0;
  }


  roomPrice = roomPrice.round();

  serviceRoom = roomPrice * ((dataCheckin.roomPrice?.servicePercent ?? 0) / 100);
  taxRoom = (roomPrice + serviceRoom) * ((dataCheckin.roomPrice?.taxPercent ?? 0) / 100);
  roomTotal = roomPrice + serviceRoom + taxRoom;

//-------------- CALCULATE FNB PRICE -------------------------
  if (dataCheckin.orderArgs?.fnb.fnbList != [] && dataCheckin.orderArgs?.fnb.fnbList != null) {
    final fnbList = dataCheckin.orderArgs?.fnb.fnbList ?? [];

    for (int fnbListIndex = 0; fnbListIndex < fnbList.length; fnbListIndex++) {
      FnBDetail fnbData = fnbList[fnbListIndex];
      num service = 0;
      num tax = 0;


    dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].pricePromo = 0;
    dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal = fnbData.qty * fnbData.price;

//-------------- CALCULATE FNB VOUCHER ITEM -------------------------
      if ((dataVoucher != null) && itemCondition.isNotEmpty) {
        int qtyVoucher = dataVoucher.qty ?? 0;
        do {
          if (itemCondition.contains(fnbList[fnbListIndex].idGlobal)) {
            num itemPromoValue = dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].price??0;
            dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].pricePromo += itemPromoValue;
            num thisPromoAccumulate = dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].pricePromo??0;
            dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal -= thisPromoAccumulate;
          }
          qtyVoucher--;
        } while (qtyVoucher > 0);
      }

//-------------- CALCULATE FNB VOUCHER PERCENT -------------------------
  num thisTotalPrice = dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal??0;
  if (voucherFnbPercent > 0 && thisTotalPrice>0) {

    num thisPromoPercentResult = thisTotalPrice * (voucherFnbPercent / 100);
    vcrFnbPercentResult += thisPromoPercentResult;
    
    dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].pricePromo += thisPromoPercentResult;
    dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal -= thisPromoPercentResult;
  }


//-------------- CALCULATE FNB PROMO PERCENT -------------------------
    
    if (dataCheckin.promoFood != null) {
      thisTotalPrice = dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal??0;
      num thisPromoPercentResult = 0;
    if (dataCheckin.promoFood?.syaratInventory == 1 && (dataCheckin.promoFood?.inventory ?? '') != '') {
        if(fnbData.idGlobal == dataCheckin.promoFood?.inventory && thisTotalPrice>0){
          thisPromoPercentResult = fnbData.price * promoFoodPercent / 100;
          if(thisTotalPrice<thisPromoPercentResult){
            thisPromoPercentResult = thisTotalPrice;
          }
        }
    } else {
      thisPromoPercentResult = thisTotalPrice * promoFoodPercent / 100;
    }
    dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].pricePromo += thisPromoPercentResult;
    dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal -= thisPromoPercentResult;
  }
    finalVoucher = finalVoucher + vcrFnbPercentResult;


//-------------- CALCULATE VOUCHER PRICE -------------------------

  if (voucherPrice > 0) {
    thisTotalPrice = dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal??0;
    num thisPriceValue = 0;
    if (thisTotalPrice <= voucherPrice) {
      thisPriceValue = thisTotalPrice;
    } else {
      thisPriceValue = thisTotalPrice;
    }
      dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal -= thisPriceValue;
      voucherPrice -= thisPriceValue;
  }

//-------------- CALCULATE VOUCHER FNB PRICE -------------------------

if(vcrFnbPrice>0){
  thisTotalPrice = dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal??0;
  num thisFnBPriceValue = 0;
  if(thisTotalPrice>0){
    if(thisTotalPrice<=vcrFnbPrice){
      thisFnBPriceValue = thisTotalPrice;
    } else{
      thisFnBPriceValue = vcrFnbPrice;
    }

    dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal -= thisFnBPriceValue;
    vcrFnbPrice -= thisFnBPriceValue;
  }
}

//-------------- CALCULATE PROMO FNB RP -------------------------

if(promoFoodRupiah>0){
    thisTotalPrice = dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal??0;
    num thisFnbPromoValue = 0;
    if(thisTotalPrice>0){
      if(thisTotalPrice<=promoFoodRupiah){
        thisFnbPromoValue = thisTotalPrice;
      }else{
        thisFnbPromoValue = promoFoodRupiah;
      }
      dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal -= thisFnbPromoValue;
      promoFoodRupiah -= thisFnbPromoValue;
    }
}

//-------------- CALCULATE FNB TAX AND SERVICE -------------------------
      if (fnbData.isService == 1) {
        num fnbPercent = (dataCheckin.orderArgs?.fnb.servicePercent ?? 0);
        service = (dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal??0) * fnbPercent /100;
        
      }

      if (fnbData.isTax == 1) {
        num taxPercent = (dataCheckin.orderArgs?.fnb.taxPercent ?? 0);
        tax = ((dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal??0) + service) * taxPercent/100;
      }

      serviceFnb += service;
      taxFnb += tax;
      thisTotalPrice = dataCheckin.orderArgs?.fnb.fnbList[fnbListIndex].priceTotal??0;
      fnbPrice += thisTotalPrice;
    
    //END LOOP FNB
    }


//END IF FNB NOT EMPTY
  }


  if (fnbTotal < 0) {
    fnbTotal = 0;
  }

  fnbTotal = fnbTotal.round();
  fnbTotal = fnbPrice + serviceFnb + taxFnb;

  dataCheckin.roomPrice?.roomPrice = roomPrice;
  dataCheckin.roomPrice?.serviceRoom = serviceRoom;
  dataCheckin.roomPrice?.taxRoom = taxRoom;
  dataCheckin.roomPrice?.priceTotal = roomTotal;

  dataCheckin.orderArgs?.fnb.fnbTotal = fnbPrice;
  dataCheckin.orderArgs?.fnb.fnbService = serviceFnb;
  dataCheckin.orderArgs?.fnb.fnbTax = taxFnb;
  dataCheckin.orderArgs?.fnb.totalAll = fnbTotal;

  if (dataCheckin.voucher != null) {
    dataCheckin.voucher?.finalValue = finalVoucher;
  }

  return dataCheckin;
}
