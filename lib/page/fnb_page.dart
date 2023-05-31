import 'package:flutter/material.dart';
import 'package:self_service/bloc/counter_bloc.dart';
import 'package:self_service/bloc/image_url_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/model/checkin_model.dart';
import 'package:self_service/data/model/fnb_category_model.dart';
import 'package:self_service/data/model/inventory_model.dart';
import 'package:self_service/page/splash_screen.dart';
import 'package:self_service/page/voucher_page.dart';
import 'package:self_service/util/currency.dart';
import '../bloc/fnb_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FnBPage extends StatefulWidget {
  const FnBPage({super.key});
  static const nameRoute = '/fnb-page';
  @override
  State<FnBPage> createState() => _FnBPageState();
}

class _FnBPageState extends State<FnBPage> {
//---------------------------------------------------------

  final FnBCategoryCubit fnbCategoryCubit = FnBCategoryCubit();

  final ImageUrlCubit imageFnBCategoryCubit = ImageUrlCubit();

  final ImageUrlCubit imageFnBCubit = ImageUrlCubit();

//---------------------------------------------------------

  final OrderFnBCubit orderFnBCubit = OrderFnBCubit();

  InventoryResult inventoryResult = InventoryResult();

  DynamicCubit loadingCubit = DynamicCubit();

  static const pageSize = 8;

  String categoryCode = '';
  String categoryName = '';
  String search = '';

  final PagingController<int, Inventory> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      inventoryResult = await ApiService()
          .getInventory(pageKey, pageSize, categoryCode, search);
      if (inventoryResult.state == false) {
        throw inventoryResult.message.toString();
      }

      final isLastPage = inventoryResult.inventory!.length < pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(inventoryResult.inventory!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(inventoryResult.inventory!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
    loadingCubit.getData(false);
  }

  @override
  Widget build(BuildContext context) {
    final checkinDataArgs =
        ModalRoute.of(context)!.settings.arguments as CheckinData;
    orderFnBCubit.insertAllData(checkinDataArgs.fnbInfo.dataOrder ?? []);

    fnbCategoryCubit.getData();
    imageFnBCubit.getImageFnB();
    imageFnBCategoryCubit.getFnBCategoryImage();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Food and Beverage')),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Center(child: Text('Batalkan Transaksi?')),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Tidak')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        SplashPage.nameRoute, (route) => false);
                                  },
                                  child: const Text('Iya'))
                            ],
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.home_outlined))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 100,
            child: BlocBuilder<FnBCategoryCubit, FnBCategoryResult>(
              bloc: fnbCategoryCubit,
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.state == false) {
                  return Center(
                    child: Text(state.message ?? 'Error'),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    itemCount: state.category?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54, width: 0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: BlocBuilder<ImageUrlCubit, String>(
                            bloc: imageFnBCategoryCubit,
                            builder: (context, stateImageFnBCategory) {
                              if (stateImageFnBCategory == '') {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              String imageFnBCategoryUrl =
                                  stateImageFnBCategory +
                                      (state.category![index].fnbCategoryImage
                                          .toString());
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    loadingCubit.getData(true);
                                    _pagingController.itemList?.clear();
                                    categoryCode = state
                                            .category?[index].fnbCategoryCode
                                            .toString() ??
                                        '';
                                    categoryName = state
                                            .category?[index].fnbCategoryName
                                            .toString() ??
                                        '';
                                    _fetchPage(1);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: imageFnBCategoryUrl,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                            errorWidget: (context, url,
                                                    error) =>
                                                const Center(
                                                    child: Icon(Icons.error)),
                                          ),
                                        ),
                                      ),
                                      Text(state
                                              .category?[index].fnbCategoryName
                                              .toString() ??
                                          "")
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: categoryName != ''
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(categoryName),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  loadingCubit.getData(true);
                                  categoryName = '';
                                  categoryCode = '';
                                  _pagingController.itemList?.clear();
                                  _fetchPage(1);
                                });
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      )
                    : const SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 3),
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    hintText: 'Cari FnB',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      loadingCubit.getData(true);
                      _pagingController.itemList?.clear();
                      search = value;
                      _fetchPage(1);
                    });
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<DynamicCubit, dynamic>(
                  bloc: loadingCubit,
                  builder: (context, stateLoading) {
                    if (stateLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return PagedGridView(
                        pagingController: _pagingController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        builderDelegate: PagedChildBuilderDelegate<Inventory>(
                            itemBuilder: (context, item, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AspectRatio(
                                    aspectRatio: 3 / 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black54, width: 0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BlocBuilder<ImageUrlCubit, String>(
                                                bloc: imageFnBCubit,
                                                builder:
                                                    (context, stateImageFnB) {
                                                  String imageUrl =
                                                      stateImageFnB +
                                                          (item.image ?? '');
                                                  return AspectRatio(
                                                    aspectRatio: 16 / 9,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                          imageUrl: imageUrl),
                                                    ),
                                                  );
                                                }),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              item.name.toString(),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  orderFnBCubit.insertData(
                                                      DataOrder(
                                                          inventory: item
                                                              .inventoryCode,
                                                          quantity: 1,
                                                          notes: '',
                                                          price: item.price,
                                                          image: item.image,
                                                          name: item.name));
                                                },
                                                child: const Text('Tambahkan'))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      );
                    }
                  },
                ),
              ),
            ],
          )),
        ],
      ),
      floatingActionButton: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 20,
            ),
            BlocBuilder<OrderFnBCubit, List<DataOrder>>(
              key: UniqueKey(),
              bloc: orderFnBCubit,
              builder: (context, stateOrder) {
                checkinDataArgs.fnbInfo.dataOrder = stateOrder;
                return Container(
                  child: stateOrder.isEmpty
                      ? const SizedBox()
                      : Expanded(
                          // flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green.shade800),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Center(
                                            child: Text('Pesanan Saya')),
                                        content: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: BlocBuilder<OrderFnBCubit,
                                                List<DataOrder>>(
                                              bloc: orderFnBCubit,
                                              builder:
                                                  (context, stateOrderList) {
                                                return ListView.builder(
                                                    itemCount:
                                                        stateOrderList.length,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemBuilder:
                                                        (context, index) {
                                                      CounterCubit
                                                          quantityCubit =
                                                          CounterCubit();
                                                      quantityCubit.setValue(
                                                          stateOrderList[index]
                                                              .quantity);
                                                      return Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black54,
                                                              width: 0.3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                height: 75,
                                                                width: 133,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  child: BlocBuilder<
                                                                          ImageUrlCubit,
                                                                          String>(
                                                                      bloc:
                                                                          imageFnBCubit,
                                                                      builder:
                                                                          (context,
                                                                              stateImageFnB) {
                                                                        return CachedNetworkImage(
                                                                            imageUrl:
                                                                                stateImageFnB.toString() + stateOrderList[index].image.toString());
                                                                      }),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(stateOrderList[
                                                                            index]
                                                                        .name
                                                                        .toString()),
                                                                    Text(Currency.toRupiah(
                                                                        stateOrderList[index]
                                                                            .price)),
                                                                    BlocBuilder<
                                                                        CounterCubit,
                                                                        int>(
                                                                      bloc:
                                                                          quantityCubit,
                                                                      builder:
                                                                          (context,
                                                                              stateQty) {
                                                                        orderFnBCubit.quantityOrder(
                                                                            index,
                                                                            stateQty);
                                                                        return Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              child: stateQty > 1
                                                                                  ? IconButton(
                                                                                      onPressed: () {
                                                                                        quantityCubit.decrement();
                                                                                      },
                                                                                      icon: const Icon(
                                                                                        Icons.remove_circle_outline_outlined,
                                                                                        color: Colors.red,
                                                                                      ))
                                                                                  : IconButton(
                                                                                      onPressed: () {
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (BuildContext context) {
                                                                                              return AlertDialog(
                                                                                                title: const Center(child: Text('Hapus Item?')),
                                                                                                actions: [
                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                    children: [
                                                                                                      ElevatedButton(
                                                                                                        onPressed: () {
                                                                                                          Navigator.pop(context);
                                                                                                        },
                                                                                                        style: ButtonStyle(
                                                                                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                                                                        ),
                                                                                                        child: const Text('Tidak'),
                                                                                                      ),
                                                                                                      ElevatedButton(
                                                                                                        onPressed: () {
                                                                                                          orderFnBCubit.removeItem(index);
                                                                                                          Navigator.pop(context);
                                                                                                        },
                                                                                                        style: ButtonStyle(
                                                                                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                                                                                        ),
                                                                                                        child: const Text('Hapus'),
                                                                                                      ),
                                                                                                    ],
                                                                                                  )
                                                                                                ],
                                                                                              );
                                                                                            });
                                                                                      },
                                                                                      icon: const Icon(
                                                                                        Icons.delete,
                                                                                        color: Colors.red,
                                                                                      )),
                                                                            ),
                                                                            Text(stateOrderList[index].quantity.toString()),
                                                                            IconButton(
                                                                                onPressed: () {
                                                                                  quantityCubit.increment();
                                                                                },
                                                                                icon: const Icon(
                                                                                  Icons.add_circle_outline_rounded,
                                                                                  color: Colors.green,
                                                                                ))
                                                                          ],
                                                                        );
                                                                      },
                                                                    )
                                                                  ]),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pesanan Saya (${stateOrder.length.toString()})',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Currency.toRupiah(stateOrder.fold(
                                              0,
                                              (sum, item) =>
                                                  (sum ?? 0) +
                                                  ((item.price ?? 0) *
                                                      (item.quantity ?? 0)))),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const Icon(
                                          Icons.arrow_circle_up,
                                          color: Colors.white,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.green)),
              onPressed: () {
                Navigator.of(context).pushNamed(VoucherPage.nameRoute,
                    arguments: checkinDataArgs);
              },
              // heroTag: null,
              child: const Text('Lanjut'),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
