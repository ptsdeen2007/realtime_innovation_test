import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import 'package:get/get.dart';
import 'package:realtime_innovations_test/app/core/AppColor.dart';
import 'package:realtime_innovations_test/app/core/model/EmployeeM.dart';
import 'package:realtime_innovations_test/app/core/widget/employee_item.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        // centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Icon(Icons.add),
        onPressed: () => controller.addEmployee(),
      ),
      body: Obx(() {
        return (controller.currentEmployee.value.isEmpty &&
                controller.oldEmployee.value.isEmpty)
            ? Center(
                child: Image.asset("images/placeholder.png"),
              )
            : ListView(
                children: [
                  Visibility(
                    visible: controller.currentEmployee.value.isNotEmpty,
                    child: Container(
                      color: Colors.black12,
                      child: ListTile(
                        title: Text(
                          "Current Employees",
                          style: TextStyle(color: iconColor),
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      separatorBuilder: (context, position) => Divider(
                            height: 0,
                          ),
                      itemCount: controller.currentEmployee.value.length,
                      itemBuilder: (context, index) {
                        var item = controller.currentEmployee.value[index];
                        return SwipeActionCell(
                          key: ObjectKey(
                              controller.currentEmployee.value[index]),

                          /// this key is necessary
                          trailingActions: <SwipeAction>[
                            SwipeAction(
                                icon: Icon(
                                  CupertinoIcons.delete_simple,
                                  color: Colors.white,
                                ),
                                onTap: (CompletionHandler handler) {
                                  controller.removeCurrent(index);
                                  shwoSnakeBar(
                                      context: context, employeeM: item);
                                },
                                color: Colors.red),
                          ],
                          child: EmployeeItem(
                            employeeM: item,
                          ),
                        );
                      }),
                  Visibility(
                    visible: controller.oldEmployee.value.isNotEmpty,
                    child: Container(
                      color: Colors.black12,
                      child: ListTile(
                        title: Text(
                          "Old Employees",
                          style: TextStyle(color: iconColor),
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      separatorBuilder: (context, position) => Divider(
                            height: 0,
                          ),
                      itemCount: controller.oldEmployee.value.length,
                      itemBuilder: (context, index) {
                        var item = controller.oldEmployee.value[index];
                        return SwipeActionCell(
                          key: ObjectKey(controller.oldEmployee.value[index]),

                          /// this key is necessary
                          trailingActions: <SwipeAction>[
                            SwipeAction(
                                onTap: (CompletionHandler handler) {
                                  controller.removeOld(index);
                                  shwoSnakeBar(
                                      context: context, employeeM: item);
                                },
                                color: Colors.red,
                                icon: Icon(
                                  CupertinoIcons.delete_simple,
                                  color: Colors.white,
                                )),
                          ],
                          child: EmployeeItem(
                            employeeM: item,
                          ),
                        );
                      }),
                ],
              );
      }),
    );
  }

  void shwoSnakeBar(
      {required BuildContext context, required EmployeeM employeeM}) {
    var timer = Timer(Duration(seconds: 4), () {
      controller.deleteFromDb(employeeM);
    });
    var snackBar = SnackBar(
      content: Text('Employee data has been deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          timer.cancel();
          controller.getEmployees();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
