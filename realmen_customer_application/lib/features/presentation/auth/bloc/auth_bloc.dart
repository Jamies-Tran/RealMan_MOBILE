import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realmen_customer_application/core/utils/utf8_encoding.dart';
import 'package:realmen_customer_application/features/data/models/account_model.dart';
import 'package:realmen_customer_application/features/data/shared_preferences/auth_pref.dart';

import '../../../domain/repository/AuthRepo/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  String? _phone;
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationInitialEvent>(_authenticationInitialEvent);
    on<AuthenticationShowCreateOtpEvent>(_authenticationShowCreateOtpEvent);
    on<AuthenticationShowLoginEvent>(_authenticationShowLoginEvent);
    on<AuthenticationShowRegisterEvent>(_authenticationShowRegisterEvent);
    on<AuthenticationInputPhoneEvent>(_authenticationInputPhoneEvent);
    on<AuthenticationLoginEvent>(_authenticationLoginEvent);
    on<AuthenticationRegisterEvent>(_authenticationRegisterEvent);
    on<AuthenticationInvalidPhoneInLoginEvent>(
        _authenticationInvalidPhoneInLoginEvent);
    on<AuthenticationInvalidOtpInLoginEvent>(
        _authenticationInvalidOtpInLoginEvent);
    on<AuthenticationResendOTPEvent>(_authenticationResendOTPEvent);
    on<AuthenticationStartCountdownEvent>(_authenticationStartCountdownEvent);
    on<CountdownTickEvent>(_countdownTickEvent);
  }

  //1
  FutureOr<void> _authenticationInitialEvent(
      AuthenticationInitialEvent event, Emitter<AuthenticationState> emit) {
    emit(ShowCreateOtpPageState());
  }

  //2
  FutureOr<void> _authenticationShowCreateOtpEvent(
      AuthenticationShowCreateOtpEvent event,
      Emitter<AuthenticationState> emit) {
    emit(ShowCreateOtpPageState(phone: event.phone));
  }

  FutureOr<void> _authenticationShowLoginEvent(
      AuthenticationShowLoginEvent event, Emitter<AuthenticationState> emit) {
    emit(ShowLoginPageState());
  }

  //3
  FutureOr<void> _authenticationShowRegisterEvent(
      AuthenticationShowRegisterEvent event,
      Emitter<AuthenticationState> emit) {
    emit(ShowRegisterPageState(phone: event.phone));
  }

  //4
  FutureOr<void> _authenticationInputPhoneEvent(
      AuthenticationInputPhoneEvent event,
      Emitter<AuthenticationState> emit) async {
    // emit(AuthenticationLoadingState(isLoading: true));
    // var results = await AuthRepository().createOtp(event.phone);
    // var responseMessage = results['message'];
    // var responseStatus = results['status'];

    // if (responseStatus) {
    //   emit(AuthenticationLoadingState(isLoading: false));
    //   _phone = event.phone;
    //   AuthPref.setPhone(event.phone.toString());
    //   emit(ShowLoginPageState());
    // } else if (!responseStatus && results['statusCode'] == 404) {
    //   emit(AuthenticationLoadingState(isLoading: false));
    //   emit(ShowSnackBarActionState(
    //       message: responseMessage, status: responseStatus));
    //   emit(ShowRegisterPageState(phone: event.phone.toString()));
    // } else {
    //   emit(AuthenticationLoadingState(isLoading: false));
    //   emit(ShowSnackBarActionState(
    //       message: responseMessage, status: responseStatus));
    // }

    //no api
    AuthPref.setPhone(event.phone.toString());
    emit(ShowLoginPageState());
  }

  //5
  late String rawToken;
  FutureOr<void> _authenticationLoginEvent(
      AuthenticationLoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState(isLoading: true));
    try {
      var results = await AuthRepository().login(event.phone, event.otp);
      var responseMessage = results['message'];
      var responseStatus = results['status'];
      var responseBody = results['body'];
      if (responseStatus) {
        var role = responseBody['value']['roleCode'];
        if (role == 'CUSTOMER') {
          emit(AuthenticationLoadingState(isLoading: false));
          rawToken = responseBody['value']['accessToken'];
          var nameCus = responseBody['value']['lastName'];
          nameCus = Utf8Encoding().decode(nameCus);
          var cusId = responseBody['value']['accountId'];
          // save info acc
          AuthPref.setToken(rawToken);
          AuthPref.setNameCus(nameCus);
          AuthPref.setRole(role);
          AuthPref.setCusId(cusId);
          close();
          emit(ShowSnackBarActionState(
              message: "Đăng nhập thành công", status: responseStatus));
          emit(AuthenticationSuccessState(token: rawToken));
          emit(ShowLandingPageState());
        } else {
          emit(AuthenticationLoadingState(isLoading: false));
          emit(ShowSnackBarActionState(
              message: "Xin đăng nhập bằng tài khoản khách hàng",
              status: false));
        }
      } else {
        emit(AuthenticationLoadingState(isLoading: false));
        emit(ShowSnackBarActionState(
            message: responseMessage, status: responseStatus));
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  //6
  FutureOr<void> _authenticationRegisterEvent(AuthenticationRegisterEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState(isLoading: true));
    String phone = event.phone;
    String firstName = event.firstName;
    String lastName = event.lastName;
    String dob = event.dob;
    String genderName = event.gender;
    String genderCode = genderName == "NAM" ? "MALE" : "FEMALE";
    String thumbnail = event.thumbnail;

    AccountModel accountModel = AccountModel(
      phone: phone,
      firstName: firstName,
      lastName: lastName,
      dob: dob,
      genderName: genderName,
      genderCode: genderCode,
      thumbnail: thumbnail,
    );

    var results = await AuthRepository().register(accountModel);
    var responseMessage = results['message'];
    var responseStatus = results['status'];
    // ignore: unused_local_variable
    var responseBody = results['body'];
    if (responseStatus) {
      emit(AuthenticationLoadingState(isLoading: false));
      emit(ShowSnackBarActionState(
          message: "Đăng ký thành công", status: responseStatus));
      emit(ShowCreateOtpPageState(phone: phone));
    } else {
      emit(AuthenticationLoadingState(isLoading: false));
      emit(ShowSnackBarActionState(
          message: responseMessage, status: responseStatus));
    }
  }

  //7
  FutureOr<void> _authenticationInvalidPhoneInLoginEvent(
      AuthenticationInvalidPhoneInLoginEvent event,
      Emitter<AuthenticationState> emit) {
    emit(AuthPageInvalidPhoneActionState());
  }

  //8
  FutureOr<void> _authenticationInvalidOtpInLoginEvent(
      AuthenticationInvalidOtpInLoginEvent event,
      Emitter<AuthenticationState> emit) {
    emit(AuthPageInvalidOtpActionState());
  }

  FutureOr<void> _authenticationResendOTPEvent(
      AuthenticationResendOTPEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(LoadingState());

    // var results = await AuthRepository().createOtp(_phone!);
    // var responseMessage = results['message'];
    // var responseStatus = results['status'];

    // if (responseStatus) {
    //   emit(AuthenticationLoadingState(isLoading: false));
    //   AuthPref.setPhone(_phone!.toString());
    //   emit(ShowLoginPageState());
    // } else if (!responseStatus && results['statusCode'] == 404) {
    //   emit(AuthenticationLoadingState(isLoading: false));
    //   emit(ShowSnackBarActionState(
    //       message: responseMessage, status: responseStatus));
    //   emit(ShowRegisterPageState(phone: _phone.toString()));
    // } else {
    //   emit(AuthenticationLoadingState(isLoading: false));
    //   emit(ShowSnackBarActionState(
    //       message: responseMessage, status: responseStatus));
    // }

    emit(AuthenticationResendOTPState());
  }

  Timer? _timer;
  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  FutureOr<void> _authenticationStartCountdownEvent(
      AuthenticationStartCountdownEvent event,
      Emitter<AuthenticationState> emit) {
    emit(CountdownInProgressState(countdown: 20));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(CountdownTickEvent());
    });
  }

  FutureOr<void> _countdownTickEvent(
      CountdownTickEvent event, Emitter<AuthenticationState> emit) {
    if (state is CountdownInProgressState) {
      final double countdownValue =
          (state as CountdownInProgressState).countdown!;
      emit(LoadingState());
      if (countdownValue > 0) {
        const Duration(seconds: 1);
        emit(CountdownInProgressState(countdown: countdownValue - 0.5));
      } else {
        _timer?.cancel();
        emit(CountdownFinishedState());
      }
    }
  }
}
