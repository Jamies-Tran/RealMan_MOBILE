// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class BookingServiceModel extends Equatable {
  int dailyPlanServiceId;
  int staffId;
  String beginAtReq;
  BookingServiceModel({
    required this.dailyPlanServiceId,
    required this.staffId,
    required this.beginAtReq,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [dailyPlanServiceId, staffId, beginAtReq];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dailyPlanServiceId': dailyPlanServiceId,
      'staffId': staffId,
      'beginAtReq': beginAtReq,
    };
  }

  factory BookingServiceModel.fromMap(Map<String, dynamic> map) {
    return BookingServiceModel(
      dailyPlanServiceId: map['dailyPlanServiceId'] as int,
      staffId: map['staffId'] as int,
      beginAtReq: map['beginAtReq'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingServiceModel.fromJson(String source) =>
      BookingServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BookingModel extends Equatable {
  final int branchId;
  final int dailyPlanId;
  final List<BookingServiceModel> bookingServices;
  const BookingModel({
    required this.branchId,
    required this.dailyPlanId,
    required this.bookingServices,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'branchId': branchId,
      'dailyPlanId': dailyPlanId,
      'bookingServices': bookingServices.map((x) => x.toMap()).toList(),
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      branchId: map['branchId'] as int,
      dailyPlanId: map['dailyPlanId'] as int,
      bookingServices: List<BookingServiceModel>.from(
        (map['bookingServices'] as List<int>).map<BookingServiceModel>(
          (x) => BookingServiceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [branchId, dailyPlanId, bookingServices];
}

class BookingDetailModel extends Equatable {
  int? bookingServiceId;
  int? branchServiceId;
  int? bookingId;
  int? serviceId;
  int? dailyPlanServiceId;
  int? staffId;
  double? price;
  String? pickUpTypeCode;
  String? pickUpTypeName;
  String? beginAt;
  String? finishAt;
  String? actualBeginAt;
  String? actualFinishedAt;
  String? statusCode;
  String? statusName;
  String? action;

  BookingDetailModel({
    this.bookingServiceId,
    this.branchServiceId,
    this.bookingId,
    this.serviceId,
    this.dailyPlanServiceId,
    this.staffId,
    this.price,
    this.pickUpTypeCode,
    this.pickUpTypeName,
    this.beginAt,
    this.finishAt,
    this.actualBeginAt,
    this.actualFinishedAt,
    this.statusCode,
    this.statusName,
    this.action,
  });

  @override
  List<Object?> get props => [
        bookingServiceId,
        branchServiceId,
        bookingId,
        serviceId,
        dailyPlanServiceId,
        staffId,
        price,
        pickUpTypeCode,
        pickUpTypeName,
        beginAt,
        finishAt,
        actualBeginAt,
        actualFinishedAt,
        statusCode,
        statusName,
        action,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookingServiceId': bookingServiceId,
      'branchServiceId': branchServiceId,
      'bookingId': bookingId,
      'serviceId': serviceId,
      'dailyPlanServiceId': dailyPlanServiceId,
      'staffId': staffId,
      'price': price,
      'pickUpTypeCode': pickUpTypeCode,
      'pickUpTypeName': pickUpTypeName,
      'beginAt': beginAt,
      'finishAt': finishAt,
      'actualBeginAt': actualBeginAt,
      'actualFinishedAt': actualFinishedAt,
      'statusCode': statusCode,
      'statusName': statusName,
      'action': action,
    };
  }

  factory BookingDetailModel.fromMap(Map<String, dynamic> map) {
    return BookingDetailModel(
      bookingServiceId: map['bookingServiceId'] != null
          ? map['bookingServiceId'] as int
          : null,
      branchServiceId:
          map['branchServiceId'] != null ? map['branchServiceId'] as int : null,
      bookingId: map['bookingId'] != null ? map['bookingId'] as int : null,
      serviceId: map['serviceId'] != null ? map['serviceId'] as int : null,
      dailyPlanServiceId: map['dailyPlanServiceId'] != null
          ? map['dailyPlanServiceId'] as int
          : null,
      staffId: map['staffId'] != null ? map['staffId'] as int : null,
      price: map['price'] != null ? map['price'] as double : null,
      pickUpTypeCode: map['pickUpTypeCode'] != null
          ? map['pickUpTypeCode'] as String
          : null,
      pickUpTypeName: map['pickUpTypeName'] != null
          ? map['pickUpTypeName'] as String
          : null,
      beginAt: map['beginAt'] != null ? map['beginAt'] as String : null,
      finishAt: map['finishAt'] != null ? map['finishAt'] as String : null,
      actualBeginAt:
          map['actualBeginAt'] != null ? map['actualBeginAt'] as String : null,
      actualFinishedAt: map['actualFinishedAt'] != null
          ? map['actualFinishedAt'] as String
          : null,
      statusCode:
          map['statusCode'] != null ? map['statusCode'] as String : null,
      statusName:
          map['statusName'] != null ? map['statusName'] as String : null,
      action: map['action'] != null ? map['action'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingDetailModel.fromJson(Map<String, dynamic> source) =>
      BookingDetailModel.fromMap(source);
}
