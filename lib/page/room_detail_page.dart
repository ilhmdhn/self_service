import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/room_detail_bloc.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RoomDetailPage extends StatelessWidget {
  RoomDetailPage({super.key});

  final RoomDetailCubit roomDetailCubit = RoomDetailCubit();

  @override
  Widget build(BuildContext context) {
    roomDetailCubit.getData('R05');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<RoomDetailCubit, RoomDetailResult>(
              bloc: roomDetailCubit,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                          height: 400,
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
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              'http://192.168.1.248:3001/image-room?name_file=${state.data?.roomGallery?[index].imageUrl.toString()}',
                            ),
                          )),
                    ),
                    Text('${state.data?.roomGallery?[0].imageUrl}'),
                  ],
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/splash', (Route<dynamic> route) => false);
                  },
                  child: const Text('Batal')),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.lime.shade800),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali')),
            ],
          )
        ],
      ),
    );
  }
}
