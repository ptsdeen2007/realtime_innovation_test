import 'package:get_storage/get_storage.dart';
import 'package:realtime_innovations_test/app/core/model/EmployeeM.dart';

class EmployeeDb{
  static final EmployeeDb _employeeDb=EmployeeDb._internal();
  factory EmployeeDb(){
    return _employeeDb;
  }
  EmployeeDb._internal();

  final _storage = GetStorage("employees");
  get storage=>_storage;

  void upsertEmployee(EmployeeM employeeM){
    _storage.write(employeeM.emplyeeId!.toString(), employeeM.toJson());
  }
  List<EmployeeM> getAllEmployees(){
    // print("GetKeys ${_storage.getKeys()}");
    print("GetValues ${_storage.getValues()}");
    return List<EmployeeM>.from(_storage.getValues().map((e)=>EmployeeM.fromJson(e))) ;
  }
  void deleteEmployee(int employeeIUId){
    _storage.remove(employeeIUId.toString());
  }
}