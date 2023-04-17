

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:realtime_innovations_test/app/core/widget/cancel_button.dart';
import 'package:realtime_innovations_test/app/core/widget/save_button.dart';
import 'package:realtime_innovations_test/app/modules/employee/views/widget/modal_drop_down.dart';
import 'package:realtime_innovations_test/app/modules/home/controllers/home_controller.dart';

import '../../../core/AppColor.dart';
import '../../../core/widget/date_widget.dart';
import '../controllers/employee_controller.dart';

const textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black12),
);
final  employeeController = Get.find<HomeController>();
class EmployeeView extends GetView<EmployeeController> {
   const EmployeeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var spaceHeight = SizedBox(height: 16);
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.isEdit ? "Edit " : "Add "}Employee Details'),
        leading: Container(),
        leadingWidth: 0,
        actions: [
          Visibility(
              visible: controller.isEdit,
              child: IconButton(
                  onPressed: () {
                    employeeController.deleteFromDb(controller.employeeM);
                    Get.snackbar("Deleted", "Employee data has been deleted",snackPosition: SnackPosition.BOTTOM);
                  }, icon: Icon(CupertinoIcons.delete)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Form(
                  key:controller.formKey ,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.person_outline, color: iconColor),
                        border: textFieldBorder,
                        hintText: "Employee name",
                        contentPadding: EdgeInsets.zero),
                    controller: controller.tecEmployeeNme,
                    validator: (text)=>text!.isEmpty?"Please Enter Name":null,
                  ),
                  spaceHeight,
                  ModalDropDown(),
                  spaceHeight,
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.tecFromDate,
                          onTap: () {
                            // controller.showFromDatePicker();
                            showFromDateDialog(true);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Image.asset("images/date.png"),
                            border: textFieldBorder,
                            hintText: "No date",
                            contentPadding: EdgeInsets.zero,
                          ),
                          readOnly: true,
                          validator: (text)=>text!.isEmpty?"Please Enter From Date":null,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt_rounded,
                        color: iconColor,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.tecToDate,
                          onTap: () {
                            showFromDateDialog(false);
                          },
                          decoration: InputDecoration(
                              prefixIcon: Image.asset("images/date.png"),
                              border: textFieldBorder,
                              hintText: "No date",
                              contentPadding: EdgeInsets.zero),
                          readOnly: true,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
            Divider(),
            ButtonBar(
              children: [
                CancelButton(onPressed: () {
                  Get.back();
                }),
                SaveButton(onPressed: () {
                  controller.saveData();
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showFromDateDialog(bool isFrom) {
    showDialog(
        context: Get.context!,
        builder: (_) => new AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
                  Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              return DateWidget(isFromDate: isFrom,);
            },
          ),
        )
    );
  }
}
