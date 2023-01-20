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
  final FnBCategoryCubit fnbCategoryCubit = FnBCategoryCubit();

  final InventoryCubit inventoryCubit = InventoryCubit();

  final CategoryInventoryNameCubit categoryNameCubit =
      CategoryInventoryNameCubit();

  final CounterCubit pageCubit = CounterCubit();

  final ImageUrlCubit imageFnBCategoryCubit = ImageUrlCubit();

  final ImageUrlCubit imageFnBCubit = ImageUrlCubit();

  final OrderFnBCubit orderFnBCubit = OrderFnBCubit();

  static const pageSize = 20;
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
      final newItems =
          await ApiService().getInventory(pageKey, pageSize, '', '');
      print(newItems.message);
      if (newItems.state == false) {
        throw newItems.message.toString();
      }

      final isLastPage = newItems.inventory!.length < pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems.inventory!);
      } else {
        final nextPageKey = pageKey + newItems.inventory!.length;
        _pagingController.appendPage(newItems.inventory!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkinDataArgs =
        ModalRoute.of(context)!.settings.arguments as CheckinData;
    if (checkinDataArgs.fnbInfo.dataOrder != null) {
      // orderFnBCubit.insertData();
    }
    String category = '';
    String search = '';
    String categoryName = '';
    int page = 1;
    if (category == '') {
      categoryName = 'ALL';
    }
    pageCubit.increment();
    fnbCategoryCubit.getData();
    categoryNameCubit.getData(categoryName);
    inventoryCubit.getData(page, 10, category, search);
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
                                  category = state
                                          .category?[index].fnbCategoryCode
                                          .toString() ??
                                      '';
                                  categoryNameCubit.getData(
                                      state.category?[index].fnbCategoryName);
                                  inventoryCubit.getData(
                                      1, 10, category, search);
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
                                            // fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Text(state
                                              .category?[index].fnbCategoryName
                                              .toString() ??
                                          ""),
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
              BlocBuilder<CategoryInventoryNameCubit, String>(
                bloc: categoryNameCubit,
                builder: (context, state) => Text(
                  state,
                  style: const TextStyle(fontSize: 23),
                ),
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
                    categoryNameCubit.getData('ALL');
                    pageCubit.reset();
                    inventoryCubit.getData(1, 10, '', value);
                  },
                ),
              ),
              Expanded(
                child: PagedGridView(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Inventory>(
                      itemBuilder: (context, item, index) => Container(
                            child: Text(item.name.toString()),
                          )),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          pageCubit.decrement();
                        },
                        icon: const Icon(Icons.navigate_before)),
                    BlocBuilder<CounterCubit, int>(
                        bloc: pageCubit,
                        builder: (context, state) {
                          page = state;
                          if (page == 0) {
                            page = 1;
                          }
                          inventoryCubit.getData(page, 10, category, search);
                          return Text(
                            page.toString(),
                            style: const TextStyle(fontSize: 21),
                          );
                        }),
                    IconButton(
                        onPressed: () {
                          pageCubit.increment();
                        },
                        icon: const Icon(Icons.navigate_next)),
                  ],
                ),
              )
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green.shade800),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pesanan Saya (1)',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Rp10.000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Icon(
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

/*
Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Pesanan Saya', style: TextStyle(fontSize: 23)),
                    Expanded(
                        child: BlocBuilder<OrderFnBCubit, List<DataOrder>>(
                      bloc: orderFnBCubit,
                      builder: (context, stateOrderData) {
                        checkinDataArgs.fnbInfo.dataOrder = stateOrderData;
                        if (stateOrderData.isEmpty) {
                          return const Center(
                            child: Text(
                              'Empty Order',
                              style: TextStyle(fontSize: 23),
                            ),
                          );
                        }
                        return ListView.builder(
                            itemCount: stateOrderData.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final SingleFnBCubit singleFnBCubit =
                                  SingleFnBCubit();
                              singleFnBCubit
                                  .getData(stateOrderData[index].inventory);
                              return BlocBuilder<SingleFnBCubit,
                                      InventorySingleResult>(
                                  bloc: singleFnBCubit,
                                  builder: (context, stateSingleFnB) {
                                    final CounterCubit counterFnb =
                                        CounterCubit();
                                    counterFnb.setValue(
                                        stateOrderData[index].quantity);

                                    if (stateSingleFnB.isLoading == true) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (stateSingleFnB.state == false) {
                                      return Center(
                                        child: Text(
                                            stateSingleFnB.message.toString()),
                                      );
                                    }
                                    return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black54,
                                              width: 0.3),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  stateSingleFnB.inventory!.name
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: BlocBuilder<
                                                        ImageUrlCubit, String>(
                                                      bloc: imageFnBCubit,
                                                      builder: (context,
                                                          imageUrlState) {
                                                        String fnBImageUrl =
                                                            imageUrlState +
                                                                (stateSingleFnB
                                                                        .inventory
                                                                        ?.image ??
                                                                    "");
                                                        return ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                fnBImageUrl,
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        downloadProgress) =>
                                                                    Center(
                                                              child: CircularProgressIndicator(
                                                                  value: downloadProgress
                                                                      .progress),
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Center(
                                                                    child: Icon(
                                                                        Icons
                                                                            .error)),
                                                            fit: BoxFit.fill,
                                                          ),

                                                          /*Image.network(
                                                              imageUrlState +
                                                                  stateSingleFnB
                                                                      .inventory!
                                                                      .image
                                                                      .toString(),
                                                                      ),*/
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                counterFnb
                                                                    .decrement();
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .remove_circle_outline_outlined,
                                                                size: 23,
                                                                color:
                                                                    Colors.red,
                                                              )),
                                                          BlocBuilder<
                                                              CounterCubit,
                                                              int>(
                                                            bloc: counterFnb,
                                                            builder: (context,
                                                                state) {
                                                              stateOrderData[
                                                                          index]
                                                                      .quantity =
                                                                  state;
                                                              orderFnBCubit
                                                                  .changeQuantity(
                                                                      index,
                                                                      state);
                                                              return Text(
                                                                state
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            18),
                                                              );
                                                            },
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                counterFnb
                                                                    .increment();
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .add_circle_outline_outlined,
                                                                size: 23,
                                                                color: Colors
                                                                    .green,
                                                              ))
                                                        ],
                                                      ),
                                                      ElevatedButton.icon(
                                                          onPressed: () {
                                                            TextEditingController
                                                                orderNoteController =
                                                                TextEditingController();
                                                            showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                title: const Text(
                                                                    'Catatan Order'),
                                                                content:
                                                                    TextField(
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                  ),
                                                                  controller:
                                                                      orderNoteController,
                                                                  maxLength:
                                                                      250,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                  maxLines:
                                                                      null,
                                                                ),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context,
                                                                            ''),
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context,
                                                                          orderNoteController
                                                                              .text);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            'OK'),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                                .then(
                                                                    (value) => {
                                                                          orderFnBCubit.addNotes(
                                                                              index,
                                                                              value ?? '')
                                                                        });
                                                          },
                                                          icon: const Icon(
                                                              Icons.notes),
                                                          label: const Text(
                                                              'Order Note'))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                  top: 5,
                                                  bottom: 5),
                                              child: Text(
                                                  'Catatan: ${stateOrderData[index].notes ?? ''}'),
                                            )
                                          ],
                                        ));
                                  });
                            });
                      },
                    ))
                  ],
                ),
              )
            
*/