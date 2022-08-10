part of 'loan_bloc.dart';



@immutable
abstract class LoanScreenEvents {}

///all events of AuthenticationEvents

class LoanListCallEvent extends LoanScreenEvents {

  final int pageNo;
  final LoanListRequest listRequest;

  LoanListCallEvent(this.pageNo,this.listRequest);
}

class LoanSearchCallEvent extends LoanScreenEvents {

  final LoanSearchRequest employeeSearchRequest;

  LoanSearchCallEvent(this.employeeSearchRequest);
}


class LoanDeleteCallEvent extends LoanScreenEvents {
  final int pkID;

  final BankVoucherDeleteRequest bankVoucherDeleteRequest;

  LoanDeleteCallEvent(this.pkID,this.bankVoucherDeleteRequest);
}


class LoanApprovalListCallEvent extends LoanScreenEvents {

  final LoanApprovalListRequest loanApprovalListRequest;

  LoanApprovalListCallEvent(this.loanApprovalListRequest);
}
class LoanApprovalSaveRequestCallEvent extends LoanScreenEvents {

  int pkID;
  final LoanApprovalSaveRequest loanApprovalSaveRequest;

  LoanApprovalSaveRequestCallEvent(this.pkID,this.loanApprovalSaveRequest);
}

