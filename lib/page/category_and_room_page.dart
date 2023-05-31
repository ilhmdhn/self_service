import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/page/style/color_style.dart';

class CategoryAndRoomPage extends StatefulWidget {
  const CategoryAndRoomPage({super.key});
  static const nameRoute = '/category-list-room-page';
  @override
  State<CategoryAndRoomPage> createState() => _CategoryAndRoomPageState();
}

class _CategoryAndRoomPageState extends State<CategoryAndRoomPage> {
  @override
  Widget build(BuildContext context) {
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
                  )),
              Expanded(
                  flex: 14,
                  child: Container(
                    decoration:
                        BoxDecoration(color: CustomColorStyle.lightBlue()),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Column(
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
                                constraints:
                                    const BoxConstraints(minWidth: 120),
                                decoration: BoxDecoration(
                                    color: CustomColorStyle.darkBlue(),
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20)),
                                alignment: Alignment.center,
                                child: SizedBox(
                                  child: Text(
                                    "LARGE",
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
                                decoration:
                                    const BoxDecoration(color: Colors.grey),
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                    "60 inch x 2",
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 26,
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
                                    "95.000",
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
                                    "8 pax",
                                    style: GoogleFonts.poppins(fontSize: 12),
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
                                        'assets/icon/toilet.png',
                                      )),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "Toilet",
                                    style: GoogleFonts.poppins(fontSize: 12),
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
                      ),
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
