import 'package:get/get.dart';

import '../modules/approve/bindings/approve_binding.dart';
import '../modules/approve/views/approve_view.dart';
import '../modules/boking/bindings/boking_binding.dart';
import '../modules/boking/views/boking_view.dart';
import '../modules/bookingmasuk/bindings/bookingmasuk_binding.dart';
import '../modules/bookingmasuk/views/bookingmasuk_view.dart';
import '../modules/detail_history/bindings/detail_history_binding.dart';
import '../modules/detail_history/views/detail_history_view.dart';
import '../modules/general_checkup/bindings/general_checkup_binding.dart';
import '../modules/general_checkup/views/general_checkup_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/componen/buttomnavigationbar.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/promek/bindings/promek_binding.dart';
import '../modules/promek/views/chat_view.dart';
import '../modules/repair_maintenen/bindings/repair_maintenen_binding.dart';
import '../modules/repair_maintenen/views/repair_maintenen_view.dart';
import '../modules/selesaidikerjakan/bindings/selesaidikerjakan_binding.dart';
import '../modules/selesaidikerjakan/views/selesaidikerjakan_view.dart';
import '../modules/selesaiservice/bindings/selesaiservice_binding.dart';
import '../modules/selesaiservice/views/selesaiservice_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/splashcreen/bindings/splashcreen_binding.dart';
import '../modules/splashcreen/views/splashcreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.BOKING,
      page: () => BokingView(),
      binding: BokingBinding(),
    ),
    GetPage(
      name: _Paths.PKB,
      page: () => PKB(),
      binding: PromekBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.GENERAL_CHECKUP,
      page: () => GeneralCheckupView(),
      binding: GeneralCheckupBinding(),
    ),
    GetPage(
      transition: Transition.zoom,
      name: _Paths.SPLASHCREEN,
      page: () => SplashcreenView(),
      binding: SplashcreenBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.REPAIR_MAINTENEN,
      page: () => const RepairMaintenenView(),
      binding: RepairMaintenenBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.APPROVE,
      page: () => ApproveView(),
      binding: ApproveBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.BOOKINGMASUK,
      page: () =>  BookingmasukView(),
      binding: BookingmasukBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.SELESAISERVICE,
      page: () => const SelesaiserviceView(),
      binding: SelesaiserviceBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.SELESAIDIKERJAKAN,
      page: () => const SelesaidikerjakanView(),
      binding: SelesaidikerjakanBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.DETAIL_HISTORY,
      page: () => const DetailHistoryView(),
      binding: DetailHistoryBinding(),
    ),
  ];
}
