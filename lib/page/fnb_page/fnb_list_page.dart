import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/bloc/universal_bloc.dart';
import 'package:self_service/data/model/fnb_category.dart';
import 'package:self_service/data/model/fnb_model.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/page/fnb_page/fnb_bloc.dart';

class FnbListPage extends StatefulWidget {
  const FnbListPage({super.key});

  static const nameRoute = '/fnb-page';

  @override
  State<FnbListPage> createState() => _FnbListPageState();
}

class _FnbListPageState extends State<FnbListPage> {
  final FnBCategoryCubit fnBCategoryCubit = FnBCategoryCubit();
  final InputCubit chooseCategorCubit = InputCubit();
  final FnBCubit fnbCubit = FnBCubit();

  @override
  void initState() {
    fnBCategoryCubit.setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<InputCubit, String>(
              bloc: chooseCategorCubit,
              builder: (context, chooseCategoryState) {
                if (chooseCategoryState != '') {
                  fnbCubit.setData(chooseCategoryState);
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: CustomColorStyle.bluePrimary(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 117,
                              ),
                              Expanded(
                                  child: BlocBuilder<FnBCategoryCubit,
                                      FnBCategoryResult>(
                                bloc: fnBCategoryCubit,
                                builder: (context, fnbCategoryState) {
                                  if (fnbCategoryState.isLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (fnbCategoryState.state != true) {
                                    return Center(
                                      child: Text(
                                          fnbCategoryState.message.toString()),
                                    );
                                  } else if ((fnbCategoryState.data?.length ??
                                          0) ==
                                      0) {
                                    return const Center(
                                      child: Text('Data Kosong'),
                                    );
                                  }
                                  if (chooseCategoryState == '') {
                                    chooseCategorCubit.getData(
                                        fnbCategoryState.data?[0].categoryName);
                                  }
                                  return ListView.builder(
                                      itemCount:
                                          fnbCategoryState.data?.length.toInt(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            chooseCategorCubit.getData(
                                                fnbCategoryState
                                                    .data?[index].categoryName);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 5),
                                            child: Center(
                                              child: fnbCategoryState
                                                          .data?[index]
                                                          .categoryName ==
                                                      chooseCategoryState
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            fnbCategoryState
                                                                    .data?[
                                                                        index]
                                                                    .categoryName ??
                                                                '',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        const Icon(
                                                          Icons.circle,
                                                          color: Colors.white,
                                                          size:
                                                              12, // Ganti dengan ukuran yang Anda inginkan
                                                        )
                                                      ],
                                                    )
                                                  : Text(
                                                      fnbCategoryState
                                                              .data?[index]
                                                              .categoryName ??
                                                          '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ))
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          color: CustomColorStyle.lightBlue(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 65,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 33),
                                child: Text(
                                  'Food',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 33),
                                child: SizedBox(
                                  height: 30,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        // searchText = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'search',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        suffixIcon: const Icon(Icons.search),
                                        filled: true,
                                        fillColor: CustomColorStyle.lightGrey(),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        suffixIconColor: Colors.grey.shade600),
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey.shade900),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 33),
                                child: Row(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: CustomColorStyle.darkBlue(),
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                20)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      child: Text(
                                        chooseCategoryState,
                                        style: GoogleFonts.poppins(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1.3,
                                      color: Colors.black,
                                    ),
                                  )
                                ]),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                  child: BlocBuilder<FnBCubit, FnBResultModel>(
                                bloc: fnbCubit,
                                builder: (context, fnbState) {
                                  if (fnbState.isLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (fnbState.state != true) {
                                    return Center(
                                      child: Text(fnbState.message.toString()),
                                    );
                                  } else if ((fnbState.data?.isEmpty ??
                                          List.empty()) ==
                                      []) {
                                    return const Center(
                                      child: Text('Kosong'),
                                    );
                                  }
                                  return GridView.builder(
                                      itemCount: fnbState.data?.length ?? 0,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 5 / 6,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemBuilder: (context, indexFnb) {
                                        return InkWell(
                                          child: Container(
                                            color: Colors.amber,
                                          ),
                                        );
                                      });
                                },
                              ))
                            ],
                          ),
                        ))
                  ],
                );
              }),
          Positioned(
            top: 6,
            left: 7,
            right: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 29,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 45,
                  height: 45,
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
                                          Navigator.pushNamedAndRemoveUntil(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
