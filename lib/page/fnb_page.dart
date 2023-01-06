import 'package:flutter/material.dart';
import 'package:self_service/bloc/checkin_data_bloc.dart';
import 'package:self_service/bloc/counter_bloc.dart';
import 'package:self_service/bloc/image_url_bloc.dart';
import 'package:self_service/data/model/checkin_model.dart';
import 'package:self_service/data/model/fnb_category_model.dart';
import 'package:self_service/data/model/inventory_model.dart';
import '../bloc/fnb_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FnBPage extends StatelessWidget {
  FnBPage({super.key});

  final FnBCategoryCubit fnbCategoryCubit = FnBCategoryCubit();
  final InventoryCubit inventoryCubit = InventoryCubit();
  final CategoryInventoryNameCubit categoryNameCubit =
      CategoryInventoryNameCubit();
  final CounterCubit pageCubit = CounterCubit();
  final ImageUrlCubit imageFnBCategoryCubit = ImageUrlCubit();
  final ImageUrlCubit imageFnBCubit = ImageUrlCubit();
  final CheckinDataCubit chekinDataCubit = CheckinDataCubit();

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(title: const Text('Order Food and Beverage')),
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
                                          child: Image.network(
                                              imageFnBCategoryUrl),
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
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
                      child: BlocBuilder<InventoryCubit, InventoryResult>(
                          bloc: inventoryCubit,
                          builder: (context, state) {
                            if (state.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state.state == false) {
                              return Center(
                                child: Text(state.message.toString()),
                              );
                            }

                            return ListView.builder(
                              itemCount: state.inventory?.length ?? 0,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                CounterCubit counterCubit = CounterCubit();
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black54, width: 0.3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(state.inventory?[index].name
                                                  .toString() ??
                                              ''),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: BlocBuilder<
                                                          ImageUrlCubit,
                                                          String>(
                                                      bloc: imageFnBCubit,
                                                      builder: (context,
                                                          stateImageFnB) {
                                                        if (stateImageFnB ==
                                                            '') {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                        String imageFnBUrl =
                                                            stateImageFnB +
                                                                state
                                                                    .inventory![
                                                                        index]
                                                                    .image
                                                                    .toString();
                                                        return ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: Image.network(
                                                              imageFnBUrl),
                                                        );
                                                      }),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          counterCubit
                                                              .decrement();
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .remove_circle_outline_outlined,
                                                          size: 23,
                                                          color: Colors.red,
                                                        )),
                                                    BlocBuilder<CounterCubit,
                                                        int>(
                                                      bloc: counterCubit,
                                                      builder:
                                                          (context, state) {
                                                        return Text(
                                                          state.toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        );
                                                      },
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          counterCubit
                                                              .increment();
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .add_circle_outline_outlined,
                                                          size: 23,
                                                          color: Colors.green,
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
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
                                inventoryCubit.getData(
                                    page, 10, category, search);
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
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Pesanan Saya', style: TextStyle(fontSize: 23)),
                    Expanded(
                        child: BlocBuilder<CheckinDataCubit, CheckinData>(
                      bloc: chekinDataCubit,
                      builder: (context, stateCheckinData) {
                        if (stateCheckinData.fnbInfo!.state == false &&
                            stateCheckinData.fnbInfo!.dataOrder!.isEmpty) {
                          return const Text(
                            'Empty Order',
                            style: TextStyle(fontSize: 23),
                          );
                        }
                        return ListView.builder(
                            itemCount:
                                stateCheckinData.fnbInfo!.dataOrder!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(''),
                                ],
                              );
                            });
                      },
                    ))
                  ],
                ),
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll<Color>(Colors.red),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/splash', (Route<dynamic> route) => false);
                    },
                    child: const Text(
                      'Batal',
                      style: TextStyle(fontSize: 18),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.lime.shade800),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Kembali',
                      style: TextStyle(fontSize: 18),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Colors.green)),
                    onPressed: () {},
                    child: const Text(
                      'Lanjut',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
