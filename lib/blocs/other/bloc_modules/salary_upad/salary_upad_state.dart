part of 'salary_upad_bloc.dart';





abstract class SalaryUpadScreenStates extends BaseStates {
  const SalaryUpadScreenStates();
}

///all states of AuthenticationStates

class SalaryUpadScreenStatesInitialState extends SalaryUpadScreenStates {}

class SalaryUpadListResponseState extends SalaryUpadScreenStates {

  final LoanListResponse loanListResponse;
  final int newPage;

  SalaryUpadListResponseState(this.newPage,this.loanListResponse);
}

class SalaryUpadSearchResponseState extends SalaryUpadScreenStates {
  final LoanListResponse employeeListResponse;

  SalaryUpadSearchResponseState(this.employeeListResponse);
}

class SalaryUpadDeleteResponseState extends SalaryUpadScreenStates {
  final BankVoucherDeleteResponse bankVoucherDeleteResponse;

  SalaryUpadDeleteResponseState(this.bankVoucherDeleteResponse);
}