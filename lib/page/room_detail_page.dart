import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/room_detail_bloc.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../util/currency.dart';

class RoomDetailPage extends StatelessWidget {
  RoomDetailPage({super.key});

  final RoomDetailCubit roomDetailCubit = RoomDetailCubit();

  @override
  Widget build(BuildContext context) {
    final roomCodeArgs = ModalRoute.of(context)!.settings.arguments;
    roomDetailCubit.getData(roomCodeArgs);
    return Scaffold(
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
                            height: 600,
                            aspectRatio: 16 / 9,
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
                        itemBuilder: ((context, index, realIndex) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'http://192.168.1.248:3001/image-room?name_file=${state.data?.roomGallery?[index].imageUrl.toString()}',
                                // height: 250,
                                // width: 1000,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
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
                                      size: 76,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Capacity ',
                                      style: TextStyle(fontSize: 56),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${state.data?.roomDetail?.roomCapacity} pax',
                                  style: const TextStyle(fontSize: 56),
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
                                      size: 76,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Price',
                                      style: TextStyle(fontSize: 56),
                                    ),
                                  ],
                                ),
                                Text(
                                  Currency.toRupiah(
                                          state.data?.roomDetail?.roomPrice ??
                                              0)
                                      .toString(),
                                  style: const TextStyle(fontSize: 56),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Colors.red),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.fromLTRB(30, 20, 30, 20)),
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
                                  const EdgeInsets.fromLTRB(30, 20, 30, 20)),
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.lime.shade800),
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
                                    const EdgeInsets.fromLTRB(30, 20, 30, 20)),
                                backgroundColor:
                                    const MaterialStatePropertyAll<Color>(
                                        Colors.green)),
                            onPressed: () {
                              if (state.data?.roomDetail?.roomIsReady == 0) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Room Sedang Digunakan"),
                                ));
                              } else {
                                Navigator.of(context)
                                    .pushNamed('/fnb-category');
                              }
                            },
                            child: const Text(
                              'Lanjut',
                              style: TextStyle(fontSize: 18),
                            ))
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
