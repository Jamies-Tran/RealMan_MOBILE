// ignore_for_file: constant_identifier_names, avoid_print, prefer_conditional_assignment

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/features/presentation/home/bloc/home_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/list_branch/list_branches.dart';

import 'package:sizer/sizer.dart';

class BranchesOverviewScreen extends StatefulWidget {
  final HomePageBloc bloc;
  const BranchesOverviewScreen({super.key, required this.bloc});

  @override
  State<BranchesOverviewScreen> createState() => _BranchesOverviewScreenState();
  static const String BranchesOverviewScreenRoute = "/branches-overview-screen";
}

class _BranchesOverviewScreenState extends State<BranchesOverviewScreen> {
  @override
  void initState() {
    print('Current Route: ${Get.currentRoute}');
    widget.bloc.add(LoadedBranchProvinceListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      bloc: widget.bloc,
      builder: (context, state) {
        LoadedBranchProvinceListState? successState;
        if (state is LoadedBranchProvinceListState) {
          successState = state;
        }
        return state.runtimeType == LoadingBranchProvinceListState
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: 50,
                    width: 50,
                    child: const CircularProgressIndicator(),
                  )
                ],
              )
            : state.runtimeType == LoadedBranchProvinceListState
                ? Scaffold(
                    body: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/bg.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        SafeArea(
                            child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 15,
                              bottom: 27,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 0),
                                  width: 90.w,
                                  height: 90.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: ListView(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(left: 7),
                                        child: Center(
                                          child: Stack(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                child: IconButton(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  color: Colors.black,
                                                  iconSize: 22,
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_left),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                    "hệ thống chi nhánh"
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                              height: 160,
                                              decoration: const BoxDecoration(
                                                  color: Colors.black)),
                                          Image.asset(
                                            "assets/images/Logo-White-NoBG-O-15.png",
                                            width: 360,
                                            height: 160,
                                          ),
                                          Container(
                                            height: 160,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "các barber CỦA REALMEN"
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const Text(
                                                  // "Tận hưởng trải nghiệm cắt tóc nam đỉnh \ncao tại hơn $count barber RealMen trải dài khắp \n${city1 ?? ""}${city2 != null ? ', $city2 ' : ''} ${city1 != null || city2 != null ? 'và ' : ''}các tỉnh lân cận!",
                                                  "Tận hưởng trải nghiệm cắt tóc nam đỉnh \ncao tại các chi nhánh của RealMen trải dài khắp \n Hà Nội, TP.HCM và các tỉnh lân cận!",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    height: 1.4,
                                                  ),
                                                  // textAlign: TextAlign.justify,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: successState!
                                            .branchProvinceList.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  // color: Colors.amberAccent,
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color:
                                                              Color(0x4D444444),
                                                          width: 1.0),
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          ListBranchesScreen
                                                              .ListBranchesScreenRoute,
                                                          arguments: successState!
                                                              .branchProvinceList[
                                                                  index]
                                                              .province);
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              child: Text(
                                                                successState!
                                                                        .branchProvinceList[
                                                                            index]
                                                                        .province ??
                                                                    "",
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          5),
                                                              child: Text(
                                                                'Số lượng chi nhánh: ${successState.branchProvinceList[index].total}',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: Colors.black87,
                                                          size: 17,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        height: 50,
                        width: 50,
                        child: const CircularProgressIndicator(),
                      )
                    ],
                  );
      },
    );
  }
}
