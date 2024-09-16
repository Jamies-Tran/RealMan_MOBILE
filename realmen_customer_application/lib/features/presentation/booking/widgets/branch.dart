// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/features/data/models/branch_model.dart';
import 'package:realmen_customer_application/features/data/models/service_model.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/booking_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_branch_page/choose_branch_page.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_service_page/choose_service_page.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch_choose_branch.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch_choose_date/branch_choose_date.dart';
import 'package:realmen_customer_application/features/presentation/booking/widgets/branch_choose_service.dart';

class BranchOptionBooking extends StatefulWidget {
  final BookingBloc bloc;
  Function? callback;
  BranchOptionBooking(this.callback, {super.key, required this.bloc});
  @override
  State<BranchOptionBooking> createState() => _BranchOptionBookingState();
}

class _BranchOptionBookingState extends State<BranchOptionBooking>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BranchDataModel? selectedBranch;
    List<ServiceDataModel> selectedServices = [];
    return BlocProvider.value(
      value: widget.bloc,
      child: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) async {
          switch (state.runtimeType) {
            case ShowBookingBranchState:
              Get.to(() => ChooseBranchesPage(bookingBloc: widget.bloc));

            case ChooseBranchBookingSelectBranchGetBackState:
              Get.back();

            case ChooseBranchBookingSelectedBranchState:
              selectedBranch = (state as ChooseBranchBookingSelectedBranchState)
                  .selectedBranch;
              selectedServices =
                  (state as ChooseBranchBookingSelectedBranchState)
                      .selectedServices;
              Get.back();

            case BookingShowServiceState:
              Get.to(() => ChooseServicesPage(
                  bookingBloc: widget.bloc,
                  branchId: selectedBranch!.branchId!,
                  selectedServices: selectedServices));
            case ChooseBranchBookingSelectServiceGetBackState:
              Get.back();
            case ChooseBranchBookingSelectedServiceState:
              selectedServices =
                  (state as ChooseBranchBookingSelectedServiceState)
                      .selectedServices;
              Get.back();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
              child: Column(
            children: [
              // 1 chon chi nhanh
              ChooseBranchBooking(bloc: widget.bloc),

              // 2 chon chi nhanh
              selectedBranch != null
                  ? ChooseServiceBooking(
                      bloc: widget.bloc,
                    )
                  : Container(),

              // 3 chon ngay
              selectedBranch != null && selectedServices.isNotEmpty
                  ? ChooseDateBooking(bloc: widget.bloc)
                  : Container(),

// 4 chon staff
              //   // icon

              // // button Đặt Lịch
              // selectedBranch.branchId != null && selectedService != []
              //     ? Column(
              //         children: [
              //           Container(
              //             width: 81.w,
              //             margin: const EdgeInsets.symmetric(horizontal: 15),
              //             padding: const EdgeInsets.all(0),
              //             decoration: BoxDecoration(
              //               gradient: const LinearGradient(
              //                   begin: Alignment.topLeft,
              //                   end: Alignment.bottomRight,
              //                   colors: [
              //                     Color(0xff302E2E),
              //                     Color(0xe6444141),
              //                     Color(0x8c484646),
              //                     Color(0x26444141),
              //                   ]),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: ElevatedButton(
              //               onPressed: () {
              //                 _onBooking();
              //               },
              //               style: ElevatedButton.styleFrom(
              //                 foregroundColor: Colors.black,
              //                 backgroundColor: Colors.black12,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(10.0),
              //                 ),
              //                 minimumSize: const Size(200, 50),
              //                 padding: const EdgeInsets.all(0),
              //                 shadowColor: Colors.transparent,
              //               ),
              //               child: const Text(
              //                 'Đặt Lịch',
              //                 style: TextStyle(
              //                     fontSize: 24,
              //                     color: Colors.white,
              //                     letterSpacing: 1.5,
              //                     fontWeight: FontWeight.w700),
              //               ),
              //             ),
              //           ),
              //           const Center(
              //             child: Text("Cắt xong trả tiền, hủy lịch không sao"),
              //           )
              //         ],
              //       )
              //     : Container(),

              const SizedBox(
                height: 20,
              ),
            ],
          ));
        },
      ),
    );
  }
}
