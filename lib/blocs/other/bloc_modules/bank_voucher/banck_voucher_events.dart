part of 'bank_voucher_bloc.dart';


@immutable
abstract class BankVoucherScreenEvents {}

///all events of AuthenticationEvents

class BankVoucherListCallEvent extends BankVoucherScreenEvents {

  final int pageNo;
  final BankVoucherListRequest bankVoucherListRequest;

  BankVoucherListCallEvent(this.pageNo,this.bankVoucherListRequest);
}
class BankVoucherSearchByNameCallEvent extends BankVoucherScreenEvents {
  final BankVoucherSearchByNameRequest request;

  BankVoucherSearchByNameCallEvent(this.request);
}

class BankVoucherSearchByIDCallEvent extends BankVoucherScreenEvents {
  int id;
  final BankVoucherSearchByIDRequest request;

  BankVoucherSearchByIDCallEvent(this.id,this.request);
}


class BankVoucherDeleteCallEvent extends BankVoucherScreenEvents {
  final int pkID;

  final BankVoucherDeleteRequest bankVoucherDeleteRequest;

  BankVoucherDeleteCallEvent(this.pkID,this.bankVoucherDeleteRequest);
}



class TransectionModeCallEvent extends BankVoucherScreenEvents {
  final TransectionModeListRequest request;

  TransectionModeCallEvent(this.request);
}


class SearchBankVoucherCustomerListByNameCallEvent extends BankVoucherScreenEvents {
  final CustomerLabelValueRequest request;

  SearchBankVoucherCustomerListByNameCallEvent(this.request);
}

class BankDropDownCallEvent extends BankVoucherScreenEvents {
  final BankDropDownRequest request;

  BankDropDownCallEvent(this.request);
}


class BankVoucherSaveCallEvent extends BankVoucherScreenEvents {
  final int pkID;

  final BankVoucherSaveRequest bankVoucherSaveRequest;
  final BuildContext context;

  BankVoucherSaveCallEvent(this.context,this.pkID,this.bankVoucherSaveRequest,);
}

/*
class DailyActivityListCallEvent extends DailyActivityScreenEvents {

  final int pageNo;
  final DailyActivityListRequest dailyActivityListRequest;

  DailyActivityListCallEvent(this.pageNo,this.dailyActivityListRequest);
}

class DailyActivityDeleteByNameCallEvent extends DailyActivityScreenEvents {
  final int pkID;

  final DailyActivityDeleteRequest dailyActivityDeleteRequest;

  DailyActivityDeleteByNameCallEvent(this.pkID,this.dailyActivityDeleteRequest);
}


class TaskCategoryListCallEvent extends DailyActivityScreenEvents {

  final TaskCategoryListRequest taskCategoryListRequest;

  TaskCategoryListCallEvent(this.taskCategoryListRequest);
}

class DailyActivitySaveByNameCallEvent extends DailyActivityScreenEvents {
  final int pkID;

  final DailyActivitySaveRequest dailyActivitySaveRequest;

  DailyActivitySaveByNameCallEvent(this.pkID,this.dailyActivitySaveRequest);
}*/
