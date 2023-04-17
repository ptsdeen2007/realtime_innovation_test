import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:realtime_innovations_test/app/core/model/EmployeeM.dart';
import 'package:realtime_innovations_test/app/core/widget/date_widget.dart';
import 'package:realtime_innovations_test/app/data/EmployeeDb.dart';

class EmployeeController extends GetxController {
  bool isEdit = false;
  var tecRole = TextEditingController();
  var tecEmployeeNme = TextEditingController();
  var tecFromDate = TextEditingController();
  var tecToDate = TextEditingController();
  EmployeeM employeeM = EmployeeM();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  @override
  void onInit() {
    if(Get.arguments!=null){
      isEdit=true;
     employeeM= Get.arguments as EmployeeM;
     tecEmployeeNme.text=employeeM.name!;
     tecRole.text=employeeM.designation!;
     tecFromDate.text=shortDate.format(DateTime.fromMillisecondsSinceEpoch(employeeM.fromDate!));
     if(employeeM.toDate!=null){
       tecToDate.text=shortDate.format(DateTime.fromMillisecondsSinceEpoch(employeeM.toDate!));
     }
    }
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

  void changeRole(String item) {
    tecRole.text = item;
    employeeM.designation = item;
  }

  void setFromDate(DateTime dateTime) {
    tecFromDate.text = shortDate.format(dateTime);
    employeeM.fromDate = dateTime.millisecondsSinceEpoch;
  }

  void setTodate(DateTime? dateTime) {
    if (dateTime == null) {
      tecToDate.text = "No date";
    } else {
      tecToDate.text = shortDate.format(dateTime);
    }
    employeeM.toDate = dateTime?.millisecondsSinceEpoch;
  }

  void saveData() {
    if(formKey.currentState!.validate()){
      employeeM.name = tecEmployeeNme.text;
      if (!isEdit) {
        employeeM.emplyeeId = DateTime.now().millisecondsSinceEpoch;
      }
      EmployeeDb employeeDb=EmployeeDb();
      employeeDb.upsertEmployee(employeeM);
      Get.back();
      Get.snackbar("${isEdit?"Updated":"Saved"}!", "Employee ${isEdit?"Updated":"Saved"}",snackPosition: SnackPosition.BOTTOM);
    }
  }
}
