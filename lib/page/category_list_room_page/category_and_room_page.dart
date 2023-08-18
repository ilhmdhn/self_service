import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/bloc/universal_bloc.dart';
import 'package:self_service/page/category_list_room_page/category_and_room_bloc.dart';
import 'package:self_service/data/model/room_category_model.dart';
import 'package:self_service/data/model/room_list_model.dart';
import 'package:self_service/page/room_detail_page/room_detail_page.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/util/order_args.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';

class CategoryAndRoomPage extends StatelessWidget {
  CategoryAndRoomPage({Key? key}) : super(key: key);
  static const nameRoute = '/category-list-room-page';

  final RoomCategoryCubit roomCategoryCubit = RoomCategoryCubit();
  final ChooseCategoryRoom chooseCategoryCubit = ChooseCategoryRoom();
  final InputIntCubit indexChooseCategoryCubit = InputIntCubit();
  final RoomListCubit roomListCubit = RoomListCubit();

  @override
  Widget build(BuildContext context) {
    late OrderArgs orderData;
    roomCategoryCubit.getData();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Stack(children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 4,
                    child: Container(
                      decoration:
                          BoxDecoration(color: CustomColorStyle.bluePrimary()),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 123,
                            ),
                            Container(
                              width: double.infinity,
                              height: 0.7,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: BlocBuilder<RoomCategoryCubit,
                                      RoomCategoryResult>(
                                  bloc: roomCategoryCubit,
                                  builder: (context, listCategoryState) {
                                    if (listCategoryState.isLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (listCategoryState.state ==
                                        false) {
                                      return Center(
                                        child: Text(listCategoryState.message
                                            .toString()),
                                      );
                                    } else {
                                      chooseCategoryCubit.setData(
                                          listCategoryState.category?[0]);
                                      indexChooseCategoryCubit.setData(0);
                                      return BlocBuilder<InputIntCubit, int?>(
                                          bloc: indexChooseCategoryCubit,
                                          builder:
                                              (context, indexCategoryState) {
                                            return ListView.builder(
                                                itemCount: listCategoryState
                                                    .category?.length
                                                    .toInt(),
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      chooseCategoryCubit
                                                          .setData(
                                                              listCategoryState
                                                                      .category?[
                                                                  index]);
                                                      indexChooseCategoryCubit
                                                          .setData(index);
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                            child:
                                                                indexCategoryState ==
                                                                        index
                                                                    ? Stack(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.center,
                                                                              child: AutoSizeText(
                                                                                listCategoryState.category![index].roomCategoryName!,
                                                                                style: GoogleFonts.poppins(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                textAlign: TextAlign.center,
                                                                                minFontSize: 8,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    : AutoSizeText(
                                                                        listCategoryState
                                                                            .category![index]
                                                                            .roomCategoryName!,
                                                                        style: GoogleFonts.poppins(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.white),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        minFontSize:
                                                                            8,
                                                                      )),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 0.7,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          });
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 14,
                    child: Container(
                      decoration:
                          BoxDecoration(color: CustomColorStyle.lightBlue()),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23),
                        child: BlocBuilder<ChooseCategoryRoom, RoomCategory>(
                            bloc: chooseCategoryCubit,
                            builder: (context, chooseCategoryState) {
                              if (chooseCategoryState.roomCategoryName ==
                                  null) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              roomListCubit.setDate(chooseCategoryState
                                  .roomCategoryName
                                  .toString());
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 52,
                                  ),
                                  Text(
                                    'Room',
                                    style: GoogleFonts.poppins(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w800,
                                        color: CustomColorStyle.blackText()),
                                  ),
                                  const SizedBox(
                                    height: 29,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 9),
                                        constraints:
                                            const BoxConstraints(minWidth: 120),
                                        decoration: BoxDecoration(
                                            color: CustomColorStyle.darkBlue(),
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(20)),
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          child: Text(
                                            chooseCategoryState.roomCategoryName
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        height: 1,
                                        decoration: const BoxDecoration(
                                            color: Colors.grey),
                                      ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                              width: 21,
                                              height: 21,
                                              child: Image.asset(
                                                'assets/icon/tv.png',
                                              )),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            chooseCategoryState.roomCategoryTv
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 26,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                              width: 21,
                                              height: 21,
                                              child: Image.asset(
                                                'assets/icon/tag_price.png',
                                              )),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            chooseCategoryState.price
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                              width: 21,
                                              height: 21,
                                              child: Image.asset(
                                                'assets/icon/pax.png',
                                              )),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "${chooseCategoryState.roomCategoryCapacity} pax",
                                            style: GoogleFonts.poppins(
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                              width: 21,
                                              height: 21,
                                              child: Image.asset(
                                                'assets/icon/toilet.png',
                                              )),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "Toilet",
                                            style: GoogleFonts.poppins(
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BlocBuilder<RoomListCubit, RoomListResult>(
                                      bloc: roomListCubit,
                                      builder: (context, listRoomState) {
                                        if (listRoomState.isLoading) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (!(listRoomState.state ??
                                            false)) {
                                          return Center(
                                            child: Text(listRoomState.message
                                                .toString()),
                                          );
                                        }

                                        return Expanded(
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 5 / 6,
                                              crossAxisSpacing: 15,
                                              mainAxisSpacing: 10,
                                            ),
                                            itemCount: listRoomState
                                                .room!.length
                                                .toInt(),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  orderData = OrderArgs(
                                                      listRoomState.room?[index]
                                                              .roomCategory ??
                                                          '',
                                                      listRoomState.room?[index]
                                                              .roomCode ??
                                                          '');

                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          RoomDetailPage
                                                              .nameRoute,
                                                          arguments: orderData)
                                                      .then((argumenKembali) {
                                                    orderData = argumenKembali
                                                        as OrderArgs;
                                                  });
                                                },
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      AspectRatio(
                                                        aspectRatio: 1,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              imageUrl: listRoomState
                                                                      .room?[
                                                                          index]
                                                                      .roomImage ??
                                                                  ''),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 0,
                                                      ),
                                                      Text(
                                                        listRoomState
                                                            .room![index]
                                                            .roomCode
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ]),
                                              );
                                            },
                                          ),
                                        );
                                      })
                                ],
                              );
                            }),
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
            top: 4,
            left: 4,
            child: SizedBox(
              width: 35,
              height: 35,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset('assets/icon/arrow_back.png'),
                iconSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
              top: 3,
              right: 3,
              child: SizedBox(
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
              ))
        ]),
      ),
    );
  }
}
