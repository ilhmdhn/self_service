import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/bloc/universal_bloc.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:self_service/page/register_puppy_club/register_club_page.dart';
import 'package:self_service/page/room_detail_page/room_detail_bloc.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/util/currency.dart';
import '../../util/order_args.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';

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
  final CarouselController _carouselController = CarouselController();
  OrderArgs orderArgs = OrderArgs();

  @override
  Widget build(BuildContext context) {
    orderArgs = ModalRoute.of(context)!.settings.arguments as OrderArgs;
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
            return Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount:
                          roomDetailState.data?.roomImageList?.length ?? 0,
                      options: CarouselOptions(
                          aspectRatio: 5 / 6,
                          enableInfiniteScroll: true,
                          reverse: false,
                          viewportFraction: 1,
                          autoPlay: false,
                          // scrollPhysics: const FixedExtentScrollPhysics(),
                          scrollPhysics: const PageScrollPhysics(),
                          autoPlayCurve: Curves.easeInOut,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.1,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration: const Duration(seconds: 4),
                          scrollDirection: Axis.horizontal),
                      itemBuilder: ((context, indexCarousel, realIndex) {
                        imageCarouselUrlCubit.getData(roomDetailState
                            .data?.roomImageList?[indexCarousel]);
                        //tandai atas
                        indexCarouselCubit.setData(indexCarousel);
                        return BlocBuilder<InputCubit, String>(
                          bloc: imageCarouselUrlCubit,
                          builder: (context, imageUrlState) {
                            return CachedNetworkImage(
                              imageUrl:
                                  'https://adm.happypuppy.id/$imageUrlState',
                              fit: BoxFit.fill,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: Container(
                                  color: Colors.white,
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
                        width: 44,
                        height: 44,
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
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
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
                        topRight: Radius.circular(56.0), // Sudut kanan atas
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 26, right: 26, top: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Text(
                              roomDetailState.data?.roomCode ?? "room code",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 23,
                                height: 0.9,
                                color: CustomColorStyle.blueText(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Text(
                              roomDetailState.data?.roomCategory ?? "room type",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 0.9,
                                color: CustomColorStyle.blueText(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 68,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  roomDetailState.data?.roomImageList?.length ??
                                      0,
                              itemBuilder:
                                  (BuildContext context, int indexListImage) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _carouselController
                                          .jumpToPage(indexListImage);
                                    });
                                    indexCarouselCubit.setData(indexListImage);
                                    imageCarouselUrlCubit.getData(
                                        roomDetailState.data?.roomImageList?[
                                                indexListImage] ??
                                            "");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Container(
                                      height: 76,
                                      width: 76,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://adm.happypuppy.id/${roomDetailState.data?.roomImageList?[indexListImage]}',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            BlocBuilder<InputIntCubit, int?>(
                                                bloc: indexCarouselCubit,
                                                builder: (context,
                                                    indexCarouselState) {
                                                  return Container(
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
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
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
                                    roomDetailState.data?.roomTvDetail ??
                                        "Tidak ada",
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    width: 34,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        Currency.toRupiah(
                                            roomDetailState.data?.roomPrice),
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                    "${roomDetailState.data?.roomPax} pax",
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                              child: roomDetailState.data?.roomToilet == true
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                      ],
                                    )
                                  : const SizedBox(
                                      height: 29,
                                    )),
                          const SizedBox(
                            height: 26,
                          ),
                          Container(
                            width: double.infinity,
                            height: 0.9,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                              child: roomDetailState.data?.roomReady == true
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 34),
                                          backgroundColor:
                                              CustomColorStyle.blueLight(),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      225.0))),
                                      onPressed: () {
                                        showDialogCheckinDuration(context);
                                      },
                                      child: Text(
                                        'PILIH RUANGAN',
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 34),
                                          backgroundColor: Colors.grey.shade300,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      225.0))),
                                      onPressed: () {
                                        // Fluttertoast.showToast(
                                        //     msg: "Setujui syarat dan ketentuan",
                                        //     toastLength: Toast.LENGTH_SHORT,
                                        //     gravity: ToastGravity.CENTER,
                                        //     timeInSecForIosWeb: 1,
                                        //     backgroundColor: Colors.red,
                                        //     textColor: Colors.white,
                                        //     fontSize: 16.0);
                                      },
                                      child: Text(
                                        'SEDANG DIGUNAKAN',
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: CustomColorStyle.blackText(),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      )),
    );
  }

  void showDialogCheckinDuration(BuildContext context) {
    InputIntCubit checkinDurationCubit = InputIntCubit();
    InputIntCubit paxCubit = InputIntCubit();
    checkinDurationCubit.setData(orderArgs.checkinDuration);
    paxCubit.setData(orderArgs.pax);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text('Checkin Info',
                    style: GoogleFonts.poppins(fontSize: 16))),
            content: BlocBuilder<InputIntCubit, int?>(
              bloc: checkinDurationCubit,
              builder: (context, checkinDurationState) {
                int checkinDuration = checkinDurationState ?? 0;
                return BlocBuilder<InputIntCubit, int?>(
                    bloc: paxCubit,
                    builder: (context, paxState) {
                      int pax = paxState ?? 0;
                      return SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Jam Checkin',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (checkinDurationState! > 1) {
                                            checkinDurationCubit
                                                .setData(--checkinDuration);
                                          }
                                        });
                                      },
                                      child: SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                              'assets/icon/minus.png')),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      checkinDuration.toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (checkinDurationState! < 6) {
                                            checkinDurationCubit
                                                .setData(++checkinDuration);
                                          }
                                        });
                                      },
                                      child: SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                              'assets/icon/plus.png')),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Jumlah Tamu',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (checkinDurationState! > 1) {
                                            paxCubit.setData(--pax);
                                          }
                                        });
                                      },
                                      child: SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                              'assets/icon/minus.png')),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      pax.toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          paxCubit.setData(++pax);
                                        });
                                      },
                                      child: SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                              'assets/icon/plus.png')),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            ElevatedButton(
                                style: CustomButtonStyle.buttonStyleDarkBlue(),
                                onPressed: () {
                                  Navigator.pop(context);
                                  orderArgs.checkinDuration = checkinDuration;
                                  Navigator.of(context)
                                      .pushNamed(RegisterClubPage.nameRoute,
                                          arguments: orderArgs)
                                      .then((argumenKembali) {
                                    orderArgs = argumenKembali as OrderArgs;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    "Lanjut",
                                    style: GoogleFonts.poppins(fontSize: 18),
                                  ),
                                ))
                          ],
                        ),
                      );
                    });
              },
            ),
          );
        });
  }
}
