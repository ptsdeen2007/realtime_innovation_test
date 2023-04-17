// To parse this JSON data, do
//
//     final employeeM = employeeMFromJson(jsonString);

import 'dart:convert';

class EmployeeM {
  EmployeeM({
    this.name,
    this.designation,
    this.fromDate,
    this.toDate,
    this.emplyeeId,
  });

  String? name;
  String? designation;
  int? fromDate;
  int? toDate;
  int? emplyeeId;

  factory EmployeeM.fromRawJson(String str) => EmployeeM.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeM.fromJson(Map<String, dynamic> json) => EmployeeM(
    name: json["Name"],
    designation: json["Designation"],
    fromDate: json["FromDate"],
    toDate: json["ToDate"],
    emplyeeId: json["emplyeeId"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Designation": designation,
    "FromDate": fromDate,
    "ToDate": toDate,
    "emplyeeId": emplyeeId,
  };
}
