import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/data/model/pricing_model.dart';
import 'package:self_service/page/invoice_page/promo_page.dart';
import 'package:self_service/page/payment_page/payment_list_page.dart';
import 'package:self_service/page/payment_page/payment_page.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/page/style/text_style.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';
import 'package:self_service/page/invoice_page/invoice_bloc.dart';
import 'package:self_service/data/model/voucher_model.dart';
import 'package:self_service/util/tools.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  static const nameRoute = '/billing-page';
  @override
  Widget build(BuildContext context) {
    CheckinArgs checkinArgsTemp =
        ModalRoute.of(context)!.settings.arguments as CheckinArgs;

    final ScrollController scrollController = ScrollController();
    final TaxServiceCubit taxServiceCubit = TaxServiceCubit();
    final CheckinArgsCubit checkinArgsCubit = CheckinArgsCubit();

    taxServiceCubit.getData();

    num roomPrice = 0;
    num roomPromo = 0;
    num roomVoucher = 0;
    num roomService = 0;
    num roomTax = 0;
    num roomTotal = 0;


    num fnbPrice = 0;
    num fnbPromo = 0;
    num fnbVoucher = 0;
    num fnbService = 0;
    num fnbTax = 0;
    num fnbTotal = 0;

    num checkinService = 0;
    num checkinTax = 0;

    num checkinTotal = 0;
    num paymentPrice = 0;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, checkinArgsTemp);
        return true;
      },
      child: Scaffold(
          backgroundColor: CustomColorStyle.lightBlue(),
          body: BlocBuilder<TaxServiceCubit, ServiceTaxResult>(
            bloc: taxServiceCubit,
            builder: (context, taxServiceState) {
              if (taxServiceState.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (taxServiceState.state != true ||
                  taxServiceState.detail == null) {
                return Center(
                  child: Text(taxServiceState.message ?? ''),
                );
              }

              checkinArgsTemp.orderArgs?.fnb.taxPercent = taxServiceState.detail?.taxFnb ?? 0;
              checkinArgsTemp.orderArgs?.fnb.servicePercent = taxServiceState.detail?.serviceFnb ?? 0;
              checkinArgsTemp.roomPrice?.servicePercent = taxServiceState.detail?.serviceRoom ?? 0;
              checkinArgsTemp.roomPrice?.taxPercent = taxServiceState.detail?.taxFnb ?? 0;

              checkinArgsCubit.setData(CheckinArgs(
                  orderArgs: checkinArgsTemp.orderArgs,
                  roomPrice: checkinArgsTemp.roomPrice));

              return BlocBuilder<CheckinArgsCubit, CheckinArgs>(
                  bloc: checkinArgsCubit,
                  builder: (context, checkinArgsState) {

                    roomPrice = checkinArgsState.roomPrice?.roomPrice ?? 0;
                    roomPromo = checkinArgsState.roomPrice?.roomPromo??0;
                    roomVoucher = checkinArgsState.roomPrice?.roomVoucher??0;
                    roomService = checkinArgsState.roomPrice?.serviceRoom??0;
                    roomTax = checkinArgsState.roomPrice?.taxRoom??0;
                    roomTotal = checkinArgsState.roomPrice?.totalAll??0;

                    fnbPromo = checkinArgsState.orderArgs?.fnb.fnbPromoResult??0;
                    fnbVoucher = checkinArgsState.orderArgs?.fnb.fnbVoucherResult??0;
                    fnbService = checkinArgsState.orderArgs?.fnb.fnbServiceResult??0;
                    fnbTax = checkinArgsState.orderArgs?.fnb.fnbTaxResult??0;
                    fnbTotal = checkinArgsState.orderArgs?.fnb.totalAll??0;

                    checkinService = roomService + fnbService;
                    checkinTax = roomTax + fnbTax;
                    checkinTotal = roomTotal + fnbTotal;
                    paymentPrice = checkinArgsState.payment?.fee??0;

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 42,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context, checkinArgsState);
                                },
                                icon: const Icon(Icons.arrow_back),
                                iconSize: 29,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 45,
                                height: 45,
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Center(
                                                child: Text(
                                                    'Batalkan Transaksi?')),
                                            actions: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Tidak')),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator
                                                            .pushNamedAndRemoveUntil(
                                                                context,
                                                                SplashPage
                                                                    .nameRoute,
                                                                (route) =>
                                                                    false);
                                                      },
                                                      child: const Text('Iya'))
                                                ],
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: Image.asset('assets/icon/home.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Billing',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Text('Ruangan',
                                            style: FontBilling.textBilling())),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Text(':', style: FontBilling.textBilling()),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(checkinArgsState.orderArgs?.roomCode ??'',
                                          style: FontBilling.textBilling())),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Text('Member', style: FontBilling.textBilling())),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Text(':', style: FontBilling.textBilling()),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Text(checkinArgsState.orderArgs?.memberName ??'',
                                            style: FontBilling.textBilling())),
                                      ],
                                    ),
                                    //space height
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Text('Durasi', style: FontBilling.textBilling())),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Text(':', style: FontBilling.textBilling()),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Text('${checkinArgsState.orderArgs?.checkinDuration} JAM', 
                                                          style:FontBilling.textBilling())),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Text('Harga Room', style: FontBilling.textBilling())),
                                        Padding(
                                          padding: const EdgeInsets.symmetric( horizontal: 4),
                                          child: Text(':', style: FontBilling.textBilling()),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Text(Currency.toRupiah(roomPrice), style: FontBilling.textBilling())),
                                      ],
                                    ),
                                    roomPromo > 0?
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text('Promo Room', style: FontBilling.textBilling())),
                                          Padding(
                                            padding: const EdgeInsets.symmetric( horizontal: 4),
                                            child: Text(':', style: FontBilling.textBilling()),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(Currency.toRupiah(roomPromo), style: FontBilling.textBilling())),
                                          const SizedBox(height: 3,),
                                        ],
                                      ): const SizedBox(height: 3,),
                                    roomVoucher > 0?
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text('Voucher Room', style: FontBilling.textBilling())),
                                          Padding(
                                            padding: const EdgeInsets.symmetric( horizontal: 4),
                                            child: Text(':', style: FontBilling.textBilling()),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(Currency.toRupiah(roomVoucher), style: FontBilling.textBilling())),
                                          const SizedBox(height: 3,),
                                        ],
                                      ): const SizedBox(height: 3,),
                                  
                                  ],
                                ),
                              ),
                              //-----------
                              (checkinArgsState.orderArgs?.fnb.fnbList ?? []).isNotEmpty? 
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 7,),
                                  Text('Food and Beverages:', style: FontBilling.textBilling(),),
                                  Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: 285),
                                      child: RawScrollbar(
                                            // isAlwaysShown: true,
                                            thumbVisibility: true,
                                            thickness: 2.5,
                                            trackVisibility: true,
                                            trackColor: Colors.grey.shade300,
                                            thumbColor: CustomColorStyle.bluePrimary(),
                                            controller: scrollController,
                                            child: ListView.builder(
                                              // scrollDirection: Axis.vertical, // Atur ke Axis.horizontal jika ingin scrollbar horizontal
                                                controller: scrollController,
                                                shrinkWrap: true,
                                                physics: const ClampingScrollPhysics(),
                                                itemCount: checkinArgsState.orderArgs?.fnb.fnbList.length ??0,
                                                itemBuilder:(context, index) {
                                                  num qty = checkinArgsState.orderArgs?.fnb.fnbList[index].qty??0;
                                                  String name = checkinArgsState.orderArgs?.fnb.fnbList[index].itemName??'';
                                                  num price = checkinArgsState.orderArgs?.fnb.fnbList[index].price??0;
                                                  return Padding(
                                                          padding: const EdgeInsets.symmetric(vertical:1.8),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                  flex: 4,
                                                                  child: Text(checkinArgsState.orderArgs?.fnb.fnbList[index].qty == 1
                                                                  ? name : '$qty x $name', style: FontBilling .textBilling())),
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal:4),
                                                                child: Text(':',style: FontBilling.textBilling()),
                                                              ),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child: Text(Currency.toRupiah(price*qty), style: FontBilling.textBilling())),
                                                            ],
                                                          ),
                                                        );}),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: [
                                    fnbPromo > 0?
                                    Column(
                                      children: [
                                        const SizedBox(height: 3,),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Text('Promo FnB',style: FontBilling.textBilling())),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                                child: Text(':', style: FontBilling.textBilling()),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(Currency.toRupiah(fnbPromo),style: FontBilling.textBilling())),
                                          ],
                                        ),
                                      ],
                                    ) : const SizedBox(),
                                    fnbVoucher > 0? 
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 3,),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Text('Voucher FnB',style: FontBilling.textBilling())),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                                child: Text(':', style: FontBilling.textBilling()),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(Currency.toRupiah(fnbVoucher),style: FontBilling.textBilling())),
                                          ],
                                        ),
                                      ],
                                    ) : const SizedBox(),
                                const SizedBox(height: 3,),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text('Service', style:FontBilling.textBilling())),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Text(':',style: FontBilling.textBilling()),),
                                    Expanded(
                                      flex: 2,
                                      child: Text(Currency.toRupiah(checkinService),style:FontBilling.textBilling())),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Text('Tax', style:FontBilling.textBilling())),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Text(':', style: FontBilling.textBilling()),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Text(Currency.toRupiah(checkinTax), style:FontBilling.textBilling())),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Text('Total', style: FontBilling.textBilling())),
                                        Padding( padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Text(':',style: FontBilling.textBilling()),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Text(Currency.toRupiah(checkinTotal), style: FontBilling.textBilling())),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, PromoPage.nameRoute, arguments: checkinArgsState).then((value) {value as CheckinArgs;
                                      final caPromo = CheckinArgs(
                                        orderArgs: value.orderArgs,
                                        roomPrice: value.roomPrice,
                                        payment: null,
                                        voucher: value.voucher,
                                        promoRoom: value.promoRoom,
                                        promoFood: value.promoFood
                                      );
                                      checkinArgsCubit.setData(caPromo);
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.monetization_on_outlined, color: CustomColorStyle.darkBlue(),size: 19),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Expanded(
                                              child: Text('Promo', style: GoogleFonts.poppins( color: Colors.black, fontSize: 13),
                                            )),
                                            checkinArgsState.promoRoom != null || checkinArgsState.promoFood != null ?  
                                             Expanded(child: AutoSizeText('${checkinArgsState.promoRoom?.promoRoom??''} ${checkinArgsState.promoFood?.promoFood ??''}', textAlign: TextAlign.end, maxLines: 1,)): const SizedBox()
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios_outlined, size: 14,)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              checkinArgsState.orderArgs?.memberCode != checkinArgsState.orderArgs?.memberName
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: InkWell(
                                            onTap: () async {
                                              VoucherCubit voucherCubit = VoucherCubit();
                                              voucherCubit.setData(checkinArgsState.orderArgs?.memberCode ??'');
                                              final rtnCa = await showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                        contentPadding: EdgeInsets.zero,
                                                        content: BlocBuilder<VoucherCubit,VoucherDataResult>(
                                                            bloc: voucherCubit,
                                                            builder: (context, voucherResult) {
                                                              return SizedBox(
                                                                width: MediaQuery.of(context).size.width *0.99,
                                                                child: Container(
                                                                    padding: const EdgeInsets.all(8),
                                                                    decoration: BoxDecoration(color: CustomColorStyle.lightBlue(), borderRadius: BorderRadius.circular(20)),
                                                                    child: voucherResult.isLoading == true? 
                                                                    const Center(
                                                                        child: CircularProgressIndicator(),
                                                                          )
                                                                        : voucherResult.state == false
                                                                            ? Center(
                                                                                child: Text(
                                                                                  voucherResult.message.toString(),
                                                                                  style: GoogleFonts.poppins(fontSize: 14),
                                                                                ),
                                                                              )
                                                                            : voucherResult.voucherData == null || (voucherResult.voucherData ?? List.empty()).isEmpty
                                                                                ? Center( child: Text('Tidak memiliki voucher', style: GoogleFonts.poppins(fontSize: 14),),)
                                                                                : ListView.builder(
                                                                                    shrinkWrap: true,
                                                                                    itemCount: voucherResult.voucherData?.length,
                                                                                    itemBuilder: (context, index) {
                                                                                      VoucherData? dataVoucher = voucherResult.voucherData![index];
                                                                                      bool voucherState = true;
                                                                                      String reason = '';
                                                                                      num totalPrice = (checkinArgsState.orderArgs?.fnb.totalAll ?? 0) + (checkinArgsState.roomPrice?.totalAll ?? 0);
                                                                                      int checkinHour = checkinArgsState.orderArgs?.checkinDuration ?? 0;
                                                                                      num roomPrice = checkinArgsState.roomPrice?.roomPrice ?? 0;

                                                                                      num fnbPrice = checkinArgsState.orderArgs?.fnb.totalAll ?? 0;

                                                                                      int roomCategory = 0;
                                                                                      int voucherCategoryCondition = 0;

                                                                                      String category = (checkinArgsState.orderArgs?.roomCategory ?? '').toUpperCase();
                                                                                      String voucherRoomCategory = dataVoucher.conditionRoomType ?? '';
                                                                                      List<String> itemCondition = (dataVoucher.itemCode ?? '').split('|').map((item) => item.trim()).toList();
                                                                                      List<String> itemCode = [];
                                                                                      checkinArgsState.orderArgs?.fnb.fnbList.forEach((element) => itemCode.add(element.idGlobal ?? 'zzz'));
                                                                                      bool itemOrdered = false;
                                                                                      for (var i = 0; i < itemCondition.length; i++) {
                                                                                        if (itemCondition[i] == '') {
                                                                                          itemCondition.removeAt(i);
                                                                                        }
                                                                                      }

                                                                                      for (var element in itemCondition) {
                                                                                        if (itemCode.contains(element)) {
                                                                                          itemOrdered = true;
                                                                                        }
                                                                                      }

                                                                                      if (category.contains('SMALL')) {
                                                                                        roomCategory = 1;
                                                                                      } else if (category.contains('MEDIUM')) {
                                                                                        roomCategory = 2;
                                                                                      } else if (category.contains('LARGE')) {
                                                                                        roomCategory = 3;
                                                                                      } else {
                                                                                        roomCategory = 3;
                                                                                      }

                                                                                      if (voucherRoomCategory.contains('SMALL')) {
                                                                                        voucherCategoryCondition = 1;
                                                                                      } else if (voucherRoomCategory.contains('MEDIUM')) {
                                                                                        voucherCategoryCondition = 2;
                                                                                      } else if (voucherRoomCategory.contains('LARGE')) {
                                                                                        voucherCategoryCondition = 3;
                                                                                      } else {
                                                                                        voucherCategoryCondition = 3;
                                                                                      }

                                                                                      if (voucherState && (roomCategory > voucherCategoryCondition)) {
                                                                                        voucherState = false;
                                                                                        reason = 'Tipe Room Tidak Sesuai';
                                                                                      }

                                                                                      if (voucherState && (dataVoucher.conditionPrice ?? 0) > totalPrice) {
                                                                                        voucherState = false;
                                                                                        reason = 'Total tarif kurang';
                                                                                      }

                                                                                      if (voucherState && (dataVoucher.conditionHour ?? 0) > checkinHour) {
                                                                                        voucherState = false;
                                                                                        reason = 'Total tarif kurang';
                                                                                      }

                                                                                      if (voucherState && (dataVoucher.conditionRoomPrice ?? 0) > roomPrice) {
                                                                                        voucherState = false;
                                                                                        reason = 'Tarif room kurang';
                                                                                      }

                                                                                      if (voucherState && (dataVoucher.conditionFnbPrice ?? 0) > fnbPrice) {
                                                                                        voucherState = false;
                                                                                        reason = 'Tarif fnb kurang';
                                                                                      }

                                                                                      if (voucherState && (itemCondition.isNotEmpty && (itemOrdered == false))) {
                                                                                        voucherState = false;
                                                                                        reason = 'FnB tidak dibeli';
                                                                                      }

                                                                                      return Column(
                                                                                        children: [
                                                                                          Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              CachedNetworkImage(width: 90, imageUrl: 'https://adm.happypuppy.id/${voucherResult.voucherData?[index].image}'),
                                                                                              const SizedBox(
                                                                                                height: 2,
                                                                                              ),
                                                                                              Expanded(
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                  child: Column(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        voucherResult.voucherData![index].voucherName.toString(),
                                                                                                        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500),
                                                                                                        overflow: TextOverflow.clip,
                                                                                                      ),
                                                                                                      Text(
                                                                                                        reason,
                                                                                                        style: GoogleFonts.poppins(fontSize: 9, color: Colors.grey.shade800),
                                                                                                      )
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                children: [
                                                                                                  SizedBox(
                                                                                                    width: 60,
                                                                                                    height: 25,
                                                                                                    child: checkinArgsState.voucher?.voucherCode == voucherResult.voucherData![index].voucherCode
                                                                                                        ? ElevatedButton(
                                                                                                            onPressed: () {
                                                                                                              checkinArgsState.voucher = null;
                                                                                                              Navigator.pop(context, checkinArgsState);
                                                                                                            },
                                                                                                            style: ElevatedButton.styleFrom(
                                                                                                                minimumSize: Size.zero, // Set this
                                                                                                                padding: EdgeInsets.zero, // and this
                                                                                                                backgroundColor: Colors.redAccent,
                                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                                                                                                            child: Text(
                                                                                                              'BATAL',
                                                                                                              maxLines: 2,
                                                                                                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                                                                                            ))
                                                                                                        : ElevatedButton(
                                                                                                            onPressed: () {
                                                                                                              if (voucherState) {
                                                                                                                checkinArgsState.voucher = voucherResult.voucherData?[index];
                                                                                                                Navigator.pop(context, checkinArgsState);
                                                                                                              }
                                                                                                            },
                                                                                                            style: ElevatedButton.styleFrom(
                                                                                                                minimumSize: Size.zero, // Set this
                                                                                                                padding: EdgeInsets.zero, // and this
                                                                                                                backgroundColor: voucherState ? const Color(0xff3c7fb4) : CustomColorStyle.darkGrey(),
                                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                                                                                                            child: Text(
                                                                                                              'CLAIM',
                                                                                                              maxLines: 2,
                                                                                                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                                                                                            )),
                                                                                                  ),
                                                                                                  const SizedBox(
                                                                                                    height: 5,
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    onTap: () {
                                                                                                      showDialog(
                                                                                                          context: context,
                                                                                                          builder: (BuildContext context) {
                                                                                                            return AlertDialog(
                                                                                                              contentPadding: const EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
                                                                                                              content: SizedBox(
                                                                                                                width: MediaQuery.of(context).size.width * 0.8,
                                                                                                                height: MediaQuery.of(context).size.height * 0.6,
                                                                                                                child: Column(children: [
                                                                                                                  Align(
                                                                                                                    alignment: Alignment.topRight,
                                                                                                                    child: InkWell(
                                                                                                                      onTap: () {
                                                                                                                        Navigator.pop(context);
                                                                                                                      },
                                                                                                                      child: const Icon(Icons.close),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Expanded(
                                                                                                                    child: SingleChildScrollView(
                                                                                                                      child: HtmlWidget(voucherResult.voucherData?[index].description ?? ''),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ]),
                                                                                                              ),
                                                                                                            );
                                                                                                          });
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      'S&K',
                                                                                                      style: GoogleFonts.poppins(fontSize: 11, color: Colors.redAccent),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              const SizedBox(
                                                                                                height: 12,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 7,
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    })),
                                                              );
                                                            }));
                                                  });

                                              if (rtnCa != null) {
                                                rtnCa as CheckinArgs;

                                                CheckinArgs? ca = CheckinArgs(
                                                  orderArgs: rtnCa.orderArgs,
                                                  roomPrice: rtnCa.roomPrice,
                                                  payment: null,
                                                  voucher: rtnCa.voucher,
                                                  promoRoom: rtnCa.promoRoom,
                                                  promoFood: rtnCa.promoFood
                                                );
                                                checkinArgsCubit.setData(ca);
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Icon(Icons.discount, color: CustomColorStyle.darkBlue(), size: 19),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                        'Voucher',
                                                        style: GoogleFonts.poppins( color: Colors.black,fontSize: 13),
                                                      )),
                                                      Expanded(
                                                          child: AutoSizeText((checkinArgsState.voucher?.voucherName ??''),
                                                        style: GoogleFonts.poppins(fontSize: 11),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.end,
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.arrow_forward_ios_outlined,
                                                  size: 14,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, PaymentMethodListPage.nameRoute, arguments: checkinTotal).then((value) {
                                      if (value != null) {
                                        value as PaymentMethodArgs;
                                        checkinArgsState.payment = PaymentMethodArgs(
                                          paymentMethod: value.paymentMethod,
                                          paymentChannel: value.paymentChannel,
                                          name: value.name,
                                          fee: value.fee,
                                          icon: value.icon,
                                        );

                                        checkinArgsCubit.setData(
                                          CheckinArgs(
                                            orderArgs: checkinArgsState.orderArgs,
                                            roomPrice: checkinArgsState.roomPrice,
                                            voucher: checkinArgsState.voucher,
                                            promoRoom: checkinArgsState.promoRoom,
                                            promoFood: checkinArgsState.promoFood,
                                            payment: checkinArgsState.payment
                                            ));
                                      }
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.payment, color: CustomColorStyle.darkBlue(), size: 19),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Expanded(
                                                child: Text('Metode Pembayaran', style: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
                                            )),
                                            Expanded(
                                                child: AutoSizeText(
                                                checkinArgsState.payment?.name != null
                                                ? (checkinArgsState.payment?.name ??''): '',
                                              textAlign: TextAlign.end,
                                              maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 14,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              checkinArgsState.payment?.fee != null
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Biaya transfer',
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: Colors.black87),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          Currency.toRupiah(checkinArgsState.payment?.fee),
                                          style: GoogleFonts.poppins(fontSize: 11, color: Colors.black87),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total', style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
                                  Text(Currency.toRupiah(checkinTotal + paymentPrice), style: GoogleFonts.poppins(fontWeight: FontWeight.w700),)
                                ],
                              ),
                              const SizedBox(height: 12,),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if(checkinArgsState.payment!=null){
                                      Navigator.pushNamed(context, PaymentPage.nameRoute, arguments: checkinArgsState) .then((value) => checkinArgsState = value as CheckinArgs);
                                    }else{
                                      showToastWarning('Metode pembayaran belum dipilih');
                                    }
                                  },
                                  style: CustomButtonStyle.buttonStyleDarkBlue(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 31, 
                                      vertical: 5),
                                    child: Text('BAYAR', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 9,
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  });
            },
          )),
    );
  }
}