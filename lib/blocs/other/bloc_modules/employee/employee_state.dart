part of 'employee_bloc.dart';



abstract class EmployeeScreenStates extends BaseStates {
  const EmployeeScreenStates();
}

///all states of AuthenticationStates

class EmployeeScreenInitialState extends EmployeeScreenStates {}

class EmployeeListResponseState extends EmployeeScreenStates {
  final EmployeeListResponse employeeListResponse;
  final int newPage;

  EmployeeListResponseState(this.newPage,this.employeeListResponse);
}

class EmployeeSearchResponseState extends EmployeeScreenStates {
  final EmployeeListResponse employeeListResponse;

  EmployeeSearchResponseState(this.employeeListResponse);
}

class EmployeeDeleteResponseState extends EmployeeScreenStates {
  final BankVoucherDeleteResponse bankVoucherDeleteResponse;

  EmployeeDeleteResponseState(this.bankVoucherDeleteResponse);
}