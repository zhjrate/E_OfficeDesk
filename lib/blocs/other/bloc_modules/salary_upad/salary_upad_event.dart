part of 'salary_upad_bloc.dart';




@immutable
abstract class SalaryUpadScreenEvents {}

///all events of AuthenticationEvents

class SalaryUpadListCallEvent extends SalaryUpadScreenEvents {

  final int pageNo;
  final SalaryUpadListRequest listRequest;

  SalaryUpadListCallEvent(this.pageNo,this.listRequest);
}

class SalaryUpadSearchCallEvent extends SalaryUpadScreenEvents {

  final LoanSearchRequest employeeSearchRequest;

  SalaryUpadSearchCallEvent(this.employeeSearchRequest);
}

class SalaryUpadDeleteCallEvent extends SalaryUpadScreenEvents {
  final int pkID;

  final BankVoucherDeleteRequest bankVoucherDeleteRequest;

  SalaryUpadDeleteCallEvent(this.pkID,this.bankVoucherDeleteRequest);
}