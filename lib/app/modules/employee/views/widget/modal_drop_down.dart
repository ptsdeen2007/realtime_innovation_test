import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_innovations_test/app/core/AppColor.dart';
import 'package:realtime_innovations_test/app/modules/employee/controllers/employee_controller.dart';
import 'package:realtime_innovations_test/app/modules/employee/views/employee_view.dart';

class ModalDropDown extends StatelessWidget {
  String _selected = '';

  List<String> _items = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];
  var employeeController = Get.find<EmployeeController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: employeeController.tecRole,
            decoration: InputDecoration(
                prefixIcon: Image.asset("images/job.png"),
                hintText: "Select role",
                border: textFieldBorder,
                contentPadding: EdgeInsets.zero,
                suffixIcon: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: iconColor,
                )),
            readOnly: true,
            onTap: () => showModal(context),
            validator: (text)=>text!.isEmpty?"Please Enter Role":null,
          ),
          // Text('Selected item: $_selected')
        ],
      ),
    );
  }

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
            padding: EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 8),
            height: 200,
            alignment: Alignment.center,
            child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (context, int) {
                  return Divider(height: 0,);
                },
                itemBuilder: (context, index) {
                  return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(child: Text(_items[index])),
                      ),
                      onTap: () {
                        employeeController.changeRole(_items[index]);
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }
}
