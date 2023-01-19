import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/counter_bloc.dart';
import 'package:self_service/bloc/image_url_bloc.dart';
import 'package:self_service/bloc/room_detail_bloc.dart';
import 'package:self_service/data/model/checkin_model.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:self_service/page/fnb_page.dart';
import 'package:self_service/page/splash_screen.dart';
import '../util/currency.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RoomDetailPage extends StatelessWidget {
  RoomDetailPage({super.key});
  static const nameRoute = '/room-detail';

  final RoomDetailCubit roomDetailCubit = RoomDetailCubit();
  final ImageUrlCubit imageUrlCubit = ImageUrlCubit();
  final CounterCubit guestCubit = CounterCubit();
  final CounterCubit durationCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    int? guestTotal = 0;
    int? durationTotal = 0;
    final checkinDataArgs =
        ModalRoute.of(context)!.settings.arguments as CheckinData;
    roomDetailCubit.getData(checkinDataArgs.checkinInfo.roomCode);
    imageUrlCubit.getImageRoom();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Informasi Ruangan'),
        ),
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
      body: SafeArea(
        child: BlocBuilder<RoomDetailCubit, RoomDetailResult>(
            bloc: roomDetailCubit,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                        options: CarouselOptions(
                            // aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal),
                        itemCount: state.data?.roomGallery?.length ?? 0,
                        itemBuilder: ((context, index, realIndex) =>
                            BlocBuilder<ImageUrlCubit, String>(
                              bloc: imageUrlCubit,
                              builder: (context, stateImageUrl) {
                                String imageUrl = stateImageUrl +
                                    (state.data?.roomGallery?[index].imageUrl
                                            .toString() ??
                                        '');
                                if (stateImageUrl == '') {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: AspectRatio(
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

                                        /*Image.network(
                                          imageUrl,
                                          fit: BoxFit.fill,
                                        ),*/
                                      ),
                                    ));
                              },
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.groups,
                                      color: Colors.blue,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Capacity ',
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${state.data?.roomDetail?.roomCapacity} pax',
                                  style: const TextStyle(fontSize: 26),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.money_rounded,
                                      color: Colors.green,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Price',
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  ],
                                ),
                                Text(
                                  Currency.toRupiah(
                                          state.data?.roomDetail?.roomPrice ??
                                              0)
                                      .toString(),
                                  style: const TextStyle(fontSize: 26),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.person_add,
                                      color: Colors.blue,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Jumlah Tamu',
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  ],
                                ),
                                BlocBuilder<CounterCubit, int>(
                                    bloc: guestCubit,
                                    builder: (context, stateGuest) {
                                      guestTotal = stateGuest;
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              guestCubit.decrement();
                                            },
                                            icon: const Icon(Icons
                                                .indeterminate_check_box_outlined),
                                            color: Colors.red,
                                          ),
                                          Text(
                                            stateGuest.toString(),
                                            style:
                                                const TextStyle(fontSize: 32),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              guestCubit.increment();
                                            },
                                            icon: const Icon(
                                                Icons.add_box_outlined),
                                            color: Colors.green,
                                          ),
                                        ],
                                      );
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.access_time_outlined,
                                      color: Colors.blue,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Durasi (jam)',
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  ],
                                ),
                                BlocBuilder<CounterCubit, int>(
                                    bloc: durationCubit,
                                    builder: (context, stateDuration) {
                                      durationTotal = stateDuration;
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                durationCubit.decrement();
                                              },
                                              icon: const Icon(Icons
                                                  .indeterminate_check_box_outlined),
                                              color: Colors.red),
                                          Text(
                                            stateDuration.toString(),
                                            style:
                                                const TextStyle(fontSize: 32),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                durationCubit.increment();
                                              },
                                              icon: const Icon(
                                                Icons.add_box_outlined,
                                                color: Colors.green,
                                              )),
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.fromLTRB(20, 10, 20, 10)),
            backgroundColor:
                const MaterialStatePropertyAll<Color>(Colors.green)),
        onPressed: () {
          Navigator.of(context)
              .pushNamed(FnBPage.nameRoute, arguments: checkinDataArgs);
        },
        child: const Text('Lanjut'),
      ),
    );
  }
}
