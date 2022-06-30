part of 'loan_bloc.dart';



abstract class LoanScreenStates extends BaseStates {
  const LoanScreenStates();
}

///all states of AuthenticationStates

class LoanScreenInitialState extends LoanScreenStates {}

class LoanListResponseState extends LoanScreenStates {

  final LoanListResponse loanListResponse;
  final int newPage;

  LoanListResponseState(this.newPage,this.loanListResponse);
}

class LoanSearchResponseState extends LoanScreenStates {
  final LoanListResponse employeeListResponse;

  LoanSearchResponseState(this.employeeListResponse);
}

class LoanDeleteResponseState extends LoanScreenStates {
  final BankVoucherDeleteResponse bankVoucherDeleteResponse;

  LoanDeleteResponseState(this.bankVoucherDeleteResponse);
}

class LoanApprovalListResponseState extends LoanScreenStates {
  final LoanListResponse employeeListResponse;

  LoanApprovalListResponseState(this.employeeListResponse);
}