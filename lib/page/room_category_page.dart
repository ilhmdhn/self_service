import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/image_url_bloc.dart';
import 'package:self_service/data/model/checkin_model.dart';
import 'package:self_service/data/model/room_category_model.dart';
import 'package:self_service/page/room_list_page.dart';
import 'package:self_service/page/splash_screen.dart';
import '../bloc/room_category_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RoomCategoryPage extends StatelessWidget {
  RoomCategoryPage({super.key});
  static const nameRoute = '/room-category';

  final RoomCategoryCubit roomCategoryCubit = RoomCategoryCubit();
  final ImageUrlCubit imageUrlCubit = ImageUrlCubit();

  @override
  Widget build(BuildContext context) {
    roomCategoryCubit.getData();
    final checkinDataArgs =
        ModalRoute.of(context)!.settings.arguments as CheckinData;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: const Text('Category Room'),
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
      body: BlocBuilder<RoomCategoryCubit, RoomCategoryResult>(
          bloc: roomCategoryCubit,
          builder: (context, roomCategoryState) {
            if (roomCategoryState.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (roomCategoryState.state == false) {
              return Center(
                child: Text(roomCategoryState.message ?? 'Error'),
              );
            }
            return Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 5,
                  childAspectRatio: 4 / 3,
                  children: List.generate(
                      roomCategoryState.category?.length ?? 0, (index) {
                    imageUrlCubit.getImageRoomCategory();
                    return InkWell(
                      onTap: () {
                        checkinDataArgs.checkinInfo.roomType =
                            roomCategoryState.category![index].roomCategoryCode;
                        Navigator.of(context).pushNamed(RoomListPage.nameRoute, arguments: checkinDataArgs);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54, width: 0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(7),
                              child: BlocBuilder<ImageUrlCubit, String>(
                                bloc: imageUrlCubit,
                                builder: (context, stateImage) {
                                  String imageUrl = stateImage +
                                      roomCategoryState
                                          .category![index].roomCategoryImage
                                          .toString();
                                  if (stateImage != '') {
                                    return AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: imageUrl,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                                  child: Icon(Icons.error)),
                                          fit: BoxFit.fill,
                                        ),

                                        // Image.network(
                                        //   imageUrl,
                                        //   fit: BoxFit.fill,
                                        // ),
                                      ),
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                            ),
                            Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Text(
                                '${roomCategoryState.category![index].roomCategoryName}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 19),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
            );
          }),
    );
  }
}
