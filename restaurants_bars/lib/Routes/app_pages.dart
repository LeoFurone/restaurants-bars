import 'package:get/route_manager.dart';
import 'package:restaurants_bars/page1.dart';
import 'package:restaurants_bars/page2.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.INITIAL, page: () => Page1()),
    GetPage(name: Routes.PAGE2, page: () => const Page2())
  ];
}