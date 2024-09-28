import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_customer_application/features/data/shared_preferences/shared_preferences.dart';
import 'package:realmen_customer_application/features/presentation/auth/bloc/auth_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/bloc/choose_branch_booking/booking_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/booking_haircut_temporary_page/bloc/booking_haircut_temporary_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking/pages/choose_branch_page/bloc/choose_branch_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/booking_history/bloc/booking_history_bloc.dart';
import 'package:realmen_customer_application/features/presentation/home/bloc/home_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/list_branch/bloc/list_branch_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/list_service/bloc/list_service_page_bloc.dart';
import 'package:realmen_customer_application/features/presentation/pages/landing_page/bloc/landing_page_bloc.dart';
import 'package:realmen_customer_application/firebase_options.dart';
import 'package:realmen_customer_application/features/presentation/pages/splash_page.dart';
import 'package:realmen_customer_application/core/router/router.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SharedPreferencesHelper.instance.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  _FBSignAnonymous();
  runApp(const MyApp());
}

Future<void> _FBSignAnonymous() async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    User? user = userCredential.user;
    print('Đăng nhập ẩn danh thành công: ${user!.uid}');
  } catch (e) {
    print('Lỗi không xác định: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthenticationBloc()),
          BlocProvider(create: (_) => LandingPageBloc()),
          BlocProvider(create: (_) => HomePageBloc()),
          BlocProvider(create: (_) => BookingBloc()),
          BlocProvider(create: (_) => ChooseBranchPageBloc()),
          BlocProvider(create: (_) => BookingHaircutTemporaryBloc()),
          BlocProvider(create: (_) => ListServicePageBloc()),
          BlocProvider(create: (_) => ListBranchPageBloc()),
          BlocProvider(create: (_) => BookingHistoryBloc()),
        ],
        child: GetMaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi'),
          ],
          getPages: RouteGenerator().routes(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey,
            textTheme: GoogleFonts.quicksandTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          initialRoute: SplashPage.SplashPageRoute,
        ),
      );
    });
  }
}
