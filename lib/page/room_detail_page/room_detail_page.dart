import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/bloc/universal_bloc.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:self_service/page/room_detail_page/room_detail_bloc.dart';
import 'package:self_service/page/style/color_style.dart';
import '../../util/order_args.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RoomDetailPage extends StatefulWidget {
  const RoomDetailPage({super.key});
  static const nameRoute = '/room-detail-page';
  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  final RoomDetailCubit roomDetailCubit = RoomDetailCubit();
  final InputCubit imageCarouselUrlCubit = InputCubit();
  final InputIntCubit indexCarouselCubit = InputIntCubit();

  @override
  Widget build(BuildContext context) {
    final orderArgs = ModalRoute.of(context)!.settings.arguments as OrderArgs;
    roomDetailCubit.setData(orderArgs.roomCategory, orderArgs.roomCode);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, orderArgs);
        return false;
      },
      child: Scaffold(
          body: BlocBuilder<RoomDetailCubit, RoomDetailResult>(
        bloc: roomDetailCubit,
        builder: (context, roomDetailState) {
          if (roomDetailState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (roomDetailState.state == false) {
            return Center(
              child: Text("Error: ${roomDetailState.message ?? ""}"),
            );
          } else {
            return BlocBuilder<InputIntCubit, int?>(
                bloc: indexCarouselCubit,
                builder: (context, indexCarouselState) {
                  return Stack(
                    children: [
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: CarouselSlider.builder(
                            itemCount:
                                roomDetailState.data?.roomImageList?.length ??
                                    0,
                            options: CarouselOptions(
                                aspectRatio: 5 / 6,
                                enableInfiniteScroll: true,
                                reverse: false,
                                viewportFraction: 1,
                                autoPlay: false,
                                initialPage: indexCarouselState ?? 0,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollPhysics: const BouncingScrollPhysics(),
                                enlargeFactor: 0.3,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    const Duration(seconds: 2),
                                scrollDirection: Axis.horizontal),
                            itemBuilder: ((context, index, realIndex) {
                              imageCarouselUrlCubit.getData(
                                  roomDetailState.data?.roomImageList?[indexCarouselState??0]);
                              return BlocBuilder<InputCubit, String>(
                                bloc: imageCarouselUrlCubit,
                                builder: (context, imageUrlState) {
                                  indexCarouselCubit.setData(index);
                                  return CachedNetworkImage(
                                    imageUrl: imageUrlState,
                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: Container(
                                        color: Colors.amber,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                  );
                                },
                              );
                            }),
                          )),
                      Positioned(
                        top: 3,
                        left: 3,
                        right: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context, orderArgs);
                                },
                                icon: Image.asset('assets/icon/arrow_back.png'),
                                iconSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: IconButton(
                                onPressed: () {},
                                icon: Image.asset('assets/icon/home.png'),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColorStyle.lightBlue(),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(56.0), // Sudut kiri atas
                              topRight:
                                  Radius.circular(56.0), // Sudut kanan atas
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 26, right: 26, top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Text(
                                    roomDetailState.data?.roomCode ?? "no name",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 23,
                                        color: CustomColorStyle.blueText()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Text(
                                    roomDetailState.data?.roomCategory ??
                                        "no name",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: CustomColorStyle.blueText()),
                                  ),
                                ),
                                SizedBox(
                                  height: 76,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (BuildContext context,
                                        int indexListImage) {
                                      return InkWell(
                                        onTap: () {
                                          imageCarouselUrlCubit.getData(
                                              roomDetailState
                                                          .data?.roomImageList?[
                                                      indexListImage] ??
                                                  "");
                                          indexCarouselCubit
                                              .setData(indexListImage);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Container(
                                            height: 76,
                                            width: 76,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 0,
                                                    child: CachedNetworkImage(
                                                      imageUrl: roomDetailState
                                                                  .data
                                                                  ?.roomImageList?[
                                                              indexListImage] ??
                                                          "",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: indexCarouselState ==
                                                            indexListImage
                                                        ? Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            right: 0,
                                                            bottom: 0,
                                                            child: Container(
                                                              color: Colors
                                                                  .black54,
                                                            ))
                                                        : const SizedBox(),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }
        },
      )),
    );
  }
}
