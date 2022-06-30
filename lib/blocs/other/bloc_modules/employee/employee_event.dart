part of 'employee_bloc.dart';



@immutable
abstract class EmployeeScreenEvents {}

///all events of AuthenticationEvents

class EmployeeListCallEvent extends EmployeeScreenEvents {

  final int pageNo;
  final EmployeeListRequest employeeListRequest;

  EmployeeListCallEvent(this.pageNo,this.employeeListRequest);
}

class EmployeeSearchCallEvent extends EmployeeScreenEvents {

  final EmployeeSearchRequest employeeSearchRequest;

  EmployeeSearchCallEvent(this.employeeSearchRequest);
}


class EmployeeDeleteCallEvent extends EmployeeScreenEvents {
  final int pkID;

  final BankVoucherDeleteRequest bankVoucherDeleteRequest;

  EmployeeDeleteCallEvent(this.pkID,this.bankVoucherDeleteRequest);
}