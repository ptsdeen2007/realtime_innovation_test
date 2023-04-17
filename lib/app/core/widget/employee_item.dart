import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_innovations_test/app/core/widget/date_widget.dart';
import 'package:realtime_innovations_test/app/routes/app_pages.dart';

import '../model/EmployeeM.dart';

class EmployeeItem extends StatelessWidget {
  final EmployeeM employeeM;

  const EmployeeItem({Key? key, required this.employeeM}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Get.toNamed(Routes.EMPLOYEE,arguments: employeeM),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${employeeM.name}",
              style: Get.textTheme.titleSmall,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "${employeeM.designation}",
              style: Get.textTheme.caption,
            ),
            SizedBox(
              height: 8,
            ),
            if (employeeM.toDate != null)
              Text(
                "${shortDate.format(DateTime.fromMillisecondsSinceEpoch(employeeM.fromDate!))} - ${shortDate.format(DateTime.fromMillisecondsSinceEpoch(employeeM.toDate!))}",
                style: Get.textTheme.caption,
              )
            else
              Text(
                "${shortDate.format(DateTime.fromMillisecondsSinceEpoch(employeeM.fromDate!))}",
                style: Get.textTheme.caption,
              ),
          ],
        ),
      ),
    );
  }
}
