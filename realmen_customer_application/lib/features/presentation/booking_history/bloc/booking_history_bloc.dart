import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realmen_customer_application/features/data/models/booking_model.dart';
import 'package:realmen_customer_application/features/domain/repository/BookingRepo/booking_repository.dart';

part 'booking_history_event.dart';
part 'booking_history_state.dart';

class BookingHistoryBloc
    extends Bloc<BookingHistoryEvent, BookingHistoryState> {
  BookingHistoryBloc() : super(BookingHistoryInitial()) {
    on<BookingHistoryInitialEvent>(_bookingHistoryInitialEvent);
  }

  FutureOr<void> _bookingHistoryInitialEvent(BookingHistoryInitialEvent event,
      Emitter<BookingHistoryState> emit) async {
    emit(BookingHistoryLoadingState());
    IBookingRepository bookingRepository = BookingRepository();
    try {
      DateTime now = DateTime.now();

      DateTime to = DateTime(now.year, now.month, 1);
      DateTime from = (now.month < 12)
          ? DateTime(now.year, now.month + 1, 1)
          : DateTime(now.year + 1, 1, 1);
      from = from.subtract(const Duration(days: 1));
      List<BookingDetailModel> bookingDetailList = [];
      var bookingDetails = await bookingRepository.GetAllBooking(
          to.toIso8601String(), from.toIso8601String(), "DRAFT");

      var bookingDetailsStatus = bookingDetails["status"];
      var bookingDetailsBody = bookingDetails["body"];
      if (bookingDetailsStatus) {
        bookingDetailList = (bookingDetailsBody['content'] as List)
            .map((e) => BookingDetailModel.fromJson(e as Map<String, dynamic>))
            .toList();
        for (BookingDetailModel bookingDetail in bookingDetailList) {}
      }
    } catch (e) {}
  }
}
