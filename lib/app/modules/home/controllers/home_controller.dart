import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:realtime_innovations_test/app/core/model/EmployeeM.dart';
import 'package:realtime_innovations_test/app/data/EmployeeDb.dart';
import 'package:realtime_innovations_test/app/routes/app_pages.dart';

class HomeController extends GetxController {
  var currentEmployee = <EmployeeM>[].obs;
  var oldEmployee = <EmployeeM>[].obs;
  var employeeDb = EmployeeDb();
  @override
  void onInit() {
    
    inItDataListener();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  addEmployee() {
    Get.toNamed(Routes.EMPLOYEE);
  }

  void inItDataListener() {
    GetStorage db = employeeDb.storage;
    getEmployees();
    db.listen(() {
      getEmployees();
    });
  }

  void getEmployees() {
   
    var allEmployees = employeeDb.getAllEmployees();
    print("All employee ${allEmployees.length}");
    currentEmployee.value = allEmployees
        .where((element) =>
            element.toDate == null ||
            element.toDate! > DateTime.now().millisecondsSinceEpoch)
        .toList();
    oldEmployee.value=allEmployees
        .where((element) =>
    element.toDate !=null && element.toDate! < DateTime.now().millisecondsSinceEpoch)
        .toList();
    print("Current Emp ${currentEmployee.length}");
    print("Olde Emp ${oldEmployee.length}");
  }

  void removeCurrent(int index) {
    currentEmployee.removeAt(index);
  }

  void removeOld(int index) {
    oldEmployee.removeAt(index);
  }

  void deleteFromDb(EmployeeM employeeM) {
    employeeDb.deleteEmployee(employeeM.emplyeeId!);
    Get.back();

  }
}
