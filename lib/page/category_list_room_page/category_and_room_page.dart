import 'dart:js_interop';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/model/new_room_model.dart';
import 'package:self_service/page/category_list_room_page/category_and_room_bloc.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';

class CategoryAndRoomPage extends StatelessWidget {
  CategoryAndRoomPage({super.key});
  static const nameRoute = '/category-list-room-page';
  final NewListRoomCubit listCubit = NewListRoomCubit();
  final ChooseCategoryCubit categoryCubit = ChooseCategoryCubit();
  final ListRoomCubit roomCubit = ListRoomCubit();
  @override
  Widget build(BuildContext context) {
    listCubit.getData();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: BlocBuilder<NewListRoomCubit, NewListRoomModel>(
            bloc: listCubit,
            builder: (context, listState) {
              if (listState.isLoading) {
                return Container(
                  color: CustomColorStyle.blueLight(),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (listState.state != true) {
                return SizedBox(
                  child: Center(child: Text(listState.message.toString())),
                );
              } else {
                return BlocBuilder<ChooseCategoryCubit, RoomCategory>(
                  bloc: categoryCubit,
                  builder: (context, categoryState) {
                    return BlocBuilder<ListRoomCubit, List<RoomList>>(
                        bloc: roomCubit,
                        builder: (context, roomState) {
                          return SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                CustomColorStyle.bluePrimary()),
                                        child: Text('SUCCESS'))),
                                Expanded(
                                    flex: 14,
                                    child: Container(
                                      color: Colors.amber,
                                    ))
                              ],
                            ),
                          );
                        });
                  },
                );
              }
            }),
      ),
    );
  }
}