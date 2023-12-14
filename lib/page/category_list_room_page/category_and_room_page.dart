import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/model/new_room_model.dart';
import 'package:self_service/page/category_list_room_page/category_and_room_bloc.dart';
import 'package:self_service/page/room_detail_page/room_detail_page.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/page/style/text_style.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryAndRoomPage extends StatelessWidget {
  CategoryAndRoomPage({super.key});
  static const nameRoute = '/category-list-room-page';
  final NewListRoomCubit listCubit = NewListRoomCubit();
  final ChooseCategoryCubit categoryCubit = ChooseCategoryCubit();
  final ListRoomCubit roomCubit = ListRoomCubit();
  @override
  Widget build(BuildContext context) {
    OrderArgs orderData;
    listCubit.getData();
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return false;
          },
          child: Stack(children: <Widget>[
            Stack(children: [
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                left: 0,
                child: BlocBuilder<NewListRoomCubit, NewListRoomModel>(
                    bloc: listCubit,
                    builder: (context, listState) {
                      if (listState.isLoading) {
                        return Container(
                          color: CustomColorStyle.lightBlue(),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (listState.state != true) {
                        return SizedBox(
                          child:
                              Center(child: Text(listState.message.toString())),
                        );
                      } else {
                        categoryCubit.setData(listState.data!.category[0]);
                        return BlocBuilder<ChooseCategoryCubit, RoomCategory>(
                          bloc: categoryCubit,
                          builder: (context, categoryState) {
                            roomCubit.setData(listState.data?.room
                                    .where((room) =>
                                        room.roomCategory ==
                                        categoryState.roomCategoryName)
                                    .toList() ??
                                []);
                            return BlocBuilder<ListRoomCubit, List<RoomList>>(
                                bloc: roomCubit,
                                builder: (context, roomState) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: CustomColorStyle
                                                      .bluePrimary()),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 123,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 0.7,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: ListView.builder(
                                                          itemCount: listState
                                                              .data
                                                              ?.category
                                                              .length,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemBuilder: (context,
                                                              indexCategory) {
                                                            return InkWell(
                                                              onTap: () {
                                                                categoryCubit.setData(listState
                                                                        .data!
                                                                        .category[
                                                                    indexCategory]);
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  listState.data?.category[indexCategory].roomCategoryName ==
                                                                          categoryState
                                                                              .roomCategoryName
                                                                      ? AutoSizeText(
                                                                          listState.data?.category[indexCategory].roomCategoryName ??
                                                                              '',
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize: 13,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          minFontSize:
                                                                              8,
                                                                        )
                                                                      : AutoSizeText(
                                                                          listState.data?.category[indexCategory].roomCategoryName ??
                                                                              '',
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize: 12,
                                                                              color: Colors.white),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          minFontSize:
                                                                              8,
                                                                        ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          0.7,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }))
                                                ],
                                              ))),
                                      Expanded(
                                          flex: 14,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: CustomColorStyle
                                                    .lightBlue()),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 23),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 52,
                                                    ),
                                                    Text(
                                                      'Room',
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 21,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              CustomColorStyle
                                                                  .blackText()),
                                                    ),
                                                    const SizedBox(
                                                      height: 29,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      9),
                                                          constraints:
                                                              const BoxConstraints(
                                                                  minWidth:
                                                                      120),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  CustomColorStyle
                                                                      .darkBlue(),
                                                              borderRadius:
                                                                  BorderRadiusDirectional
                                                                      .circular(
                                                                          20)),
                                                          alignment:
                                                              Alignment.center,
                                                          child: SizedBox(
                                                            child: Text(
                                                              categoryState
                                                                  .roomCategoryName
                                                                  .toString(),
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                          height: 1,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Colors
                                                                      .grey),
                                                        ))
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 1,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                SizedBox(
                                                                    width: 21,
                                                                    height: 21,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/icon/tv.png',
                                                                    )),
                                                                const SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    categoryState
                                                                        .roomCategoryTv
                                                                        .toString(),
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            12),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .visible,
                                                                    maxLines: 3,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 26,
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: <Widget>[
                                                                SizedBox(
                                                                    width: 21,
                                                                    height: 21,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/icon/tag_price.png',
                                                                    )),
                                                                const SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Text(
                                                                  Currency.toRupiah(
                                                                      categoryState
                                                                          .price),
                                                                  style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          SizedBox(
                                                              width: 21,
                                                              height: 21,
                                                              child:
                                                                  Image.asset(
                                                                'assets/icon/pax.png',
                                                              )),
                                                          const SizedBox(
                                                            width: 6,
                                                          ),
                                                          Text(
                                                            "${categoryState.roomCategoryCapacity} pax",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ]),
                                                    categoryState.isToilet ==
                                                            true
                                                        ? Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <Widget>[
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <Widget>[
                                                                      SizedBox(
                                                                          width:
                                                                              21,
                                                                          height:
                                                                              21,
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/icon/toilet.png',
                                                                          )),
                                                                      const SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),
                                                                      Text(
                                                                        "Toilet",
                                                                        style: GoogleFonts.poppins(
                                                                            fontSize:
                                                                                12),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 1,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Expanded(
                                                      child: GridView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          childAspectRatio:
                                                              5 / 6,
                                                          crossAxisSpacing: 15,
                                                          mainAxisSpacing: 10,
                                                        ),
                                                        itemCount:
                                                            roomState.length,
                                                        itemBuilder: (context,
                                                            indexRoom) {
                                                          return InkWell(
                                                            onTap: () {
                                                              orderData = OrderArgs(
                                                                  roomCategory:
                                                                      categoryState
                                                                              .roomCategoryName ??
                                                                          '',
                                                                  roomCode:
                                                                      roomState[indexRoom]
                                                                              .roomCode ??
                                                                          '');
                                                              Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                      RoomDetailPage
                                                                          .nameRoute,
                                                                      arguments:
                                                                          orderData)
                                                                  .then(
                                                                      (argumenKembali) {
                                                                orderData =
                                                                    argumenKembali
                                                                        as OrderArgs;
                                                              });
                                                            },
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  AspectRatio(
                                                                    aspectRatio:
                                                                        1,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      child: Stack(
                                                                          children: [
                                                                            Positioned(
                                                                              left: 0,
                                                                              top: 0,
                                                                              right: 0,
                                                                              bottom: 0,
                                                                              child: CachedNetworkImage(
                                                                                fit: BoxFit.cover,
                                                                                imageUrl: roomState[indexRoom].roomImage ?? '',
                                                                                placeholder: (context, url) => const Padding(padding: EdgeInsets.all(80), child: CircularProgressIndicator()),
                                                                                errorWidget: (context, url, error) {
                                                                                  return Container(
                                                                                    color: Colors.blue,
                                                                                    child: const Center(
                                                                                      child: Text('NO IMAGE'),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 0,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        roomState[indexRoom]
                                                                            .roomCode
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                      Container(
                                                                          child: roomState[indexRoom].roomReady == true
                                                                              ? const SizedBox(
                                                                                  width: 0,
                                                                                  height: 0,
                                                                                )
                                                                              : const Icon(
                                                                                  Icons.running_with_errors,
                                                                                  size: 16,
                                                                                  color: Colors.blue,
                                                                                )
                                                                          // const Text(
                                                                          //     'digunakan',
                                                                          //     style:
                                                                          //         TextStyle(fontSize: 10),
                                                                          //   ),
                                                                          ),
                                                                    ],
                                                                  ),
                                                                ]),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ))
                                    ],
                                  );
                                });
                          },
                        );
                      }
                    }),
              ),
              Positioned(
                top: 10,
                right: 0,
                left: 0,
                child: SizedBox(
                  height: 42,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
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
                                    title: Center(
                                        child: Text('Batalkan Transaksi?', style: CustomTextStyle.titleAlertDialog(),)),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: CustomButtonStyle.cancel(),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Tidak', 
                                              style: CustomTextStyle.cancel(),)),
                                          ElevatedButton(
                                            style: CustomButtonStyle.confirm(),
                                            onPressed: () {
                                              Navigator.pushNamedAndRemoveUntil(context,SplashPage.nameRoute,(route) => false);
                                            },
                                            child: Text('Iya', style: CustomTextStyle.confirm(),))
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
              )
            ]),
          ]),
        ),
      ),
    );
  }
}
