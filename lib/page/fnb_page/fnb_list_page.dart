import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/bloc/universal_bloc.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/fnb_category.dart';
import 'package:self_service/data/model/fnb_model.dart';
import 'package:self_service/page/invoice_page/billing_page.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/page/fnb_page/fnb_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';

class FnbListPage extends StatefulWidget {
  const FnbListPage({super.key});

  static const nameRoute = '/fnb-page';

  @override
  State<FnbListPage> createState() => _FnbListPageState();
}

class _FnbListPageState extends State<FnbListPage> {
  final FnBCategoryCubit fnBCategoryCubit = FnBCategoryCubit();
  final InputCubit chooseCategorCubit = InputCubit();
  final FnBCubit fnbCubit = FnBCubit();
  final PagingController<int, FnB> _pagingController =
      PagingController(firstPageKey: 1);
  static const pageSize = 20;
  TextEditingController orderNoteController = TextEditingController();
  String stateFnbCategory = '';
  List<FnBOrder> fnbOrderData = [];
  FnBOrder orderItem = FnBOrder();
  num totalBayar = 0;

  @override
  void initState() {
    fnBCategoryCubit.setData();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    final getFnB = await ApiTest().getFnB(stateFnbCategory, pageKey);
    if (getFnB.state != true) {
      _pagingController.error = getFnB.message;
    } else if ((getFnB.data?.length ?? 0) < pageSize) {
      _pagingController.appendLastPage(getFnB.data ?? List.empty());
    } else {
      _pagingController.appendPage(getFnB.data!, pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    String listItem = '';
    totalBayar = 0;
    for (var order in fnbOrderData) {
      totalBayar += (order.qty) * (order.price);
    }

    fnbOrderData.asMap().forEach((index, item) {
      if (index == 0) {
        listItem += '${item.qty}x ${item.itemName}';
      } else {
        listItem += ' + ${item.qty}x ${item.itemName}';
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<InputCubit, String>(
              bloc: chooseCategorCubit,
              builder: (context, chooseCategoryState) {
                if (chooseCategoryState != '' &&
                    stateFnbCategory != chooseCategoryState) {
                  stateFnbCategory = chooseCategoryState;
                  // setState(() {
                  // });
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: CustomColorStyle.bluePrimary(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 117,
                              ),
                              Expanded(
                                  child: BlocBuilder<FnBCategoryCubit,
                                      FnBCategoryResult>(
                                bloc: fnBCategoryCubit,
                                builder: (context, fnbCategoryState) {
                                  if (fnbCategoryState.isLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (fnbCategoryState.state != true) {
                                    return Center(
                                      child: Text(
                                          fnbCategoryState.message.toString()),
                                    );
                                  } else if ((fnbCategoryState.data?.length ??
                                          0) ==
                                      0) {
                                    return const Center(
                                      child: Text('Data Kosong'),
                                    );
                                  }
                                  return ListView.builder(
                                      itemCount:
                                          fnbCategoryState.data?.length.toInt(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              stateFnbCategory =
                                                  fnbCategoryState.data?[index]
                                                          .categoryName ??
                                                      '';
                                            });
                                            chooseCategorCubit.getData(
                                                fnbCategoryState
                                                    .data?[index].categoryName);
                                            _pagingController.refresh();
                                            _fetchPage(1);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 5),
                                            child: Center(
                                              child: fnbCategoryState
                                                          .data?[index]
                                                          .categoryName ==
                                                      chooseCategoryState
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            fnbCategoryState
                                                                    .data?[
                                                                        index]
                                                                    .categoryName ??
                                                                '',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                          ),
                                                        ),
                                                        // const SizedBox(
                                                        //   width: 5,
                                                        // ),
                                                        // const Icon(
                                                        //   Icons.circle,
                                                        //   color: Colors.white,
                                                        //   size:
                                                        //       12, // Ganti dengan ukuran yang Anda inginkan
                                                        // )
                                                      ],
                                                    )
                                                  : Text(
                                                      fnbCategoryState
                                                              .data?[index]
                                                              .categoryName ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ))
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          color: CustomColorStyle.lightBlue(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 65,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 33),
                                child: Text(
                                  'Food',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 33),
                                child: SizedBox(
                                  height: 30,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        // searchText = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'search',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        suffixIcon: const Icon(Icons.search),
                                        filled: true,
                                        fillColor: CustomColorStyle.lightGrey(),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        suffixIconColor: Colors.grey.shade600),
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey.shade900),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 33),
                                child: Row(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: CustomColorStyle.darkBlue(),
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                20)),
                                    child: chooseCategoryState != ''
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 2),
                                            child: Text(
                                              chooseCategoryState,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1.3,
                                      color: Colors.black,
                                    ),
                                  )
                                ]),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 33),
                                    child: PagedGridView(
                                        pagingController: _pagingController,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.0 / 1.35,
                                          mainAxisSpacing: 15.0,
                                          crossAxisSpacing: 15.0,
                                        ),
                                        builderDelegate:
                                            PagedChildBuilderDelegate<FnB>(
                                          itemBuilder: (context, item, index) =>
                                              InkWell(
                                                  onTap: () {
                                                    showDialogDetailFnB(
                                                        context, item);
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Stack(children: [
                                                        AspectRatio(
                                                          aspectRatio: 1 / 1,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            child: CachedNetworkImage(
                                                                imageUrl:
                                                                    'https://adm.happypuppy.id/${item.image ?? '/uploads/Empty.jpg'}',
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .error),
                                                                progressIndicatorBuilder: (context,
                                                                        url,
                                                                        downloadProgress) =>
                                                                    Transform.scale(
                                                                        scale:
                                                                            0.3,
                                                                        child: CircularProgressIndicator(
                                                                            value: downloadProgress
                                                                                .progress)),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 5,
                                                          left: 5,
                                                          child: Container(
                                                            child: ((fnbOrderData.any((orderItem) =>
                                                                        orderItem
                                                                            .idGlobal ==
                                                                        item
                                                                            .idGlobal)) ==
                                                                    true
                                                                ? Container(
                                                                    width: 25,
                                                                    height: 25,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: CustomColorStyle
                                                                          .darkBlue(),
                                                                    ),
                                                                    child: Center(
                                                                        child: Text(
                                                                      ('${fnbOrderData.firstWhere((order) => order.idGlobal == item.idGlobal).qty}x'),
                                                                      style: GoogleFonts.poppins(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )))
                                                                : const SizedBox()),
                                                          ),
                                                        )
                                                      ]),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                              item.fnbName
                                                                  .toString(),
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: (fnbOrderData.any((orderItem) =>
                                                                              orderItem.idGlobal ==
                                                                              item
                                                                                  .idGlobal)) ==
                                                                          true
                                                                      ? CustomColorStyle
                                                                          .darkBlue()
                                                                      : Colors
                                                                          .black),
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              maxLines: 2),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                            Currency.toRupiah(
                                                                item.priceFnb),
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 9,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black),
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            maxLines: 2),
                                                      )
                                                    ],
                                                  )),
                                        ))),
                              )
                            ],
                          ),
                        ))
                  ],
                );
              }),
          Positioned(
            top: 6,
            left: 7,
            right: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 29,
                  color: Colors.white,
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
                                  child: Text('Batalkan Transaksi?')),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Tidak')),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              SplashPage.nameRoute,
                                              (route) => false);
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
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          showDialogListOrder(context);
        },
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                  height: 35,
                  child: fnbOrderData.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 33),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: CustomColorStyle.darkBlue(),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${fnbOrderData.fold(0, (sum, order) => sum + (order.qty).toInt())} item',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              listItem,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 9,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            Currency.toRupiah(totalBayar),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.fastfood_rounded,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox()),
            )
          ],
        ),
      ),
    );
  }

  void showDialogDetailFnB(BuildContext context, FnB fnb) {
    InputIntCubit qtyOrderCubit = InputIntCubit();
    int indexSame = 0;
    final isHave =
        fnbOrderData.any((orderItem) => orderItem.idGlobal == fnb.idGlobal);
    int qtyOrder = 0;
    if (isHave == true) {
      indexSame = fnbOrderData
          .indexWhere((orderItem) => orderItem.idGlobal == fnb.idGlobal);
      orderNoteController.text = fnbOrderData[indexSame].note ?? '';
      qtyOrderCubit.setData(fnbOrderData[indexSame].qty);
      qtyOrder = fnbOrderData[indexSame].qty.toInt();
    } else {
      qtyOrder = 1;
      orderNoteController.text = '';
      qtyOrderCubit.setData(1);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: CachedNetworkImage(
                        imageUrl: 'https://adm.happypuppy.id/${fnb.image}',
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Transform.scale(
                                scale: 0.3,
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<InputIntCubit, int?>(
                      bloc: qtyOrderCubit,
                      builder: (context, qtyOrderState) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                                40.0), // Radius pada pojok kiri atas
                            topRight: Radius.circular(
                                40.0), // Radius pada pojok kanan atas
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              color: CustomColorStyle.lightBlue(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 25),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fnb.fnbName.toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        Currency.toRupiah(
                                            (fnb.priceFnb ?? 0) * qtyOrder),
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (qtyOrder > 1) {
                                                setState(() {
                                                  qtyOrderCubit
                                                      .setData(--qtyOrder);
                                                });
                                              } else if (isHave) {
                                                final deleteItem =
                                                    await showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Center(
                                                              child: Text(
                                                                'Hapus pesanan?',
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            content: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context,
                                                                          false);
                                                                    },
                                                                    child: const Text(
                                                                        'Tidak')),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context,
                                                                          true);
                                                                    },
                                                                    child: Text(
                                                                      'Ya',
                                                                      style: GoogleFonts
                                                                          .poppins(),
                                                                    ))
                                                              ],
                                                            ),
                                                          );
                                                        });

                                                if (deleteItem == true) {
                                                  setState(() {
                                                    fnbOrderData
                                                        .removeAt(indexSame);
                                                  });
                                                }
                                                if (!mounted) return;
                                                Navigator.pop(context);
                                              }
                                            }, // Radius pojok
                                            child: Center(
                                                child: SizedBox(
                                              height: 23,
                                              width: 23,
                                              child: Image.asset(
                                                  'assets/icon/minus.png'),
                                            )),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            qtyOrderState.toString(),
                                            style: GoogleFonts.poppins(
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                qtyOrderCubit
                                                    .setData(++qtyOrder);
                                              });
                                            },
                                            child: Center(
                                                child: SizedBox(
                                              height: 23,
                                              width: 23,
                                              child: Image.asset(
                                                  'assets/icon/plus.png'),
                                            )),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'CATATAN',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 65,
                                        child: TextField(
                                          controller: orderNoteController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          maxLines: null,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          isHave != true
                                              ? setState(() {
                                                  fnbOrderData.add(FnBOrder(
                                                      idGlobal: fnb.idGlobal,
                                                      itemName: fnb.fnbName,
                                                      note: orderNoteController
                                                          .text,
                                                      qty: qtyOrderState ?? 0,
                                                      price: fnb.priceFnb ?? 0,
                                                      category:
                                                          fnb.categoryFnb ?? '',
                                                      image: fnb.image ?? ''));
                                                })
                                              : setState(() {
                                                  fnbOrderData[indexSame].qty =
                                                      qtyOrderState ?? 0;
                                                  fnbOrderData[indexSame].note =
                                                      orderNoteController.text;
                                                });
                                          Navigator.pop(context);
                                        },
                                        style: CustomButtonStyle
                                            .styleDarkBlueButton(),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Center(
                                            child: Text(
                                              isHave != true
                                                  ? 'TAMBAH PESANAN'
                                                  : 'UBAH PESANAN',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              //end column
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDialogListOrder(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            totalBayar = 0;
            for (var order in fnbOrderData) {
              totalBayar += (order.qty) * (order.price);
            }
            return Dialog(
                insetPadding: EdgeInsets.zero,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SizedBox(
                      child: Container(
                    color: CustomColorStyle.lightBlue(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 55,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: IconButton(
                                    alignment: Alignment.topRight,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 31,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Text(
                                    'Order Summary',
                                    style: GoogleFonts.poppins(
                                        fontSize: 21,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 38,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: fnbOrderData.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: CustomColorStyle
                                                            .darkBlue()),
                                                    child: Center(
                                                      child: Text(
                                                        '${fnbOrderData[index].qty}x',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 11),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Expanded(
                                                  flex: 7,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        fnbOrderData[index]
                                                            .itemName
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      fnbOrderData[index]
                                                                  .note !=
                                                              ''
                                                          ? Text(
                                                              'Catatan :${fnbOrderData[index].note}',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          11),
                                                            )
                                                          : const SizedBox(),
                                                      InkWell(
                                                          onTap: () async {
                                                            bool edited =
                                                                await editOrderFnB(
                                                                    context,
                                                                    index);
                                                            if (edited) {
                                                              setState(() {});
                                                            }
                                                          },
                                                          child: Text(
                                                            'Edit',
                                                            style: GoogleFonts.poppins(
                                                                color: CustomColorStyle
                                                                    .blueText(),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 11),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      Currency.toRupiah(
                                                          fnbOrderData[index]
                                                                  .qty *
                                                              fnbOrderData[
                                                                      index]
                                                                  .price),
                                                      textAlign: TextAlign.end,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13)),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            index != (fnbOrderData.length - 1)
                                                ? Container(
                                                    width: double.infinity,
                                                    height: 1,
                                                    color: Colors.grey,
                                                  )
                                                : const SizedBox(),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 145,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: GoogleFonts.poppins(fontSize: 12),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      Currency.toRupiah(totalBayar),
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, BillingPage.nameRoute);
                                        },
                                        style: CustomButtonStyle
                                            .buttonStyleDarkBlue(),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 31, vertical: 5),
                                          child: Text(
                                            'PESAN',
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ])
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                ));
          });
        });
  }

  Future<bool> editOrderFnB(BuildContext context, int index) async {
    int qtyOrder = 0;
    InputIntCubit qtyOrderCubit = InputIntCubit();
    orderNoteController.text = fnbOrderData[index].note ?? '';
    bool? edited = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        qtyOrderCubit.setData(fnbOrderData[index].qty);
        qtyOrder = fnbOrderData[index].qty.toInt();
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: CachedNetworkImage(
                        imageUrl:
                            'https://adm.happypuppy.id/${fnbOrderData[index].image}',
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Transform.scale(
                                scale: 0.3,
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      icon: const Icon(Icons.close)),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<InputIntCubit, int?>(
                      bloc: qtyOrderCubit,
                      builder: (context, qtyOrderState) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                                40.0), // Radius pada pojok kiri atas
                            topRight: Radius.circular(
                                40.0), // Radius pada pojok kanan atas
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              color: CustomColorStyle.lightBlue(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 25),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fnbOrderData[index].itemName.toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        Currency.toRupiah(
                                            fnbOrderData[index].price *
                                                qtyOrder),
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (qtyOrder > 1) {
                                                setState(() {
                                                  qtyOrderCubit
                                                      .setData(--qtyOrder);
                                                });
                                              } else {
                                                final deleteItem =
                                                    await showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Center(
                                                              child: Text(
                                                                'Hapus pesanan?',
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            content: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context,
                                                                          false);
                                                                    },
                                                                    child: const Text(
                                                                        'Tidak')),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context,
                                                                          true);
                                                                    },
                                                                    child: Text(
                                                                      'Ya',
                                                                      style: GoogleFonts
                                                                          .poppins(),
                                                                    ))
                                                              ],
                                                            ),
                                                          );
                                                        });

                                                if (deleteItem == true) {
                                                  setState(() {
                                                    fnbOrderData
                                                        .removeAt(index);
                                                  });
                                                }
                                                if (!mounted) return;
                                                Navigator.pop(context, true);
                                              }
                                            }, // Radius pojok
                                            child: Center(
                                                child: SizedBox(
                                              height: 23,
                                              width: 23,
                                              child: Image.asset(
                                                  'assets/icon/minus.png'),
                                            )),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            qtyOrderState.toString(),
                                            style: GoogleFonts.poppins(
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                qtyOrderCubit
                                                    .setData(++qtyOrder);
                                              });
                                            },
                                            child: Center(
                                                child: SizedBox(
                                              height: 23,
                                              width: 23,
                                              child: Image.asset(
                                                  'assets/icon/plus.png'),
                                            )),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'CATATAN',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 65,
                                        child: TextField(
                                          controller: orderNoteController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          maxLines: null,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            fnbOrderData[index].qty =
                                                qtyOrderState ?? 0;
                                            fnbOrderData[index].note =
                                                orderNoteController.text;
                                          });
                                          Navigator.pop(context, true);
                                        },
                                        style: CustomButtonStyle
                                            .styleDarkBlueButton(),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Center(
                                            child: Text(
                                              'UBAH PESANAN',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              //end column
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (edited == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    orderNoteController.dispose();
    super.dispose();
  }
}
