import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/counter_bloc.dart';
import 'package:self_service/bloc/image_url_bloc.dart';
import 'package:self_service/bloc/room_list_bloc.dart';
import 'package:self_service/data/model/checkin_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:self_service/data/model/room_list_model.dart';
import 'package:self_service/page/room_detail_page.dart';
import 'package:self_service/page/splash_screen.dart';

class RoomListPage extends StatelessWidget {
  RoomListPage({super.key});
  static const nameRoute = '/room-list';

  final RoomListCubit roomListCubit = RoomListCubit();
  final ImageUrlCubit imageUrlCubit = ImageUrlCubit();
  final CounterCubit durationCubit = CounterCubit();
  final CounterCubit guestCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    final checkinDataArgs =
        ModalRoute.of(context)!.settings.arguments as CheckinData;
    roomListCubit.getData(checkinDataArgs.checkinInfo.roomType);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${checkinDataArgs.checkinInfo.roomType}')),
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
      body: BlocBuilder<RoomListCubit, RoomListResult>(
          bloc: roomListCubit,
          builder: (context, roomListState) {
            if (roomListState.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (roomListState.state == false) {
              return Center(
                child: Text(roomListState.message.toString()),
              );
            }
            imageUrlCubit.getImageRoom();
            return Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 5,
                  childAspectRatio: 4 / 3,
                  children:
                      List.generate(roomListState.room?.length ?? 0, (index) {
                    return InkWell(
                      onTap: () {
                        checkinDataArgs.checkinInfo.roomCode =
                            roomListState.room![index].roomCode;
                        Navigator.of(context).pushNamed(
                            RoomDetailPage.nameRoute,
                            arguments: checkinDataArgs);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54, width: 0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BlocBuilder<ImageUrlCubit, String>(
                                    bloc: imageUrlCubit,
                                    builder: (context, stateImageUrl) {
                                      String imageUrl = stateImageUrl +
                                          (roomListState
                                                  .room?[index].roomImage ??
                                              "");
                                      if (stateImageUrl == '') {
                                        return const CircularProgressIndicator();
                                      }
                                      return AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: imageUrl,
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
                                            fit: BoxFit.fill,
                                          ),

                                          /*Image.network(
                                            stateImageUrl +
                                                roomListState.room![index]
                                                    .roomImage
                                                    .toString(),
                                            fit: BoxFit.cover,
                                          ),*/
                                        ),
                                      );
                                    }),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Name: ',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Text(
                                        roomListState.room![index].roomName
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Capacity: ',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black)),
                                    Text(
                                        '${roomListState.room![index].roomCapacity.toString()} PAX',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black))
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    );
                  })),
            );
          }),
    );
  }
}
