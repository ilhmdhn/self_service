import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/bloc/input_bloc.dart';
import 'package:self_service/bloc/room_bloc.dart';
import 'package:self_service/data/model/room_category_model.dart';
import 'package:self_service/page/style/color_style.dart';

class CategoryAndRoomPage extends StatelessWidget {
  CategoryAndRoomPage({super.key});
  static const nameRoute = '/category-list-room-page';

  final RoomCategoryCubit roomCategoryCubit = RoomCategoryCubit();
  final ChooseCategoryRoom chooseCategoryCubit = ChooseCategoryRoom();
  final InputIntCubit indexChooseCategoryCubit = InputIntCubit();

  @override
  Widget build(BuildContext context) {
    roomCategoryCubit.getData();

    return Scaffold(
      body: Stack(children: <Widget>[
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
                                } else if (listCategoryState.state == false) {
                                  return Center(
                                    child: Text(
                                        listCategoryState.message.toString()),
                                  );
                                } else {
                                  chooseCategoryCubit
                                      .setData(listCategoryState.category?[0]);
                                  indexChooseCategoryCubit.setData(0);
                                  return BlocBuilder<InputIntCubit, int?>(
                                      bloc: indexChooseCategoryCubit,
                                      builder: (context, indexCategoryState) {
                                        return ListView.builder(
                                            itemCount: listCategoryState
                                                .category?.length
                                                .toInt(),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  chooseCategoryCubit.setData(
                                                      listCategoryState
                                                          .category?[index]);
                                                  indexChooseCategoryCubit
                                                      .setData(index);
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                        child:
                                                            indexCategoryState ==
                                                                    index
                                                                ? Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          listCategoryState
                                                                              .category![index]
                                                                              .roomCategoryName!,
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize: 18,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                : Text(
                                                                    listCategoryState
                                                                        .category![
                                                                            index]
                                                                        .roomCategoryName!,
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  )),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 0.7,
                                                      color: Colors.white,
                                                    ),
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
                            if (chooseCategoryState.roomCategoryName == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
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
                                              BorderRadiusDirectional.circular(
                                                  20)),
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
                                          style:
                                              GoogleFonts.poppins(fontSize: 12),
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
                                          chooseCategoryState.price.toString(),
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
                                          style:
                                              GoogleFonts.poppins(fontSize: 12),
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
                                          style:
                                              GoogleFonts.poppins(fontSize: 12),
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
                              ],
                            );
                          }),
                    ),
                  ))
            ],
          ),
        ),
        Positioned(
          top: 3,
          left: 3,
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
              width: 40,
              height: 40,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icon/home.png'),
              ),
            ))
      ]),
    );
  }
}
