import 'package:get/get.dart';

import '../modules/employee/bindings/employee_binding.dart';
import '../modules/employee/views/employee_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  // static const INITIAL = Routes.EMPLOYEE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.EMPLOYEE,
      page: () => const EmployeeView(),
      binding: EmployeeBinding(),
    ),
  ];
}
